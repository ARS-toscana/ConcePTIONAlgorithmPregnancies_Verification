PA_sampling_condition <- function(DirectoryPregnancyScript = NULL, 
                                  DatasourceNameConceptionCDM = NULL, 
                                  condition = NULL,
                                  sample_sizes = NULL){
  
  thisdatasource <- DatasourceNameConceptionCDM
  source(paste0(DirectoryPregnancyScript,"/p_parameters_pregnancy/00_parameters_pregnancy.R"), local = TRUE)
  library(data.table)
  
  dirtemp <- paste0(DirectoryPregnancyScript, "/g_intermediate/")
  
  load(paste0(dirtemp,"D3_pregnancy_reconciled_valid.RData"))
  load(paste0(dirtemp,"D3_groups_of_pregnancies_reconciled.RData"))
  D3_groups_of_pregnancies_reconciled[, highest_order_quality := min(order_quality), pregnancy_id]
  
  #--------------
  # Define strata
  #--------------
  for (c in names(condition)) {
    assign(paste0("preg_id_", c),
           unique(D3_groups_of_pregnancies_reconciled[eval(parse(text = condition[[c]])), pregnancy_id]))

    if(length(get(paste0("preg_id_", c)))==0){
      cat(condition[[c]], "\n")
      stop("check condition")
    }

    if(length(get(paste0("preg_id_", c))) < sample_sizes[[c]]){
      cat(condition[[c]], "\n")
      stop("check sample sizes")
    }
  }
  
  #---------
  # Sampling
  #---------
  list_of_samples <- vector(mode = "list")
  
  for (c in names(condition)) {
    tmp <- sample(x = D3_pregnancy_reconciled_valid[pregnancy_id %in% get(paste0("preg_id_", c)), pregnancy_id], 
                  size = sample_sizes[[c]], 
                  replace = FALSE)
    list_of_samples[[c]] <- D3_pregnancy_reconciled_valid[pregnancy_id %in% tmp][, sample:= condition[[c]]]
  }
  
  return(list_of_samples)
}
