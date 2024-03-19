#!/bin/bash

# Your Script

# Print a message indicating the start of the script
echo "Starting your_script.sh"

# Print some information about the system
echo "System Information:"
echo "Hostname: $(hostname)"    # Print the hostname of the system
echo "Date: $(date)"            # Print the current date
echo "User: $USER"              # Print the username of the current user

# Print a separator line for clarity
echo "---------------------"

# Print the contents of the current directory
echo "Contents of Current Directory:"
ls -l                           # List the contents of the current directory in long format

# Print a separator line for clarity
echo "---------------------"

# Simulate some computation by running a command (e.g., a simple calculation)
echo "Running a Simple Calculation:"
echo "Result: $(echo "3 * 5" | bc)"   # Perform a simple calculation (3 * 5) using the 'bc' command-line calculator

# Print a separator line for clarity
echo "---------------------"

# Print a message indicating the end of the script
echo "your_script.sh completed"
