test_that("checkZymoBiomics", {

  library(chkMocks)

  zym_sp <- c("Bacillus.subtilis","Listeria.monocytogenes",
              "Staphylococcus.aureus", "Enterococcus.faecalis",
              "Lactobacillus.fermentum","Escherichia.coli",
              "Salmonella.enterica","Pseudomonas.aeruginosa")
  taxa_names(ZymoExamplePseq) <- refseq(ZymoExamplePseq)
  myps <- checkZymoBiomics (ZymoExamplePseq,
                            mock_db = NULL,
                            multithread= 2,
                            minBoot = 80)
  mppseq <- myps$pseq
  tx.names <- taxa_names(mppseq)
  expect_equal(tx.names, zym_sp)

  cor.tb <- myps$corrTable

  vals <- ceiling(cor.tb$ZymoTheoretical*100)
  exp.vals <- c(86,79,79,87,86,51,64,56,54,75,57,45,66,61,50,57,54,52,60,100)
  expect_equal(exp.vals, exp.vals)

  })
