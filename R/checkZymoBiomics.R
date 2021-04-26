#' Compare ZymoBiomics to Experimental
#'
#' @name checkZymoBiomics
#'
#' @details A wrapper to build phylogenetic tree for ASV sequences
#'          obtained after \code{dada2}.
#'
#' @param x Phyloseq objects where taxa_names are ASV sequences
#'
#' @param mock_db Default is NULL and uses ZymoBiomics sequences
#'
#' @param multithread Passed on to dada2::assignTaxonomy Default is 2
#'
#' @param minBoot Passed on to dada2::assignTaxonomy. Default is 80
#'
#' @param ... Arguments to pass on to dada2::assignTaxonomy
#'
#' @examples
#' library(phyloseq)
#' ps.zym <- ZymoExamplePseq
#' taxa_names(ps.zym) <- refseq(ps.zym)
#' output.dat <- checkZymoBiomics(ps.zym,
#'                                mock_db = NULL,
#'                                multithread= 2,
#'                                minBoot = 80)
#' @author Sudarshan Shetty \email{sudarshanshetty9@gmail.com}
#'
#' @return List with pseq, plots and cor table
#'
#' @importFrom dplyr %>%
#' @importFrom tibble as_tibble
#'
#' @export

checkZymoBiomics <- function(x,
                             mock_db = NULL,
                             multithread= 2,
                             minBoot = 80,
                             ...) {


  sample.chkmks <- ZymoTheoretical <- row.sample <- NULL
  seqs <- phyloseq::taxa_names(x)
  new_tx <- .assign_zymo_taxonomy(seqs,
                                  mock_db = NULL,
                                  multithread=multithread,
                                  minBoot = multithread)

  nw_x <- .format_tax_table(x, taxa=new_tx)

  nw_x <- .get_species_comp(nw_x)

  # merge with theoretical
  phyloseq::sample_data(ZymoBiomicsPseq)$ZymoType <- "Theoretical"
  phyloseq::sample_data(nw_x)$ZymoType <- "UserSamples"

  zm.all.ps <- phyloseq::merge_phyloseq(nw_x, ZymoBiomicsPseq)
  # Check correlation
  tex_cor <- .check_zym_cor(zm.all.ps)
  tex_cor <- tex_cor %>%
    tibble::add_row(sample.chkmks= "ZymoTheoretical", ZymoTheoretical = 1) %>%
    dplyr::mutate(row.sample = stats::reorder(sample.chkmks, ZymoTheoretical))

  p <- microbiome::plot_composition(zm.all.ps) +
    ggplot2::scale_fill_brewer(palette = "Paired") +
    ggplot2::theme_bw() +
    #ggplot2::facet_grid(~ZymoType) +
    #ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90)) +
    ggplot2::scale_x_discrete(limits = c(tex_cor$sample.chkmks, "ZymoTheoretical")) +
    ggplot2::coord_flip()

  p.ht <- ggplot2::ggplot(tex_cor,
                          ggplot2::aes(row.sample, ZymoTheoretical)) +
    ggplot2::geom_col() +
    ggplot2::scale_x_discrete(limits = c(tex_cor$sample.chkmks)) +
    ggplot2::theme_bw() +
    ggplot2::coord_flip()


  return(list("pseq"=zm.all.ps,
              corrTable = tex_cor,
              "compBarplot"= p,
              "corBarplot" = p.ht))

}

#' @importFrom dada2 assignTaxonomy
.assign_zymo_taxonomy <- function(x,
                                  mock_db = NULL,
                                  multithread=multithread,
                                  minBoot = multithread, ...){

  if(is.null(mock_db)){
    message("Using internal reference database
            for ZymoBiomics")
    db <- system.file("extdata", "ZymoDb.fasta",
                      package="chkMocks", mustWork = TRUE)

  } else{

    db <- mock_db

  }


  zym_taxa <- dada2::assignTaxonomy(x,
                                    db,
                                    multithread=multithread,
                                    minBoot = multithread)
  return(zym_taxa)

}


#' @importFrom phyloseq tax_table tax_table<-
#' @importFrom tibble rownames_to_column column_to_rownames
#' @importFrom dplyr mutate_if na_if
.format_tax_table <- function(ps, taxa){

  phyloseq::tax_table(ps) <- phyloseq::tax_table(taxa)
  tib <- phyloseq::tax_table(ps) %>%
    as.matrix() %>%
    as.data.frame() %>%
    tibble::rownames_to_column("FeatureID") %>%
    dplyr::mutate_if(is.character, list(~ na_if(., ""))) %>%
    #replace(is.na(.), "Exogenous") %>%
    tibble::column_to_rownames("FeatureID") %>%
    as.matrix()

  phyloseq::tax_table(ps) <- phyloseq::tax_table(tib)
  return(ps)

}

#' @importFrom microbiome transform aggregate_taxa
#' @importFrom phyloseq otu_table otu_table<-
.get_species_comp <- function(x){

  x <- microbiome::aggregate_taxa(x, "Species")
  x <- microbiome::transform(x, "compositional")
  phyloseq::otu_table(x) <- phyloseq::otu_table(x) *100
  return(x)

}

#' @importFrom phyloseq otu_table otu_table<-
#' @importFrom corrr correlate focus
#' @importFrom dplyr %>%
.check_zym_cor <- function(x){

  ZymoTheoretical <- NULL
  otu.tb <- phyloseq::otu_table(x) %>%
    as.matrix() %>%
    as.data.frame() %>%
    tibble::as_tibble()

  tex_cor <- suppressMessages(corrr::correlate(otu.tb,
                       method = "pearson",
                       use = 'pairwise.complete.obs')) %>%
    corrr::focus(ZymoTheoretical) %>%
    dplyr::rename(sample.chkmks="term")

  return(tex_cor)

}

