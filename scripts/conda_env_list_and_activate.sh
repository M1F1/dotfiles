#!/bin/bash

conda-env-list-and-activate() {
  # Store the list of environments in an array
  envs=($(conda env list | awk '{print $1}' | tail -n +4))
  echo "$envs"
  echo "${envs[1]}"

  # Print the numbered list of environments with zero-based index
  echo "Available Conda environments:"
  index=1
  for env in "${envs[@]}"; do
    echo "$index. $env"
    index=$((index + 1))
  done

  # Prompt the user to select an environment by number
  echo "Enter the number of the environment you want to activate:"
  read env_number

  # Validate the input and handle the selection
  if [[ "$env_number" =~ ^[0-9]+$ ]] && [[ "$env_number" -ge 0 && "$env_number" -lt "${#envs[@]}" ]]; then
    env_name=${envs[$env_number]}
    echo "Activating environment: $env_name"
    conda activate "$env_name"
  else
    echo "Invalid number. Please try again."
  fi
}
