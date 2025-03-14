## SLURM intro - Table of Contents
- [The Whole SLURM](#the-whole-slurm)
- [SLURM Directives](#slurm-directives)
  - [Basic SLURM Script Header](#basic-slurm-script-header)
  - [Requesting Specific Resources](#requesting-specific-resources)
  - [Setting Email Notifications](#setting-email-notifications)
  - [Array Job Configuration](#array-job-configuration)
  - [Setting Environment Variables](#setting-environment-variables)
  - [Defining Dependencies](#defining-dependencies)
  - [Specifying Reservation Name](#specifying-reservation-name)
  - [Enabling Hyper-Threading](#enabling-hyper-threading)
  - [Specifying Account and QoS](#specifying-account-and-qos)
  - [Debugging and Verbose Output](#debugging-and-verbose-output)
  - [Logging and Error Output](#logging-and-error-output)
- [Modules](#modules)
- [Command and Execute](#command-and-execute)
- [Optional Cleanup](#optional-cleanup)
- [To SLURM or not to SLURM](#to-slurm-or-not-to-slurm)



## The Whole SLURM
What is this thing your are asking? Essentially it is the packaging of the computing tasks that you want to do. For example if you want to assemble 100 chloroplast genomes and you have written a script that reads through a folder pairs up the read files, loads the software e.g. GetOrganelle. You would be using SLURM to send it off too a compute node in the supercomputer. So you need to add info for the scheduler to get a big enough computer, load all your software that you need and also tell the computer where the data is and where the results should go.


In practical terms, a SLURM script typically consists of the following parts:

1. **Shebang line**: This specifies the interpreter to be used to execute the script, usually `#!/bin/bash` for bash scripts.

2. **SLURM directives**: These are special comments that provide instructions to the SLURM scheduler on how to allocate resources for the job. Directives include `#SBATCH` lines to specify parameters such as the number of CPU cores, memory requirements, walltime (maximum run time), and output/error log files.

3. **Module loading**: If the job requires specific software or libraries, module loading commands may be included to ensure that the necessary environment is set up before executing the job.

4. **Commands to execute**: This section contains the actual commands or scripts that perform the computational tasks or simulations. These commands should reflect the specific requirements of the job being submitted.

5. **Optional cleanup**: Depending on the workflow, the script may include commands to clean up temporary files or perform post-processing tasks after the job completes.

Overall, a SLURM script provides a structured way to specify job requirements and automate the submission of jobs to an HPC cluster.


## SLURM Directives
Probably also called the header. Will be at the beginning of the script. Here the most commonly used ones

### **Basic SLURM Script Header:**
This contains all the information for the scheduler. It can have many different aspects in it. Some of them are listed below. Some are compulsory.

1. **Job description, time keeping and basics**
   ```bash
   #!/bin/bash
   #SBATCH --job-name=my_job       # Name of the job
   #SBATCH --partition=partition   # Name of partition e.g. work for us
   #SBATCH --time=01:00:00         # Wall clock limit (HH:MM:SS)- max is 4 hours
   #SBATCH --time=1-0              # Wall clock limit for 1 day an 0 minutes
   ```

2. **Requesting Specific Resources:**
This is generally the most challenging to predict. You generally run your program on an interactive node and then assess how much you need for upscaling. This is called benchmarking. 
   ```bash
   #SBATCH --nodes=1               # Number of nodes
   #SBATCH --ntasks-per-node=1     # Number of tasks per node
   #SBATCH --cpus-per-task=4       # Number of CPUs per task
   #SBATCH --mem=8G                # Memory per node
   #SBATCH --gres=gpu:1            # Number of GPUs
   ```

3. **Setting Email Notifications:**
If you are running a lot of jobs you might need a smart inbox so you don't get hammered by these emails.
   ```bash
   #SBATCH --mail-user=email@example.com  # Email address for notifications
   #SBATCH --mail-type=ALL                # Email types (BEGIN, END, FAIL, REQUEUE, ALL)
   ```

4. **Array Job Configuration:**
   ```bash
   #SBATCH --array=1-10        # Job array indices
   ```

5. **Setting Environment Variables:**
If you have your own environment or several groups you are a member of it sometimes can be better to use `--export=NONE` so that there is no confusion.
   ```bash
   #SBATCH --export=ALL        # Export all or no environment variables (ALL, None)
   ```

6. **Defining Dependencies:**
   ```bash
   #SBATCH --dependency=afterok:12345    # Job dependencies (afterok, afternotok, afterany) 
   ```

7. **Specifying Reservation Name:**
   ```bash
   #SBATCH --reservation=my_reservation   # Name of the reservation
   ```

8. **Enabling Hyper-Threading:**
   ```bash
   #SBATCH --threads-per-core=2   # Number of threads per core
   ```

9. **Specifying Account and QoS:**
   ```bash
   #SBATCH --account=my_account   # Account name
   #SBATCH --qos=my_qos           # Quality of Service
   ```

10. **Debugging and Verbose Output:**
    ```bash
    #SBATCH --verbose            # Verbose output for debugging
    #SBATCH --test-only          # Dry run without starting the job
    ```

11. **Logging and Error Output:**
    ```bash
    #SBATCH -o fastp-%j.out      # Log output file with attached job id
    #SBATCH -e fastp-%j.err      # Error file with job id attached
    ```

These headers provide various options for customizing SLURM jobs based on specific requirements.

## Modules 
Modules are packages of installed software on KAYA. You need to "load" a package on your compute node and then you can run your program that requires this type of software. 

This will generate the environment needed for your script to run. Kaya uses a package called `Module` that lets you dynamically modify the shell environment by loading and unloading packages of software. There are central modules and group shared modules for the Hooper Lab.

### Usage
1. Loading a specific version of a software module:
   ```bash
   module load Anaconda3
   ```

2. Loading multiple modules at once:
   ```bash
   module load python blast
   ```

3. Loading a software module and its dependencies:
   ```bash
   module load r/4.0.3
   ```

4. Listing available modules in your module paths:
   ```bash
   module avail
   ```
   If you cannot see the group shared modules you need to add the path to your `.bash_profile` or `.kaya_env.sh` file:
    ```bash
    #connect to group set ups (environments and module packages).n E.g. group `peb007`
    module use -p /group/peb007/modules
    ```
5. Unloading a module:
   ```bash
   module unload r
   ```
   or unload all:
   ```bash
   module purge
   ```

## Command and execute
The "Commands to execute" section of a SLURM script typically contains the actual commands or scripts that perform the computational tasks or simulations required for the job. It is where you define the primary workflow of your job, including any input/output operations, data processing steps, and analysis tasks.

Here some ideas of what you would find for assembling reads:
1. **Quality Control and Preprocessing**: 
   - Copy data to scratch drive
   ```bash
    # Set up directories on scratch space
    mkdir -p /scratch/peb007/chooper/data

    # Copy data from data drive to scratch space
    cp -r /group/peb007/data/* /scratch/peb007/chooper/data/

    # Proceed with computational tasks
    # For example data QC abd peprocessing
    ```
   - Trim adapters and low-quality bases from reads using a tool like Trimmomatic or Cutadapt.
   - Filter out reads with low quality or short length using tools like FastQC or BBTools.
   
2. **Genome Assembly**:
   - Run a genome assembly program like SPAdes, Velvet, or IDBA to assemble the reads into contigs.
   
3. **Assembly Evaluation**:
   - Assess the quality of the assembly using tools like QUAST or BUSCO to check for completeness and accuracy.
   
4. **Post-Processing**:
   - Optionally perform additional steps such as scaffolding, polishing, or error correction depending on the assembly quality and requirements.
   
5. **Output Generation**:
   - Generate output files containing the assembled contigs or scaffolds, assembly statistics, and evaluation reports.

These are just examples, and the specific commands and tools used will depend on factors such as the type of reads, the complexity of the genome, and the desired quality of the assembly.

## Optional cleanup
Here are some unspecific examples of optional cleanup steps after completing the assembly:

```bash
# Remove intermediate files
rm /scratch/peb007/chooper/data/intermediate_files/*.tmp

# Compress large output files
gzip /scratch/peb007/chooper/data/output_files/*.fasta

# Move final output files to a separate directory
mkdir -p /scratch/peb007/chooper/results
mv /scratch/peb007/chooper/data/output_files/*.fasta /scratch/peb007/chooper/results/

# Archive and compress the entire assembly directory for storage
tar -czf /scratch/peb007/chooper/assembly_archive.tar.gz /scratch/peb007/chooper/data/

# Clean up temporary directories
rmdir /scratch/peb007/chooper/data/temp_dir1
rmdir /scratch/peb007/chooper/data/temp_dir2
```

These examples illustrate various cleanup actions that can be performed after the assembly process. These actions may include removing intermediate files, compressing large output files, organizing final results into separate directories, archiving the entire assembly directory for storage, and cleaning up temporary directories used during the process.

### To SLURM or not to SLURM
Working on `KAYA` does not have to use SLURM all the time. If you are just trying something or need to keep a close eye on a proceess you are developing you can use `KAYA` in real time. This is called on DEMAND. 

#### Requesting a node on Kaya
You can request a node to work on it for real time using:

```bash
salloc
```

#### using the OnDemand interphase
where was that link again???

