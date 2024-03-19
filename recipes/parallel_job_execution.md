## Parallel Job Execution

This recipe demonstrates how to submit a parallel job to the SLURM scheduler for execution on an HPC cluster.

### Prerequisites

Before you begin, ensure that you have:

- Access to an HPC cluster with SLURM installed.
- A parallelizable task or program that you want to execute in parallel.

### Submission Steps

1. **Prepare Your Parallel Task**: Ensure that your task or program is parallelizable and can benefit from parallel execution.

2. **Create Your Parallel SLURM Submission Script**: Write a SLURM submission script (`parallel_job.sh`) specifically for parallel execution. Here's an example script:

    ```bash
    #!/bin/bash
    #SBATCH --job-name=parallel_job
    #SBATCH --output=output.log
    #SBATCH --partition=your_partition
    #SBATCH --nodes=2
    #SBATCH --ntasks-per-node=4
    #SBATCH --time=1:00:00

    # Load any required modules (if applicable)
    module load your_module

    # Run your parallel task or program
    mpiexec -n 8 your_parallel_program
    ```

    Replace `your_partition` and `your_module` with appropriate values, and adjust the `--nodes` and `--ntasks-per-node` parameters according to your parallel task requirements.

3. **Submit Your Parallel Job**: Use the `sbatch` command to submit your parallel SLURM submission script:

    ```bash
    sbatch parallel_job.sh
    ```

    This command submits your parallel job to the SLURM scheduler for execution.

4. **Monitor Your Job**: Use `squeue -u your_username` to monitor the status of your job:

    ```bash
    squeue -u your_username
    ```

    Replace `your_username` with your actual username.

5. **Retrieve Output**: Once your job completes, check the output file specified in your submission script (`output.log`) for any results or errors.

## Contributing

If you have additional SLURM recipes or improvements to existing recipes, contributions are welcome! Please follow the [contribution guidelines](CONTRIBUTING.md) before submitting a pull request.

## License

This repository is licensed under the [MIT License](LICENSE), which means you are free to use, modify, and distribute the content as long as you include the original copyright notice.
