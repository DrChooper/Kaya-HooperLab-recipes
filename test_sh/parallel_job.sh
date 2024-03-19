#!/bin/bash

# Define a function for the task to be executed in parallel
task() {
    echo "Starting task $1"       # Print a start message indicating the task number
    sleep $((RANDOM % 5))         # Simulate some computation time by sleeping for a random duration (up to 5 seconds)
    echo "Task $1 completed"      # Print a completion message indicating the task number
}

# Set the number of parallel tasks to run
NUM_TASKS=4

# Run tasks in parallel using GNU parallel
seq $NUM_TASKS | parallel -j $NUM_TASKS task
