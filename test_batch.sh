#!/bin/bash
#SBATCH --partition=general                  # Name of Partition
#SBATCH --ntasks=4                           # Maximum CPU cores for job
#SBATCH --array=1-4                           # allows me to run four separate jibs
#SBATCH --time=00-1:00:00                    # Job should run for up to 1 hours
#SBATCH --mail-type=ALL                       # Event(s) that triggers email notification (BEGIN,END,FAIL,ALL)
#SBATCH --mail-user=neil.spencer@uconn.edu    # Destination email address

module unload gcc
module load r/4.2.2

Rscript test_batch.R