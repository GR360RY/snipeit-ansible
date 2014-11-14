# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "172.20.1.2"
  config.vm.network "forwarded_port", guest: 3306, host: 3306
  config.vm.hostname = "snipeit-dev"

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "snipeit.yml"
    ansible.groups = {"snipeit" => ['default']}
    ansible.extra_vars = { 
      disable_default_apache_site: 'True',
      run_mysql_on_all_interfaces: 'True'
     }
  end

end