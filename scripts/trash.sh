#!/bin/bash

# Trash Script
# This script moves a file to a "trash" directory (~/.trash/).
# If the file has multiple hard links or is a symbolic link, it is moved directly.
# If the file is unique, the user is asked for confirmation before moving.
# The file is renamed with a timestamp before moving to the trash.

function trash {
  # Check the number of hard links
  linkn=$(find ~/michael/notebook/ ~/.config/ -samefile "$1" | awk 'END{print NR}')
  
  if [ $linkn -gt 1 ]; then
    # If there are multiple hard links, move the file directly to trash
    mv "$1" "$1"$(date +%F-%H:%M:%S)
    mv "$1"$(date +%F-%H:%M:%S) ~/.trash/
  else 
    if [ -L "$1" ]; then
      # If the file is a symbolic link, move it directly to trash
      mv "$1" "$1"$(date +%F-%H:%M:%S)
      mv "$1"$(date +%F-%H:%M:%S) ~/.trash/
    else
      # If the file is unique, ask for deletion confirmation
      echo "delete?[y/n]"
      read ans
      if [ "$ans" = "y" ]; then
        mv "$1" "$1"$(date +%F-%H:%M:%S)
        mv "$1"$(date +%F-%H:%M:%S) ~/.trash/
        echo "deleted!"
      else
        echo "canceled"
      fi
    fi
  fi
}

trash "$1"
