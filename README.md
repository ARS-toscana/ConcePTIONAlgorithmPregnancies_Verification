# ConcePTIONAlgorithmPregnancies_Verification
Repository of the script for additional verification of the ConcePTION algorithm for pregnancies


## Hot to run the script 

  1. Download the script using the green "code" button at the top of this page and unzip it to any location on the machine where the ConcePTIONAlgorithmPregnancies folder is located. 

<img src="https://github.com/ARS-toscana/ConcePTIONAlgorithmPregnancies_Verification/blob/Documentation/img/code.png"  width="600" height="220">

  2. Open the file **to_run_PA_sampling.R** and in the _Parameter to be filled_ section include the directory in which the ConcePTIONAlgorithmPregnancies folder is located and the Datasource name. 

```
DirectoryPregnancyScript <- "MyPC/home/ConcePTIONAlgorithmPregnancies"
DatasourceNameConceptionCDM <- "ARS"
```

  3. In the _Parameter to be filled_ section also define the strata into which the sample will be extracted (**condition**) and the respective sample sizes.

  ```
condition <- list(cond_1 = "highest_order_quality == 20", 
                  cond_2 = "highest_order_quality == 50")

sample_sizes <- list(cond_1 = 25, 
                     cond_2 = 25)
  ```
  
  4. Save changes, select all rows, and execute. 

## Output

Once the program has been run a folder called g_sampling_output will be generated. 
The file for verification (**sample_from_pregnancies_anon.csv**) will be created in this folder.

The validation report is also available. Once the sample_from_pregnancies_anon.csv file is filled, save it in the same folder with the name **sample_from_pregnancies_verified.csv** and run the **to_run_post_verification_script.R** file.
The report will appear in the _verification_output_ folder with the name **Report_verification_preg.html**.
