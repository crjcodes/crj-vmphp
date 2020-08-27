#!/usr/bin/bash

# NAME
#   launch - kicks off the Vagrant virtual machine instance
#
# TODO: change usage section to common Unix format
#
# SYNOPSIS
#   The virtual machine instance runs from the deployed files in the
#   in the base path of the deployed project.  It performs the 
#   necessary vagrant commands to bring up the vm
#
#   It can by default "boot up" a new or existing vm instance:
#
#       ./launch.sh
#
#   boot with certain updates to the Vagrant and Ansible files (aka 
#   re-provisioning):
#
#       ./launch.sh -p
#       ./launch.sh --provision
#
#   or destroy any pre-existing vm instance before booting the vm:
#
#       ./launch.sh --new
#   
# OPTIONS
#   
#   -p, --provision
#   : boot and re-provision Vagrant and Ansible files 
#
#   --new
#   : destroy any pre-existing vm instance before booting the vm
#
#
#   -h, --help
#   : show usage
#
# TODO: convert from echo to printf
# TODO: test with weird states, like aborted VMs
# TODO: ?change to follow a style guide?


set -o errexit   # exit if a command fails
#set -o xtrace  # for debugging

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__name="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
echo "=== INFO: Launching VM in directory, ${__dir}"

new=false
provision=false
usage=false

usage()
{
    echo ""
    echo "usage: ./$__name [-p(rovision) | --new | -h(elp) ]"
    echo "  -h | --help           this usage"
    echo "  -p | --provision      reprovision the existing virtual machine before launching"
    echo "  --new:                destroy instance of existing vm of same name, if any, and start a new one"
    exit 1  
}

#---------------------------------
# Testing for command-line parameters

while [[ "$1" != "" ]]; do
    echo "=== INFO: argument [$1]"
    case $1 in
      -p | --provision )
        provision=true
        ;;
      --new )
        new=true
        ;;
      -h | --help )
        usage
        exit 0
        ;;
      *)
        echo "=== ERROR: invalid parameter"
        usage
        exit 1
        ;;
    esac
    shift
done    

if [ "$new" = true ] && [ "$provision" = true ]
then
  echo "=== ERROR: new and provision incompatible parameters"
  usage
  exit 1
fi


#--------------------------------
# Reporting on parameters

if [ "$new" = true ]
then
  echo "=== INFO: starting brand-new instance of the vm"
else
  echo "=== INFO: starting whatever instance of the vm exists (or a new one, depending)"
fi

if [ "$provision" = true ]
then
  echo "=== INFO: Re-provisioning the vm"
fi

#=================================
# ERROR CHECKING
#

if [ -f "deploy.sh" ]
then
  echo "=== ERROR: must be run in deployment directory"
  exit 1
fi

if [ ! -f "Vagrantfile" ]
then
  echo "=== ERROR: Vagrantfile not found.  Have you deployed from the development path?  Are you running this script in the deployment area?"
  exit 1
fi

#=================================
# FUNCTIONS

#=================================
# MAIN
#

echo "=== INFO: running with new=${new} and provision=${provision}"

if [ "$new" = true ]
then
  echo "=== INFO: destroying previous instance of the vm if any"
  vagrant halt
  vagrant destroy --force
fi

# launch the virtual machine

if [ "$provision" = true ]
then
  vagrant up --provision
else
  vagrant up
fi

# HACK to handle the problem with vbguest addition versions
# If the version on the host does not match the guest,
# it may cause problems with permissions in shared
# directories

VPATH="`which vagrant`"
echo "=== INFO: attempting installation of vbguest addition"
$VPATH plugin install vagrant-vbguest 2>&1
echo ""