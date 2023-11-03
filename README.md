# UCONN High performance instructions for MAC

This is a tutorial by Neil Spencer on how to get started on the UConn HPC from a Mac.

To get started, you will need to open two terminal windows. One window [LOCAL] will be for you to interact with your personal computer. The other window [CLUSTER] will be to interact with the cluster.

To start, navigate [LOCAL] to the folder out of which you want to do your work. For this tutorial, it should be the uconn_hpc_tutorial folder you've pulled from github.

Command tips on navigating directories from terminal.

pwd: tells you the name of the directory you are currently in
ls: lists the files and folders in this directory
cd [directory]: allows you to change directory
cd ..: allows you to move back into the parent directory

Now, let's log into the hpc cluster using the [CLUSTER] window. In terminal, write the following command, replacing [username aaa00000] with you username. 

ssh [username aaa00000]@hpc2.storrs.hpc.uconn.edu

Then, enter your password for the hpc.

Once logged in, create yourself a new directory on the cluster using the mkdir command. Ours will be called test_directory. This should be done in the [CLUSTER] window.

mkdir test_directory

Now, to move into that directory, use:

cd test_directory

We are now going to transfer files from our personal computer onto the cluster. To do this, go back to your [LOCAL] window. After verifying you are in the directory containing the file you want to transfer, run

scp test_file [username aaa00000]@hpc2.storrs.hpc.uconn.edu:/home/[username aaa00000]/test_directory/

If you want to transfer an entire folder and all its contents, instead use:

scp -r test_folder [username aaa00000]@hpc2.storrs.hpc.uconn.edu:/home/[username aaa00000]/test_directory/

Okay, now that we know how to transfer a file in, let's transfer in a simple R file and run it. 

scp cluster_test.R [username aaa00000]@hpc2.storrs.hpc.uconn.edu:/home/[username aaa00000]/test_directory/

Now, let's go back over to the [CLUSTER] window to run the file.

First, we need to load R by running the command

module load r/4.2.2

Next, to run our simple R script directly, use:
sbatch -n 1 R CMD BATCH cluster_test.R

Use sacct to check the status of the job

Inspecting this file, you should see that it is written to create a csv called test.csv. Let's move this back to our local computer. 

The following command should be run from the [LOCAL] window. Navigate to whichever directory you want to copy the results to, then run the command:

scp [username aaa00000]@hpc2.storrs.hpc.uconn.edu:/home/[username aaa00000]/test_directory/test.csv . 

You have to remember to include the . at the end, this signals to put it in the current directory.

If you wanted to copy over the contents of the entire directory, use:

scp -r [username aaa00000]@hpc2.storrs.hpc.uconn.edu:/home/[username aaa00000]/test_directory/ . 


Running your code will require r packages. To download the relevant R packages that you'll need, there are
https://kb.uconn.edu/space/SH/26033587623/R+Guide#Install-an-R-package

For my examples going, please install INLA and tidyverse. Note that installing INLA might be more complicated. You can try from an interactive session, or come talk to me.



Sometimes it is better to submit a "batch" of jobs at once. In addition to running the same code multiple times with different inputs, it is also helpful to more clearly control the amount of memory and cores allotted. 

More information available at: https://kb.uconn.edu/space/SH/26032963685/SLURM+Guide

I have included test_batch.sh as an example. It runs the file test_batch.R for four different inputs.

Using [LOCAL], transfer both test_batch.sh and test_batch.R to the cluster.

scp test_batch.R [username aaa00000]@hpc2.storrs.hpc.uconn.edu:/home/[username aaa00000]/test_directory/

scp test_batch.sh [username aaa00000]@hpc2.storrs.hpc.uconn.edu:/home/[username aaa00000]/test_directory/

Run the code on [CLUSTER] using the command

sbatch test_batch.sh

You should get emailed when the code runs.

Once you have run this code, you can transfer back each result to your local computer.


