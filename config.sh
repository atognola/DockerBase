#!/bin/bash

if [ ! "$(ls -A $HOME/.ssh)" ]
then
  echo "No ssh key pair has been found in your home folder ${HOME}."
  echo "Do you want to create a new pair now?"
  select yn in "yes" "no"
  do
    case $yn in
      yes ) read -p "Enter your email: " ANSWER; ssh-keygen -t rsa -b 4096 -C "${ANSWER}"; ANSWER=""
            echo "***** WARNING: Adding StrictHostKeyChecking=no to ${HOME}/.ssh/config. If this is a concern for you please edit the file and remove it. *****"
            echo "Host *" >> ${HOME}/.ssh/config
            echo "  StrictHostKeyChecking no" >> ${HOME}/.ssh/config
            echo
            break
      ;;
      no ) echo "**********************************************************************************"
           echo "***** WARNING: Skipping ssh configuration.                                   *****"
           echo "***** WARNING: You will have to add your own keys under ${HOME}/.ssh folder. *****"
           echo "**********************************************************************************"
           echo
           break
      ;;
    esac
  done
fi

if [ -z "$(git config --global --get user.name)" -o -z "$(git config --global --get user.email)" ]
then
  echo "git is not configured"
  echo "Do you want to configure it now?"
  select yn in "yes" "no"
  do
    case $yn in
      yes ) read -p "Enter your name: " ANSWER; git config --global user.name "${ANSWER}"; ANSWER=""
            read -p "Enter your email: " ANSWER; git config --global user.email "${ANSWER}"; ANSWER=""
            if [ ! -z "$(git config --global --get user.name)" -a ! -z "$(git config --global --get user.email)" ]
            then
              git config --global --list
              break
            else
              echo "Invalid input, retry."
            fi 
      ;;
      no ) echo "************************************************"
           echo "***** WARNING: Skipping git configuration. *****"
           echo "************************************************"
           echo
           break
      ;;
    esac
  done
fi
