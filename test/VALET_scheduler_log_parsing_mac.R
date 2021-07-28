library(stringr)
library(sjmisc)


#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_05_08_20_pipeline_mod_10800"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_10_11_20_pipeline_mod_static_10800_empty_history"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_11_11_20_pipeline_mod_static_10800_empty_history"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_11_11_20_pipeline_mod_static_10800_full_history_full_cluster"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_12_11_20_pipeline_mod_static_10800_full_history_initial_cluster"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_17_11_20_pipeline_mod_static_10800_empty_history_initial_cluster_4min"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_18_11_20_pipeline_mod_static_10800_empty_history_initial_cluster_4min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_19_11_20_pipeline_mod_static_10800_empty_history_initial_cluster_4min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_19_11_20_pipeline_mod_static_10800_full_history_full_cluster_4min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_20_11_20_pipeline_mod_static_10800_empty_history_initial_cluster_4min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_20_11_20_pipeline_mod_static_full_cluster_no_scaling_4min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_23_11_20_pipeline_mod_static_full_cluster_no_scaling_3min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_23_11_20_pipeline_mod_static_full_cluster_no_scaling_5min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_23_11_20_pipeline_mod_static_full_cluster_no_scaling_2min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_23_11_20_pipeline_mod_static_full_cluster_no_scaling_1min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_24_11_20_pipeline_mod_static_10800_empty_history_initial_cluster_3min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_24_11_20_try2_pipeline_mod_static_10800_empty_history_initial_cluster_3min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_25_11_20_pipeline_mod_static_10800_empty_history_initial_cluster_3min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_26_11_20_pipeline_mod_static_10800_empty_history_initial_cluster_3min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_26_11_20_try2_pipeline_mod_static_10800_empty_history_initial_cluster_3min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_27_11_20_pipeline_mod_static_10800_empty_history_initial_cluster_2min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_26_11_20_pipeline_mod2_static_full_cluster_no_scaling_5min"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_30_11_20_pipeline_mod_static_10800_empty_history_initial_cluster_2min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_30_11_20_try2_pipeline_mod_static_10800_empty_history_initial_cluster_2min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_01_12_20_pipeline_mod_static_10800_empty_history_initial_cluster_2min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_01_12_20_try2_pipeline_mod_static_10800_empty_history_initial_cluster_2min_corrected_walltimes"
##filepath <- "/Users/maximilianhanussek/Dropbox/Uni/Publications/VALET_data/VALET_scheduler_log_30_11_20_pipeline_mod2_static_full_cluster_no_scaling_5min"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_02_12_20_pipeline_mod_static_10800_empty_history_initial_cluster_1min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_03_12_20_pipeline_mod_static_10800_empty_history_initial_cluster_1min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_04_12_20_pipeline_mod_static_10800_empty_history_initial_cluster_1min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_07_12_20_pipeline_mod_static_10800_empty_history_initial_cluster_1min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_08_12_20_pipeline_mod_static_10800_empty_history_initial_cluster_1min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/broken/VALET_scheduler_log_09_12_20_pipeline_mod_static_10800_full_history_initial_cluster_1min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_09_12_20_try2_pipeline_mod_static_10800_full_history_initial_cluster_1min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod/VALET_scheduler_log_10_12_20_pipeline_mod_static_10800_empty_history_initial_cluster_5min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_11_12_20_pipeline_mod2_static_10800_empty_history_initial_cluster_5min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_16_12_20_pipeline_mod2_static_10800_empty_history_initial_cluster_5min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_12_01_21_pipeline_mod2_static_10800_empty_history_initial_cluster_5min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_22_03_21_pipeline_mod2_static_10800_empty_history_initial_cluster_5min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_26_03_21_pipeline_mod2_static_10800_empty_history_initial_cluster_4min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_12_04_21_pipeline_mod2_static_10800_empty_history_initial_cluster_5min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_20_04_21_pipeline_mod2_static_10800_empty_history_initial_cluster_4min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_26_04_21_pipeline_mod2_static_10800_empty_history_initial_cluster_4min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_28_04_21_pipeline_mod2_static_10800_empty_history_initial_cluster_4min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_02_05_21_pipeline_mod2_static_10800_empty_history_initial_cluster_4min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_05_05_21_pipeline_mod2_static_10800_empty_history_initial_cluster_3min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_07_05_21_pipeline_mod2_static_10800_empty_history_initial_cluster_3min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_10_05_21_pipeline_mod2_static_10800_empty_history_initial_cluster_3min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_12_05_21_pipeline_mod2_static_10800_empty_history_initial_cluster_3min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_17_05_21_pipeline_mod2_static_10800_empty_history_initial_cluster_3min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_19_05_21_pipeline_mod2_static_10800_empty_history_initial_cluster_2min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_25_05_21_pipeline_mod2_static_10800_empty_history_initial_cluster_2min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_27_05_21_pipeline_mod2_static_10800_empty_history_initial_cluster_2min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_11_06_21_pipeline_mod2_static_10800_empty_history_initial_cluster_2min_corrected_walltimes"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_14_06_21_pipeline_mod2_static_36000_empty_history_initial_cluster_2min_corrected_walltimes_sched_60"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_16_06_21_pipeline_mod2_static_36000_empty_history_initial_cluster_2min_corrected_walltimes_sched_60"
##filepath <- "/Users/maximilianhanussek/Dropbox/Uni/Publications/VALET_data/VALET_scheduler_log_18_06_21_pipeline_mod2_static_36000_empty_history_initial_cluster_2min_corrected_walltimes_sched_60"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_21_06_21_pipeline_mod2_static_36000_empty_history_initial_cluster_2min_corrected_walltimes_sched_60"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_23_06_21_pipeline_mod2_static_36000_empty_history_initial_cluster_2min_corrected_walltimes_sched_60"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_25_06_21_pipeline_mod2_static_36000_empty_history_initial_cluster_3min_corrected_walltimes_sched_60"
##filepath <- "/Users/maximilianhanussek/Dropbox/Uni/Publications/VALET_data/VALET_scheduler_log_28_06_21_pipeline_mod2_static_36000_empty_history_initial_cluster_3min_corrected_walltimes_sched_60"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_30_06_21_pipeline_mod2_static_36000_empty_history_initial_cluster_3min_corrected_walltimes_sched_60"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_02_07_21_pipeline_mod2_static_36000_empty_history_initial_cluster_3min_corrected_walltimes_sched_60"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_04_07_21_pipeline_mod2_static_36000_empty_history_initial_cluster_3min_corrected_walltimes_sched_60"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_06_07_21_pipeline_mod2_static_36000_empty_history_initial_cluster_4min_corrected_walltimes_sched_60"
##filepath <- "/Users/maximilianhanussek/Dropbox/Uni/Publications/VALET_data/VALET_scheduler_log_08_07_21_pipeline_mod2_static_36000_empty_history_initial_cluster_4min_corrected_walltimes_sched_60"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_12_07_21_pipeline_mod2_static_36000_empty_history_initial_cluster_4min_corrected_walltimes_sched_60"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_14_07_21_pipeline_mod2_static_36000_empty_history_initial_cluster_4min_corrected_walltimes_sched_60"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_16_07_21_pipeline_mod2_static_36000_empty_history_initial_cluster_4min_corrected_walltimes_sched_60"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_19_07_21_pipeline_mod2_static_36000_empty_history_initial_cluster_5min_corrected_walltimes_sched_60"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_21_07_21_pipeline_mod2_static_36000_empty_history_initial_cluster_5min_corrected_walltimes_sched_60"
##filepath <- "/Users/maximilianhanussek/Dropbox/Uni/Publications/VALET_data/VALET_scheduler_log_23_07_21_pipeline_mod2_static_36000_empty_history_initial_cluster_5min_corrected_walltimes_sched_60"
#filepath <- "/home/mhanussek/Dokumente/VALET_scheduler_simulations/pipeline_mod2/VALET_scheduler_log_25_07_21_pipeline_mod2_static_36000_empty_history_initial_cluster_5min_corrected_walltimes_sched_60"



