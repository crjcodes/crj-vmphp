#!/usr/bin/bash

# Purpose: Deployment of virtual machine provisioning and launch files
#
# Copies the necessary virtual machine files from a development 
# location to a location where the vm will be launched
#
# TODO: change usage section to common Unix format
# Usage: "./deploy.sh [ {deploy path} {deploy machine}]"
#   First parameter:
#     .  Optional
#     .  If not given, defaults to the "default_deploy_path" below
#     .  If the path doesn't exist, the script will error out
#
#   Second parameter:
#     .  Optional
#     .  The virtual machine name to use
#     .  If not given, the script uses the environment variable, MACHINE if set
#     .  If no environment variable, the script uses "default_machine" below
#
# 
# TODO: convert from echo to printf
# TODO: incorporate better practices for Bash scripts as appropriate
#
# TODO: add third parameter to update the os via an updated virtualbox and change to case/esac argument evaluation

set -o errexit   # exit if a command fails
# set -o xtrace  # for debugging

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

arg1="${1:-}"
arg2="${2:-}"
arg3="${3:-}"

default_deploy_path="/f/dev/work/vm/"
default_machine="php"

#=================================
# ERROR CHECKING
#

#---------------------------------
#  In dev directory?
#

# TODO: improve this check
if [ ! -f "README.md" ]
then
  echo "=== ERROR: must be run in development directory"
  exit 1
fi

#---------------------------------
# VM LAUNCH AREA

# Determine the path where the VM will be launched -- where
# to deploy the vm and provisioning files

deploy="${arg1}"

if [ -z "${deploy}" ] 
then
  deploy="${default_deploy_path}"
fi 

if [ ! -d "${deploy}" ]
then
  echo "=== ERROR: No such directory, ${deploy}"
  exit 1
fi


#===================================
#  PREPARING FOR DEPLOYMENT

#---------------------------------
# VM NAME FOR THIS LAUNCH

# Determine what to call this particular virtual machine
# being launched.  This will also be the name of the 
# subdirectory containing the launch files

mach="$arg2"

if [ -z "${mach}" ] 
then
  if [ ! -z "${MACHINE}" ]
  then
    mach="${MACHINE}"
  else
    mach="${default_machine}"
  fi
fi

#---------------------------------
# VM NAME FOR THIS LAUNCH

fullpath="${deploy}/${mach}"
if [ ! -d "${fullpath}" ] 
then
  echo "=== INFO: making directory, ${mach}"
  cd "${deploy}"
  mkdir "${mach}"
fi

if [ ! -d "${fullpath}" ] 
then
  echo "=== ERROR: could not create path, ${fullpath}"
  exit 1
fi

#---------------------------------
# DEPLOYMENT

# Copy the directories and files needed to launch the VM

# NOTE: the source is the development area NOT the GitHub repo
# NOTE: the -u parameter for the copy will only update files as necessary

echo "=== INFO: attempting to deploy to ${fullpath}"

# ASSUMPTION: you're running this from the development directory,
# the "root" directory of the GitHub project, locally

echo "=== INFO: preparing to copy from ${__dir} to ${fullpath}"

cp -u "Vagrantfile" "${fullpath}"
cp -u "launch.sh" "${fullpath}"
cp -u -r ansible "${fullpath}"
cp -u -r code "${fullpath}"

echo "=== INFO: Deployment completed"
