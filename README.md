Snipe-IT Installation with Ansible
----------------------------------
This repository contains installation scripts for deploying [Snipe-IT](http://snipeitapp.com/) with [Ansible](http://www.ansible.com) on Ubuntu. Installation can be performed on production/development server or tested with [Vagrant](http://www.vagrantup.com). 

## Requirements

* Ubuntu 14.04

## Quick Installation

Connect to target Ubuntu machine and run:

```
wget --no-check-certificate https://raw.github.com/GR360RY/snipeit-ansible/master/scripts/snipeit.sh -O - | sh
```

Following the installation completion, open browser and connect to ubuntu machine using it's FQDN or IP Address.

__Login Credentials__

User:      `foo@example.com`  
Password:  `bar`

Installation will be performed using the default configuration values.


__Default Configuration Values:__

| Variable Name                |   Default Value   | 
|:-----------------------------|:-----------------:|
|snipeit_source                |/opt/snipe-it      |
|snipeit_dbuser                |snipeit            |
|snipeit_dbuser_password       |secret             |
|snipeit_dbname                |snipeit            |
|smtp_host                     |smtp.example.com   |
|smtp_port                     |25                 |  
|admin_first_name              |Admin              |
|admin_last_name               |Admin              | 
|admin_email                   |foo@example.com    |
|admin_password                |bar                |
|disable_default_apache_site   |True               |
|run_mysql_on_all_interfaces   |False              |

## Customising Installation

This Snipe-IT installation playbook can be executed directly on the target machine or from remote host. To simplify the process we will assume that the installation is done directly from the ubuntu that we are deploying Snipe-IT on. Connect to the target ubuntu machine and run the following:

### Install Ansible and git
    sudo apt-get -y install python-software-properties
    sudo apt-add-repository -y ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get -y install ansible git

### Clone the repository

    cd $HOME
    git clone https://github.com/GR360RY/snipeit-ansible.git snipeit

### Modify the configuration

    cd $HOME\snipeit

Edit `snipeit.yml` and overwrite the default values:

```yaml
---
- hosts: snipeit 
  sudo: true

  vars:

    snipeit_source: /var/www/another_folder

    snipeit_dbname: my_db
    snipeit_dbuser: foo
    snipeit_dbuser_password: bar

    smtp_host: smtp.foo.com
    smtp_port: 25

    admin_first_name: Admin
    admin_last_name: Admin
    admin_email: john@foo.com
    admin_password: my_secret_password

    disable_default_apache_site: False
    run_mysql_on_all_interfaces: False

    # If you want to import users from Active Directory to Snipe-IT, modify the below values.
    # To import AD users, run /usr/local/bin/import_ad_users.py

    ldap_uri: 'ldap://dc01.foo.com'
    ldap_admin: 'CN=Administrator,DC=foo,DC=com'
    ldap_passwd: 'your_secret_password'
    users_ou: 'OU=Users,DC=foo,DC=com'


  roles:
    - snipeit

```
### Active Directory User Import

One major feature that is missing from Snipe-IT is Active Directory user import/syncronisation. It is important to say that this feature is on the roadmap. But what if you are eager to use Snipe-IT in production and do not want to add each and every user manually? This repository will also deploy simple python script that will import AD users directly into the Snipe-IT database.
Make sure to modify the last block of the vars section. To import AD users, run `/usr/local/bin/import_ad_users.py`

### Install Snipe-IT

    sudo ansible-playbook -i hosts -c local snipeit.yml

## Testing Snipe-IT with Vagrant

1. Install Vagrant on your Linux or Mac: [Vagrant Download Page](https://www.vagrantup.com/downloads)
2. Clone the repository and run `vagrant up`

```bash
cd $HOME
git clone https://github.com/GR360RY/snipeit-ansible.git snipeit
cd $HOME\snipeit
vagrant up
```

3. Open you browser and connect to http://172.20.1.2
4. Login credentials:

User:      `foo@example.com`  
Password:  `bar`