conn      <- file(filepath,open="r")
logfile   <- readLines(conn)

time_vector <- c()

for (i in 1:length(logfile)){
  split_line <- str_split(logfile[i], " ", 3, simplify = TRUE)
  time_vector <- c(time_vector, paste(split_line[1], split_line[2]))
}

unique_time_vector <- unique(time_vector)

number_of_nodes <- c()
used_cores <- c()
decisions <- c()
rfd1 <- c()
rfd2 <- c()

for (i in 1:length(unique_time_vector)){
  block_number_vector <- c()
  block_number_vector <- c(block_number_vector, grep(unique_time_vector[i], logfile))
  used_cores_found <- 0
  rfd1_found <- 0
  rfd2_found <- 0
  
  for (j in 1:length(block_number_vector)){
    if (str_contains(logfile[block_number_vector[j]], "Number of nodes:")){
      number_of_nodes <- c(number_of_nodes, str_trim(str_split(logfile[block_number_vector[j]], "Number of nodes:")[[1]][2]))
    }
    
    if (str_contains(logfile[block_number_vector[j]], "Number of currently used cores:")){
      used_cores <- c(used_cores, str_trim(str_split(logfile[block_number_vector[j]], "Number of currently used cores:")[[1]][2]))  
      used_cores_found <- 1
    } 
    
    if (str_contains(logfile[block_number_vector[j]], "New rfd1 threshold in seconds:")){
      rfd1 <- c(rfd1, str_trim(str_split(logfile[block_number_vector[j]], "New rfd1 threshold in seconds:")[[1]][2]))
      rfd1_found <- 1
    }
    
    if (str_contains(logfile[block_number_vector[j]], "New rfd2 threshold in seconds:")){
      rfd2 <- c(rfd2, str_trim(str_split(logfile[block_number_vector[j]], "New rfd2 threshold in seconds:")[[1]][2]))
      rfd2_found <- 1
    }
    
    if (j == length(block_number_vector)){
      decisions <- c(decisions, logfile[block_number_vector[j]])
    }
  } 
  
  if (used_cores_found == 0) {
    used_cores <- c(used_cores, "NA")
  }
  
  if (rfd1_found == 0) {
    rfd1 <- c(rfd1, "NA")
  }
  
  if (rfd2_found == 0) {
    rfd2 <- c(rfd2, "NA")
  }
}

