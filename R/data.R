#' @title ZymoBiomics
#'
#' @description ZymoBiomics data from ZymoBIOMICS Microbial Community Standard.
#'
#' @details ZymoBiomics data from ZymoBIOMICS Microbial Community Standard.
#'          Has a table with  information on Species and their theoretical
#'          composition in percentage values for Genomic DNA, 16S Only,
#'          16S and 18S, Genome Copy and Cell number. Product name D6300
#'
#' @name ZymoBiomics
#'
#' @docType data
#'
#' @author Sudarshan Shetty \email{sudarshanshetty9@gmail.com}
#'
#' @usage data(ZymoBiomics)
#'
#' @return Loads the data set in R.
#'
#' @format Phyloseq object
#'
#' @keywords Data
#'
#' @references
#'
#' \itemize{
#' \item{}{ZymoBIOMICS™ Microbial Community Standard.
#'        \emph{Catalog No. D6300.
#'        \url{https://files.zymoresearch.com/protocols/_d6300_zymobiomics_microbial_community_standard.pdf}
#' }
#' }
#' }
NULL

#' @title ZymoBiomicsFasta
#'
#' @description 16S and 18S sequences from ZymoBIOMICS Microbial Community Standard.
#'
#' @details ZymoBiomicsFasta has all 16S and 18S sequence data as \code{DNAStringSet}.
#'          Has 50 rDNA sequences, all copies of 16S rRNA gene are made available.
#'
#' @name ZymoBiomicsFasta
#'
#' @docType data
#'
#' @author Sudarshan Shetty \email{sudarshanshetty9@gmail.com}
#'
#' @usage data(ZymoBiomicsFasta)
#'
#' @return Loads the data set in R.
#'
#' @format DNAStringSet object
#'
#' @keywords Data
#'
#' @references
#'
#' \itemize{
#' \item{}{ZymoBIOMICS™ Microbial Community Standard.
#'        \emph{Catalog No. D6300.
#'        \url{https://files.zymoresearch.com/protocols/_d6300_zymobiomics_microbial_community_standard.pdf}
#'        \url{https://s3.amazonaws.com/zymo-files/BioPool/ZymoBIOMICS.STD.refseq.v2.zip}
#' }
#' }
#' }
NULL

#' @title ZymoBiomicsPseq
#'
#' @description Theoretical 16S composition of ZymoBIOMICS Microbial Community Standard.
#'
#' @details ZymoBiomicsPseq contains the \emph{theoretical} 16S composition of
#'          ZymoBIOMICS Microbial Community Standard. One sample, 8 taxa and 7
#'          taxonomic ranks.
#'
#' @name ZymoBiomicsPseq
#'
#' @docType data
#'
#' @author Sudarshan Shetty \email{sudarshanshetty9@gmail.com}
#'
#' @usage data(ZymoBiomicsPseq)
#'
#' @return Loads the data set in R.
#'
#' @format Phyloseq object
#'
#' @keywords Data
#'
#' @references
#'
#' \itemize{
#' \item{}{ZymoBIOMICS™ Microbial Community Standard.
#'        \emph{Catalog No. D6300.
#'        \url{https://files.zymoresearch.com/protocols/_d6300_zymobiomics_microbial_community_standard.pdf}
#' }
#' }
#' }
NULL

#' @title ZymoExamplePseq
#'
#' @description Contains ZymoBIOMICS Microbial Community Standard samples ran
#'              in different sequencing libraries as postive controls.
#'
#' @details ZymoExamplePseq contains the \emph{experimental} 16S composition of
#'          ZymoBIOMICS Microbial Community Standard. 9 samples, 946 ASVs and 7
#'          taxonomic ranks. ZymoBIOMIC mock community standards consisting of
#'          eight bacterial species \emph{Pseudomonas.aeruginosa},
#'          \emph{Escherichia coli}, \emph{Salmonella.enterica},
#'          \emph{Lactobacillus.fermentum}, \emph{Enterococcus.faecalis},
#'          \emph{Staphylococcus.aureus}, \emph{Listeria.monocytogenes},
#'          \emph{Bacillus.subtilis} and two fungal species
#'          \emph{Saccharomyces.cerevisiae} and \emph{Cryptococcus.neoformans}.
#'          The dilutions were done in microbial free water (Qiagen) in
#'          eight rounds of a serial three-fold dilution
#'          prior to DNA extraction. The data are for the V4 region of the
#'          16S rRNA gene profiled with Illumina MiSeq.
#'
#' @name ZymoExamplePseq
#'
#' @docType data
#'
#' @author Sudarshan Shetty \email{sudarshanshetty9@gmail.com}
#'
#' @usage data(ZymoExamplePseq)
#'
#' @return Loads the data set in R.
#'
#' @format Phyloseq object
#'
#' @keywords Data
#'
#' @references
#' \itemize{
#' \item{}{Karstens L, Asquith M, Davin S, Fair D, Gregory WT, Wolfe AJ,
#'         Braun J, McWeeney S. (2019) Controlling for contaminants in
#'         low-biomass 16S rRNA gene sequencing experiments.
#'        \emph{mSystems}, 4:e00290-19.
#'        \url{https://doi.org/10.1128/mSystems.00290-19}
#' }
#' }
#' Shetty SA 2021
NULL

