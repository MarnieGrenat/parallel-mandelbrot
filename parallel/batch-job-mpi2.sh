#!/bin/bash
#SBATCH --job-name=mpi_test_cases            # Job name
#SBATCH --nodes=1                            # Specify the number of nodes
#SBATCH --ntasks=16                          # Max number of tasks (use mpirun --oversubscribe for more)
#SBATCH --cpus-per-task=1                    # Number of CPU per tasks
#SBATCH --time=01:00:00                      # Max total job runtime
#SBATCH --output=output_%j.log               # Log file (one for the whole job, %j is the job ID)
#SBATCH --error=error_%j.log                 # Error log file
#SBATCH --exclusive                          # Allocate the node exclusively (comment out for shared access)
##SBATCH --mail-type=ALL                     # Send email for all job events (start, end, fail)
##SBATCH --mail-user=example@edu.pucrs.br    # Email address for notifications

# Dynamically set working directory
WORKDIR="/home/$USER/parallel-mandelbrot"

# Compile code
mpicc parallel/mandelbrot_mpi.c -o mandelbrot_mpi -lm

# Run test cases
for process in  `seq 56 2 64`
do

echo "Running with -np $process"

mpirun --oversubscribe -np $process mandelbrot_mpi
done