close(conn)

ratio_used_cores <- c()
used_cores_only <- c()
available_cores_only <- c()
for (i in 1:length(used_cores)) {
  if (used_cores[i] == "NA") {
    ratio_used_cores <- c(ratio_used_cores, 
                          as.numeric(str_split(used_cores[i-1], "/", simplify = TRUE)[1]) / as.numeric(str_split(used_cores[i-1], "/", simplify = TRUE)[2]))
    used_cores_only <- c(used_cores_only, str_split(used_cores[i-1], "/", simplify = TRUE)[1] )
    available_cores_only <- c(available_cores_only, str_split(used_cores[i-1], "/", simplify = TRUE)[2])
    
  } else {
    ratio_used_cores <- c(ratio_used_cores,
                          as.numeric(str_split(used_cores[i], "/", simplify = TRUE)[1]) / as.numeric(str_split(used_cores[i], "/", simplify = TRUE)[2]))
    used_cores_only <- c(used_cores_only, str_split(used_cores[i], "/", simplify = TRUE)[1])
    available_cores_only <- c(available_cores_only, str_split(used_cores[i], "/", simplify = TRUE)[2])
    }
}

ratio_used_cores <- format(round(ratio_used_cores, 2), nsmall = 2)

output_table <- data.frame(unique_time_vector, number_of_nodes, used_cores, decisions, rfd1, rfd2)

value <- seq(1, length(number_of_nodes))
plot(x=value, y=number_of_nodes, type="o", ylim=c(1, 10), ylab="Number of used nodes", xlab="Timestep", pch=20)

plot(x=value, y=ratio_used_cores, type="o", ylab="Core usage ratio", xlab="Timestep", pch=20)

plot(x=value, y=used_cores_only, type="o", ylab="Number of used cores", xlab="Timestep", pch=20, lty=1)
lines(x=value, y=available_cores_only, col="red", lty=2)

print("Mean number of nodes:")
print(mean(to_numeric(number_of_nodes)))

print("Mean number of used cores only:")
print(mean(to_numeric(used_cores_only)))

print("Mean number of available cores only:")
print(mean(to_numeric(available_cores_only)))
