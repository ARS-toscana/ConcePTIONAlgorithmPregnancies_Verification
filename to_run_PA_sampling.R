#------------------------------------------------------------------------------------------
# ConcePTION_Algorithm_Pregnancies script: Verification script
#
# v1.0 - 22 May 2023
# authors: Giorgio Limoncella
# 
# link: https://github.com/ARS-toscana/ConcePTION_PA_Verification
#------------------------------------------------------------------------------------------


### Setting the working directory
rm(list=ls(all.names=TRUE))

if (!require("rstudioapi")) install.packages("rstudioapi")
thisdir<-setwd(dirname(rstudioapi::getSourceEditorContext()$path))
thisdir<-setwd(dirname(rstudioapi::getSourceEditorContext()$path))
setwd(thisdir)


################################################################################
#-----------------------
# Parameter to be filled
#-----------------------
DirectoryPregnancyScript <- "/home/giorgio/Documents/GitHub_Repo/ConcePTIONAlgorithmPregnancies"
DatasourceNameConceptionCDM <- "ARS"

condition <- list(cond_1 = "highest_order_quality == 20", 
                  cond_2 = "highest_order_quality == 50")

sample_sizes <- list(cond_1 = 25, 
                     cond_2 = 25)
################################################################################


### Creating verification sample

#creating output folder
DirectoryOutputCsv <- paste0(thisdir, "/g_sampling_output")
suppressWarnings(if (!file.exists(DirectoryOutputCsv)) dir.create(file.path( DirectoryOutputCsv)))

#loading D3_pregnancy_final and functions
load(paste0(DirectoryPregnancyScript, "/g_output/D3_pregnancy_final.RData"))
source(paste0(thisdir, "/p_functions/sampling_function.R")) 
source(paste0(thisdir, "/p_functions/RecoverAllRecordsOfAPregnanciesList.R")) 

#sampling pregnancies
list_of_samples <- PA_sampling_condition(DirectoryPregnancyScript = DirectoryPregnancyScript,
                                         DatasourceNameConceptionCDM = DatasourceNameConceptionCDM, 
                                         condition = condition,
                                         sample_sizes = sample_sizes)


DT_sample <- rbindlist(list_of_samples)

DatasetInput <- D3_pregnancy_final[pregnancy_id %in% DT_sample[, pregnancy_id]]
#creating verification csv files
sample <- RecoverAllRecordsOfAPregnanciesList(DatasetInput =  DatasetInput,  
                                              PregnancyIdentifierVariable = "pregnancy_id",
                                              DirectoryPregnancyScript = DirectoryPregnancyScript, 
                                              DatasourceNameConceptionCDM = DatasourceNameConceptionCDM,
                                              SaveOutputInCsv = TRUE,
                                              SaveOriginalSampleInCsv = TRUE,
                                              DirectoryOutputCsv = DirectoryOutputCsv,
                                              anonymous = TRUE,
                                              validation_variable = TRUE)
