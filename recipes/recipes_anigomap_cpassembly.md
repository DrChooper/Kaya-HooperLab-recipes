# Walk Through for a Bash Script that assembles Chloroplasts on Kaya

This recipe demonstrates how to submit a bash script that assembles to the SLURM scheduler for execution on an HPC cluster.

### Prerequisites

Before you begin, ensure that you have:

- Access to Kaya.
- Are using the VPN or are within UWA Wifi
- A bash script - either yours are use the default (`anigo_cp_assembly.sh`) that you want to submit for execution.

Login to `Kaya` by opening the terminal or using VS code and ssh into Kaya
```bash
ssh <username>@kaya.hpc.uwa.edu.au
```
This gives you access to the head node which is used to load your modules, manage data moves, write and submit SLURM scripts.

### Creating or using a conda ennviroment
Anaconda is preinstalled on Kaya so you need to load the module in. 
```bash
module load Anaconda3/2021.05
```
For the AnigoMap project (peb005) please create or use conda environments that are stored in the `/group/peb005/conda_env` folder. The environment used for this project is called `kp1jl` and was created like this:

```bash
conda create -p /group/peb005/conda_env/kp1jl -c bioconda
```
Make sure you set your `.bashrc` file (in your home directory) to find the environment to find the group files by adding the following to the bottom fo the file:
```bash
# Add the additional Conda environments path
export CONDA_ENVS_PATH="/group/peb005/conda_env/:$CONDA_ENVS_PATH"
```
Then you can activate your environment by `conda activate kp1jl`.

### Adding to your environment
You can create Julia project (for using Chloe):
```bash
# create a Julia project in directory and then go to it
julia -e 'using Pkg; Pkg.generate("kpannotate") && cd("kpannotate")'

# add Chloe to the project
julia --project=. -e 'using Pkg; Pkg.add(url="https://github.com/ian-small/chloe.git")'
```

Then import the references for Chloe. Is you use this, the references will be a folder in your home directory
```bash
julia -e 'import Pkg; Pkg.GitTools.clone(stdout, "https://github.com/ian-small/chloe_references", "chloe_references")'
```



### Submission Steps

1. **Create Your Bash Script**: Write your bash script (`your_script.sh`) with the necessary commands and instructions.

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