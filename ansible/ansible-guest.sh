#!/usr/bin/env bash
#
#  PURPOSE
#
# If anything special for Ansible needed on the guest vm 
#  before doing the provisioning laid out at the end of the Vagrantfile,
#  do it here

#=====================================
# ANSIBLE CUSTOM CONFIGURATION
# 
# Used to color the logging statements that appear as the virtual
# machine is provisioned.
#
# Makes it much easier to read
#

cat >> /home/vagrant/ansible.cfg <<EOL
# config file for ansible -- https://ansible.com/
# ===============================================

# nearly all parameters can be overridden in ansible-playbook
# or with command line flags. ansible will read ANSIBLE_CONFIG,
# ansible.cfg in the current working directory, .ansible.cfg in
# the home directory or /etc/ansible/ansible.cfg, whichever it
# finds first

[defaults]
nocolor = 0

[colors]
highlight = white
verbose = blue
warn = bright purple
error = red
debug = dark gray
deprecate = purple
skip = cyan
unreachable = red
ok = green
changed = yellow
diff_add = green
diff_remove = red
diff_lines = cyan
EOL


