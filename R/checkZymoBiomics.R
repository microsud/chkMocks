#' Compare ZymoBiomics to Experimental
#'
#' @name checkZymoBiomics
#'
#' @details Compare ZymoBiomics theoretical to Experimental composition.
#'
#' @param x Phyloseq objects where taxa_names are ASV sequences
#'
#' @param mock_db ZymoTrainingSet
#'
#' @param multithread Passed on to DECIPHER::IdTaxa Default is NULL
#'
#' @param threshold Passed on to DECIPHER::IdTaxa. Default is 60
#'
#' @param verbose Default is FALSE
#'
#' @param strand DECIPHER::IdTaxa Default is top
#'
#' @param ... Arguments to pass on to DECIPHER::IdTaxa
#'
#' @examples
#' library(phyloseq)
#'
#' output.dat <- checkZymoBiomics(ZymoExamplePseq,
#'                                mock_db = ZymoTrainingSet,
#'                                multithread= 2,
#'                                threshold = 80,
#'                                strand = "top",
#'                                verbose = FALSE)
#'
#' @author Sudarshan Shetty \email{sudarshanshetty9@gmail.com}
#'
#' @return List with pseq, and cor table
#'
#' @importFrom dplyr %>%
#' @importFrom tibble as_tibble
#'
#' @export
#'

checkZymoBiomics <- function(x,
                             mock_db = NULL,
                             multithread= 2,
                             threshold = 60,
                             verbose = FALSE,
                             strand = "top",
                             ...) {

  if(is.null(mock_db)){
    stop("Specifiy `mock_db` ZymoTrainingSet")
  }
  sample.chkmks <- ZymoTheoretical <- row.sample <- NULL

  new_tx <- .assign_zymo_taxonomy(x,
                                  mock_db = mock_db,
                                  processors=multithread,
                                  threshold = threshold,
                                  strand = strand,
                                  verbose = verbose)

  nw_x <- .get_species_comp(new_tx)

  # merge with theoretical
  phyloseq::sample_data(ZymoBiomicsPseq)$ZymoType <- "Theoretical"
  phyloseq::sample_data(nw_x)$ZymoType <- "UserSamples"

  zm.all.ps <- phyloseq::merge_phyloseq(nw_x, ZymoBiomicsPseq)
  # Check correlation
  tex_cor <- .check_zym_cor(zm.all.ps)
  tex_cor <- tex_cor %>%
    tibble::add_row(sample.chkmks= "ZymoTheoretical", ZymoTheoretical = 1) %>%
    dplyr::mutate(row.sample = stats::reorder(sample.chkmks, ZymoTheoretical))

  return(list("ps_asv"=new_tx,
              "ps_species"=zm.all.ps,
              "corrTable" = tex_cor))

}

#' @importFrom DECIPHER IdTaxa
#' @importFrom Biostrings DNAStringSet
#' @importFrom phyloseq taxa_names tax_table
#' @importFrom tidyr separate
#' @importFrom dplyr select
.assign_zymo_taxonomy <- function(x,
                                  mock_db = mock_db,
                                  processors = processors,
                                  threshold = threshold,
                                  strand = strand,
                                  verbose = verbose, ...){

  message("Using internal reference database
            for ZymoBiomics")

  Classification  <- root <- NULL
  dna <- Biostrings::DNAStringSet(taxa_names(x)) # Create a DNAStringSet from the ASVs

  ids <- DECIPHER::IdTaxa(dna, mock_db, strand=strand,
                          processors=processors,
                          threshold = threshold,
                          verbose = verbose)

  ranks <- c("Root","Domain", "Phylum", "Class", "Order", "Family", "Genus", "Species") # ranks of interest
  assignment <- sapply(ids,
                       function(x)
                         paste(x$taxon,
                               collapse=";"))

  #class(assignment)

  ranks <- c("root","domain", "phylum", "class", "order", "family", "genus", "species") # ranks of interest
  zym_taxa <- data.frame(row.names = taxa_names(x),
                         Classification=assignment) %>%
    tidyr::separate(Classification, ranks, ";") %>%
    dplyr::select(!root) %>%
    as.matrix() %>%
    phyloseq::tax_table()

  # add new toaxonomy
  phyloseq::tax_table(x) <- zym_taxa

  return(x)

}


#' @importFrom microbiome transform aggregate_taxa
#' @importFrom phyloseq otu_table otu_table<-
.get_species_comp <- function(x){

  x <- microbiome::aggregate_taxa(x, "species")
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
                                               method = "spearman",
                                               use = 'everything')) %>%
    corrr::focus(ZymoTheoretical) %>%
    dplyr::rename(sample.chkmks="term")

  return(tex_cor)

}


