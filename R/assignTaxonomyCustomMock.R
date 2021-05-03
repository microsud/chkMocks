#' Assign Custom Mocks Taxonomy
#'
#' @name assignTaxonomyCustomMock
#'
#' @details For consistency in taxonomic assignments, use only a small database
#'          that has 16S rRNA gene sequences from mock community genomes.
#'          This is done to avoid any clashes/changes that happen with public databases
#'          and to get a direct comparison.
#'
#' @param x Phyloseq objects where taxa_names are ASV sequences
#'
#' @param mock_db ZymoTrainingSet
#'
#' @param processors Passed on to DECIPHER::IdTaxa Default is NULL
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
#' #output.dat <- assignTaxonomyCustomMock(ps.zym,
#'  #                                      mock_db = NULL,
#'   #                                     processors = 2,
#'    #                                    threshold = 80)
#' @author Sudarshan Shetty \email{sudarshanshetty9@gmail.com}
#'
#' @return Phyloseq with new taxonomy
#'
#' @importFrom DECIPHER IdTaxa
#' @importFrom Biostrings DNAStringSet
#' @importFrom phyloseq taxa_names tax_table
#' @importFrom tidyr separate
#' @importFrom dplyr select
#'
#' @export
#' @importFrom dada2 assignTaxonomy
assignTaxonomyCustomMock <- function(x,
                                     mock_db = NULL,
                                     processors = NULL,
                                     threshold = 60,
                                     strand = "top",
                                     verbose = FALSE, ...){

  if(is.null(mock_db)){

    stop("Please provide reference trainingset")

  }

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
  custom_taxa <- data.frame(row.names = taxa_names(x),
                            Classification=assignment) %>%
    tidyr::separate(Classification, ranks, ";") %>%
    dplyr::select(!root) %>%
    as.matrix() %>%
    phyloseq::tax_table()

  # add new taxonomy
  phyloseq::tax_table(x) <- custom_taxa

  return(x)

}



