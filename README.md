# ConcePTIONAlgorithmPregnancies_Verification
Repository of the script for additional verification of the ConcePTION algorithm for pregnancies


## Hot to run the script 

  1. Download the script using the green "code" button at the top of this page and unzip it to any location on the machine where the ConcePTIONAlgorithmPregnancies folder is located. 

![img](https://github.com/ARS-toscana/ConcePTIONAlgorithmPregnancies_Verification/blob/Documentation/img/code.png) 
<br>

  2. Open the file **to_run_PA_sampling.R** and in the _Parameter to be filled_ section include the directory in which the ConcePTIONAlgorithmPregnancies folder is located and the Datasource name. 

```
DirectoryPregnancyScript <- "MyPC/home/ConcePTIONAlgorithmPregnancies"
DatasourceNameConceptionCDM <- "ARS"
```

  3. Define the sample size to be sampled.

  ```
  Sample_Size_Green_Discordant <- 0
  Sample_Size_Green_Concordant <- 0
  Sample_Size_Yellow_Discordant <- 0
  Sample_Size_Yellow_SlightlyDiscordant <- 0
  Sample_Size_Yellow_Concordant <- 0
  Sample_Size_Blue <- 50
  Sample_Size_Red <- 20
  ```
  
  4. Save changes, select all rows, and execute. 

## Output

Once the program has been run a folder called g_sampling_output will be generated. 
The file for verification (**sample_from_pregnancies_anon.csv**) will be created in this folder.

The validation report is also available. Once the sample_from_pregnancies_anon.csv file is filled, save it in the same folder with the name **sample_from_pregnancies_verified.csv** and run the **to_run_post_verification_script.R** file.
The report will appear in the _verification_output_ folder with the name **Report_verification_preg.html**.
