# Load packages -----------------------------------------------------------
library(tidyverse)
library(GPArotation)

# CEO salary --------------------------------------------------------------
#load data
ceo <-  read.table(file = paste0(data_dir, "/Ceosal/ceosal2.dat"))
names(ceo) <- ceo[1,]
ceo <- ceo[-1,]
ceo <- ceo %>%  mutate_all(as.numeric)
og_ceo <- ceo
# str(ceo)

ceo <- ceo %>% dplyr::select(-c(college, grad)) #droop dummies
ceo <- ceo %>% dplyr::select(-c(lsales, lmktval, lsalary, profmarg, age)) 
ceo <-  ceo %>% dplyr::select(-c(ceotensq, comtensq))
final_ceo <- ceo 

#pca--------------------------------------------------------------------------------------
pca <- prcomp(ceo, scale = TRUE)



#factor analysis  --------------------------------------------------------------
fac1 <- factanal(ceo, factors = 1, standardize = TRUE, scores = "Bartlett", rotation = "varimax")

fac2 <- factanal(ceo, factors = 2, standardize = TRUE, scores = "Bartlett", 
                 rotation = "varimax")
fac2_oblimin <- factanal(ceo, factors = 2, standardize = TRUE, scores = "Bartlett")
fac2_oblimin <-oblimin(fac2_oblimin$loadings)

fac_3 <- factanal(ceo, factors = 3, rotation = "varimax", standardize = TRUE,
                  scores = "Bartlett")
fac_3_oblimin <- factanal(ceo, factors = 3, standardize = TRUE, scores = "Bartlett")
fac_3_oblimin <-oblimin(fac_3_oblimin$loadings)





