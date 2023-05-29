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
DirectoryPregnancyScript <- "/home/giorgio/GitHubRepo/ConcePTIONAlgorithmPregnancies"
DatasourceNameConceptionCDM <- "ARS"

Sample_Size_Green_Discordant <- 0
Sample_Size_Green_Concordant <- 0
Sample_Size_Yellow_Discordant <- 10
Sample_Size_Yellow_SlightlyDiscordant <- 10
Sample_Size_Yellow_Concordant <- 10
Sample_Size_Blue <- 0
Sample_Size_Red <- 20
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
list_of_samples <- PA_sampling(DirectoryPregnancyScript = DirectoryPregnancyScript,
                               DatasourceNameConceptionCDM = DatasourceNameConceptionCDM, 
                               Sample_Size_Green_Discordant = Sample_Size_Green_Discordant,
                               Sample_Size_Green_Concordant = Sample_Size_Green_Concordant,
                               Sample_Size_Yellow_Discordant = Sample_Size_Yellow_Discordant,
                               Sample_Size_Yellow_SlightlyDiscordant = Sample_Size_Yellow_SlightlyDiscordant,
                               Sample_Size_Yellow_Concordant = Sample_Size_Yellow_Concordant,
                               Sample_Size_Blue = Sample_Size_Blue,
                               Sample_Size_Red = Sample_Size_Red)


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

#coping file for post verification report
file.copy(paste0(DirectoryPregnancyScript,'/g_export/TableReconciliation.csv'), DirectoryOutputCsv)
file.copy(paste0(DirectoryPregnancyScript,'/p_macro/to_run_post_verification_script.R'), DirectoryOutputCsv)
file.copy(paste0(DirectoryPregnancyScript,'/p_macro/Report_verification_preg.Rmd'), DirectoryOutputCsv)
