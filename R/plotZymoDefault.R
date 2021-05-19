#' Plot ZymoBiomics to Experimental comparison
#'
#' @name plotZymoDefault
#'
#' @details A wrapper to plot the output of \code{checkZymoBiomics}.
#'
#' @param x Output from \code{checkZymoBiomics}
#'
#' @examples
#' library(phyloseq)
#' output.dat <- checkZymoBiomics(ZymoExamplePseq,
#'                                mock_db = ZymoTrainingSet,
#'                                multithread= 2,
#'                                threshold = 80,
#'                                strand = "top",
#'                                verbose = FALSE)
#' plotZymoDefault(output.dat)
#'
#' @author Sudarshan Shetty \email{sudarshanshetty9@gmail.com}
#'
#' @return ggplot object
#'
#' @importFrom dplyr %>% desc
#' @import patchwork
#'
#' @export

plotZymoDefault <- function(x){

  ZymoTheoretical <- abundance <- sample.chkmks <- chk.names <- FeatureID <- NULL
  if(class(x)=="list"
     && class(x[[1]])=="phyloseq"
     && class(x[[2]])=="phyloseq"
     && class(x[[3]])[3]=="data.frame") {


    ldf <- .get_long_tib(x$ps_species)

    # Correlation data
    cor.dat <- x$corrTable %>%
      dplyr::arrange(dplyr::desc(ZymoTheoretical))

    # for sorting sample names
    cor.sams <- x$corrTable %>%
      dplyr::arrange(desc(ZymoTheoretical)) %>%
      dplyr::pull(sample.chkmks)

    # sort sample names
    cor.dat$sample.chkmks <- factor(cor.dat$sample.chkmks, levels=cor.sams)
    ldf$chk.names <- factor(ldf$chk.names, levels = cor.sams)

    zym.cols <- c(Bacillus.subtilis = "#332D2D",
                  Listeria.monocytogenes ="#ECB333",
                  Staphylococcus.aureus="#76C6F3",
                  Enterococcus.faecalis="#009E73",
                  Lactobacillus.fermentum="#F0E442",
                  Escherichia.coli="#0072B2",
                  Salmonella.enterica="#EC6E0B",
                  Pseudomonas.aeruginosa="#C1066E",
                  na.value = "#bababa",
                  Unknown = "#bababa"

    )


    p1 <- ggplot2::ggplot(ldf,
                          ggplot2::aes(abundance, chk.names)) +
      ggplot2::geom_bar(
        ggplot2::aes(fill=FeatureID), stat = "identity") +
      ggplot2::scale_fill_manual(values = zym.cols) +
      ggplot2::theme_bw() +
      ggplot2::theme(legend.title = ggplot2::element_blank(),
                     legend.text = ggplot2::element_text(face="italic")) +
      ggplot2::xlab("Abundance (%)")+
      ggplot2::ylab("Samples")

    p2 <- ggplot2::ggplot(cor.dat,
                          ggplot2::aes(ZymoTheoretical,sample.chkmks)) +
      ggplot2::geom_col(ggplot2::aes(fill=ZymoTheoretical)) +
      ggplot2::xlab("Spearman's Correlation \nwith Theoretical") +
      ggplot2::theme_bw() +
      ggplot2::scale_fill_viridis_c("Pearson's Correlation") +
      ggplot2::theme(axis.text.y = ggplot2::element_blank(),
                     axis.ticks.y = ggplot2::element_blank(),
                     axis.title.y = ggplot2::element_blank(),
                     legend.position = "none") +
      ggplot2::geom_vline(xintercept = 1, lty=2)

    p1 + p2 + plot_layout(guides = "collect", widths = c(2,1))

  } else {

    stop("Not a valid input")

  }


}

#' @importFrom dplyr left_join
.get_long_tib <- function(x){

  FeatureID <- name <- value <- NULL
  tx.tib <- phyloseq::tax_table(x) %>%
    as.matrix() %>%
    as.data.frame() %>%
    tibble::rownames_to_column("FeatureID")
  otu.tib <- phyloseq::otu_table(x) %>%
    as.data.frame() %>%
    tibble::rownames_to_column("FeatureID") %>%
    tidyr::pivot_longer(!FeatureID)%>%
    dplyr::left_join(tx.tib, by="FeatureID") %>%
    dplyr::rename(chk.names=name,
                  abundance=value)

  sam_tib <- as(phyloseq::sample_data(x),"data.frame") %>%
    #as.data.frame(stringsAsFactors=FALSE) %>%
    tibble::rownames_to_column("chk.names") %>%
    tibble::as_tibble()

  ldf <- otu.tib %>%
    left_join(sam_tib,by = "chk.names")

  return(ldf)
}