#' @title ZymoBiomicsGutPseq
#'
#' @description Theoretical 16S composition of ZymoBIOMICS Microbial Community Standard.
#'
#' @details ZymoBiomicsGutPseq contains the \emph{theoretical} 16S composition of
#'          ZymoBIOMICS Gut Microbial Community Standard. One sample, 19 known taxa and 7
#'          taxonomic ranks.
#'
#' @name ZymoBiomicsGutPseq
#'
#' @docType data
#'
#' @author Sudarshan Shetty \email{sudarshanshetty9@gmail.com}
#'
#' @usage data(ZymoBiomicsGutPseq)
#'
#' @return Loads the data set in R.
#'
#' @format Phyloseq object
#'
#' @keywords Data
#'
#' @references
#' \itemize{
#' \item{}{ZymoBIOMICS® Gut Microbiome Standard.
#'        \emph{Catalog No. D6331.
#'        \url{https://files.zymoresearch.com/protocols/_d6331_zymobiomics_gut_microbiome_standard.pdf}
#' }
#' }
#' }
#' Shetty SA 2021
NULL

#' @title ZymoTrainingSet
#'
#' @description Contains ZymoTrainingSet compatible with DECIPHER::IdTaxa.
#'
#' @details ZymoTrainingSet contains 16S sequences of
#'          ZymoBIOMICS Microbial Community Standard. ZymoBIOMIC mock community
#'          standards consisting of
#'          eight bacterial species \emph{Pseudomonas.aeruginosa},
#'          \emph{Escherichia coli}, \emph{Salmonella.enterica},
#'          \emph{Lactobacillus.fermentum}, \emph{Enterococcus.faecalis},
#'          \emph{Staphylococcus.aureus}, \emph{Listeria.monocytogenes},
#'          \emph{Bacillus.subtilis} and two fungal species
#'          \emph{Saccharomyces.cerevisiae} and \emph{Cryptococcus.neoformans}.
#'
#' @name ZymoTrainingSet
#'
#' @docType data
#'
#' @author Sudarshan Shetty \email{sudarshanshetty9@gmail.com}
#'
#' @usage data(ZymoTrainingSet)
#'
#' @return Loads the data set in R.
#'
#' @format TrainingSet object
#'
#' @keywords Data
#'
#' @references
#' \itemize{
#' \item{}{ZymoBIOMICS™ Microbial Community Standard.
#'        \emph{Catalog No. D6300.
#'        \url{https://files.zymoresearch.com/protocols/_d6300_zymobiomics_microbial_community_standard.pdf}
#' }
#' }
#' }
#' Shetty SA 2021
NULL

#' @title ZymoBiomicsGutTrainingSet
#'
#' @description Contains ZymoBiomicsGutTrainingSet compatible with DECIPHER::IdTaxa.
#'
#' @details ZymoBiomicsGutTrainingSet contains 16S sequences of
#'          ZymoBIOMICS Gut Microbial Community Standard Catalog No. D6331.
#'
#' @name ZymoBiomicsGutTrainingSet
#'
#' @docType data
#'
#' @author Sudarshan Shetty \email{sudarshanshetty9@gmail.com}
#'
#' @usage data(ZymoBiomicsGutTrainingSet)
#'
#' @return Loads the data set in R.
#'
#' @format TrainingSet object
#'
#' @keywords Data
#'
#' @references
#' \itemize{
#' \item{}{ZymoBIOMICS® Gut Microbiome Standard.
#'        \emph{Catalog No. D6331.
#'        \url{https://files.zymoresearch.com/protocols/_d6331_zymobiomics_gut_microbiome_standard.pdf}
#' }
#' }
#' }
#' Shetty SA 2021
NULL

#' @title ZymoBiomicsGut
#'
#' @description Contains ZymoBiomicsGut compatible with DECIPHER::IdTaxa.
#'
#' @details ZymoBiomicsGut contains table with information on strains and thier
#'          abundances ZymoBIOMICS Gut Microbial Community Standard Catalog
#'          No. D6331.
#'
#' @name ZymoBiomicsGut
#'
#' @docType data
#'
#' @author Sudarshan Shetty \email{sudarshanshetty9@gmail.com}
#'
#' @usage data(ZymoBiomicsGut)
#'
#' @return Loads the data set in R.
#'
#' @format Table
#'
#' @keywords Data
#'
#' @references
#' \itemize{
#' \item{}{ZymoBIOMICS® Gut Microbiome Standard.
#'        \emph{Catalog No. D6331.
#'        \url{https://files.zymoresearch.com/protocols/_d6331_zymobiomics_gut_microbiome_standard.pdf}
#' }
#' }
#' }
#' Shetty SA 2021
NULL
