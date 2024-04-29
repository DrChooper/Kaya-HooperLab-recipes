#!/bin/bash
#SBATCH --job-name=annotate_sequences
#SBATCH --output=annotate_output.log
#SBATCH --error=annotate_error.log
#SBATCH --partition=your_partition
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=1-00:00:00

# Load necessary modules
module load julia

# Add the additional Conda environments path
export CONDA_ENVS_PATH="/group/peb005/conda_env/:$CONDA_ENVS_PATH"

# Activate your environment
conda activate kp1jl

# Run Julia script to annotate sequences
julia -e '
    # Import necessary module
    using Chloe

    # Load reference database from directory
    references = Chloe.ReferenceDbFromDir("/path/to/chloe_references")

    # Annotate sequences and get output file and unique ID
    outfile, uid = Chloe.annotate(references,  "/path/to/testfa/NC_020019.1.fa")

    # Print the output file path
    println(outfile)
'
