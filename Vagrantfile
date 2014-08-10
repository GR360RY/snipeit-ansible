# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "172.20.1.2"
  config.vm.network "forwarded_port", guest: 3306, host: 3306
  # config.vm.network "public_network"
  config.vm.hostname = "snipeit-dev"
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #   vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
  #   vb.customize ["modifyvm", :id, "--vram", "128"]
  #   vb.customize 'post-boot', ["controlvm", :id, "setvideomodehint", "1280", "720", "24"]
  # end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "snipeit.yml"
    ansible.groups = {"snipeit" => ['default']}
    ansible.extra_vars = { 
      disable_default_apache_site: 'True',
      run_mysql_on_all_interfaces: 'True'
     }
  end

  # config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  # config.vm.provision :shell, :inline => "sudo service lightdm restart"

end