#!/bin/bash

# Check if we're in our subshell, if not, create it and touch
# .IN_SUBSH so our inner process knows
if [ -e ".IN_SUBSH" ]; then
  shopt -s extglob
  for item in $(ls ~/.ssh/!(*.pub|known_hosts)); do
    ssh-add $item
  done
  rm .IN_SUBSH
  shopt -u extglob
else
  touch .IN_SUBSH
  ssh-agent /bin/bash --rcfile <(echo "`pwd`/ssh-setup.sh")
fi

# I apologize in advance for writing this ghastly script 
# ~Dave
