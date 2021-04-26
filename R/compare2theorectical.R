#' Compare Custom Mocks to Experimental
#'
#' @name compare2theorectical
#'
#' @details Correlation between theoretical and experimental mocks.
#' @param x Phyloseq object with experimental and theoretical composition
#' @param theoretical_id name of the theoretical sample. Must be in sample_names(x)
#'
#' @example
#'
#' #output.dat <- compare2theorectical(ps.zym,theoretical_id = "somename")
#'
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

compare2theorectical <- function(x, theoretical_id){

  otu.tb <- phyloseq::otu_table(x) %>%
    as.matrix() %>%
    as.data.frame() %>%
    tibble::as_tibble()

  if(!theoretical_id %in% sample_names(x) || is.null(theoretical_id)){
    message(paste0("Check that theoretical = ", theoretical_id, " exists in sample_names(x)"))
    message("returning all pairwise comparisons")
    tex_cor <- suppressMessages(corrr::correlate(otu.tb,
                                                 method = "pearson",
                                                 use = 'pairwise.complete.obs'))
    return(tex_cor)

  } else {


    #column_id <- sym(column_id)


    tex_cor <- suppressMessages(corrr::correlate(otu.tb,
                                                 method = "pearson",
                                                 use = 'pairwise.complete.obs')) %>%
      corrr::focus(all_of(theoretical_id))
    return(tex_cor)
  }


}
