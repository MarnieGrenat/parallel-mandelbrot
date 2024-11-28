#!/bin/bash
# Verifica se o número de parâmetros fornecidos é correto
if [ "$#" -lt 2 ]; then
    echo "Uso: $0 <num_nodes> <num_tasks>"
    exit 1
fi

# Atribui os parâmetros passados para as variáveis
NUM_NODES=$1
NUM_TASKS=$2
NUM_CPUS=$3

# Comando a ser executado, substituindo os parâmetros no comando 'srun'
COMMAND="srun --nodes=$NUM_NODES --ntasks=$NUM_TASKS --cpus-per-task=$NUM_CPUS ./mandelbrot_omp"

# Compilando o carinha
gcc parallel/mandelbrot_openmp.c -o mandelbrot_omp -fopenmp -lm

# Coleta o tempo de execução usando o comando 'time'
echo "Executando: $COMMAND"
{ time $COMMAND; } 2>&1 | grep real
