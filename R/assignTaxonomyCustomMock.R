#' Assign Custom Mocks Taxonomy
#'
#' @name assignTaxonomyCustomMock
#'
#' @details For consistency in taxonomic assignments, use only a small database
#'          that has 16S rRNA gene sequences from mock community genomes.
#'          This is done to avoid any clashes/changes that happen with public databases
#'          and to get a direct comparison.
#'
#' @param x A phyloseq object with experimental and theoretical composition
#' @param mock_db Path to custom database
#' @param multithread Passed on to dada2::assignTaxonomy Default is 2
#'
#' @param minBoot Passed on to dada2::assignTaxonomy. Default is 80
#'
#' @param ... Arguments to pass on to dada2::assignTaxonomy
#'
#' @examples
#' #output.dat <- assignTaxonomyCustomMock(ps.zym,
#'  #                                      mock_db = NULL,
#'   #                                     multithread= 2,
#'    #                                    minBoot = 80)
#' @author Sudarshan Shetty \email{sudarshanshetty9@gmail.com}
#'
#' @return Correlation table
#'
#' @importFrom dplyr %>%
#' @importFrom tibble as_tibble
#' @importFrom phyloseq otu_table sample_names
#' @importFrom corrr correlate focus
#'
#' @export
#' @importFrom dada2 assignTaxonomy
assignTaxonomyCustomMock <- function(x,
                                     mock_db = NULL,
                                     multithread=multithread,
                                     minBoot = multithread, ...){

  if(is.null(mock_db)){
    warning("No reference fasta provided!! Using internal reference database
            for ZymoBiomics")
    db <- system.file("extdata", "ZymoDb.fasta",
                      package="chkMocks", mustWork = TRUE)

  } else{

    db <- mock_db

  }

  seqs <- phyloseq::taxa_names(x)

  new_tx <- dada2::assignTaxonomy(seqs,
                                    db,
                                    multithread=multithread,
                                    minBoot = multithread)

  nw_x <- .format_tax_table(x, taxa=new_tx)
  nw_x <- .get_species_comp(nw_x)
  return(nw_x)

}



