# Walk Through for a Bash Script that assembles Chloroplasts on Kaya

This recipe demonstrates how to submit a bash script that assembles to the SLURM scheduler for execution on an HPC cluster.

### Prerequisites

Before you begin, ensure that you have:

- Access to Kaya.
- Are using the VPN or are within UWA Wifi
- A bash script - either yours are use the default (`anigo_cp_assembly.sh`) that you want to submit for execution.
- log onto KAYA using VScode


### Submission Steps

1. **Create Your Bash Script**: Write your bash script (`your_script.sh`) with the necessary commands and instructions. Write it with 


2. **Prepare Your SLURM Submission Script**: Create a SLURM submission script (`submit_job.sh`) to specify job parameters and submit your bash script.

    ```bash
    #!/bin/bash
    #SBATCH --job-name=your_job_name
    #SBATCH --output=output.log
    #SBATCH --partition=your_partition
    #SBATCH --nodes=1
    #SBATCH --ntasks-per-node=1
    #SBATCH --time=1:00:00

    # Load any required modules (if applicable)
    module load your_module

    # Run your bash script
    bash your_script.sh
    ```

    Replace `your_job_name`, `your_partition`, and `your_module` with appropriate values.

3. **Submit Your Job**: Use the `sbatch` command to submit your SLURM submission script:

    ```bash
    sbatch submit_job.sh
    ```

    This command submits your job to the SLURM scheduler for execution.

4. **Monitor Your Job**: Use `squeue -u your_username` to monitor the status of your job:

    ```bash
    squeue -u your_username
    ```

    Replace `your_username` with your actual username.

5. **Retrieve Output**: Once your job completes, check the output file specified in your submission script (`output.log`) for any results or errors.