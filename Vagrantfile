# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|

  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
 
  # The operating system used for this box
  #config.vm.box = "ubuntu/xenial64"
  config.vm.box = "ubuntu/bionic64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. 
  config.vm.network "forwarded_port", guest: 3000, host: 3000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # GOTCHA: the /home/vagrant directory ends up world-writable
  # This attempts to fix that

  config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777", "fmode=777"]

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.synced_folder "code", "/home/vagrant/code", id: "apps", :mount_options => ["dmode=777", "fmode=777"]

  config.vm.synced_folder "ansible", "/home/vagrant/ansible", id: "provision", :mount_options => ["dmode=777", "fmode=666"]	  

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
 
  # for the directory the vm runs in it, and how it appears in Vagrant's lists.
  # the default name of "ror" will be used unless you set an environment variable
  # as below in two places

  config.vm.define "phpdev"
  config.vm.hostname = "phpdev"

  config.vm.provider "virtualbox" do |vb|
    
    # name the Virtual Box (what appears in the Virtual Box GUI)
    vb.name = "phpdev"
    
    # Customize the amount of memory on the VM
    vb.memory = "2048"
    vb.cpus = 4

    # when doing web dev, sometimes launching a web browser is necessary
    vb.gui = false
  end

  #--------------------------------------
  # HACKING VirtualBox Guest Additions

  # setting the auto_update to true above still doesn't sync things all the way
  #config.vbguest.auto_update = true
  # a sync problem existed between host and guest, and this
  # should prevent the discrepancy
  #  if Vagrant.has_plugin?("vagrant-vbguest")
  #    config.vbguest.auto_update = false  
  #  end


  # Install ansible on the vm (tricky to install on Windows)
  # the following line used to do the bulk of ansible provisioning
  # but now mainly just sets up the ansible.cfg file
  # see the ansible lines below in the provision section
  # for the actual ansible provisioning
  config.vm.provision :shell, path: "ansible/ansible-guest.sh"

  # Setup the vm via Ansible provisioning
  
  config.vm.provision "ansible_local" do |ansible|
    ansible.limit = 'all'
    ansible.verbose = true
    ansible.install = true
    
    # untested, but this may pull a later version of ansible:
    ansible.install_mode = ":pip"

    ansible.playbook = "ansible/site.yml"
    ansible.extra_vars = { 
      v_hostname: config.vm.hostname,
      v_ip_address: "192.168.33.10",
      ansible_python_interpreter:"/usr/bin/python3" 
    }    

  end
end
