Snipe-IT Installation with Ansible
----------------------------------
This repository contains [Ansible](http://www.ansible.com) Role for deploying [Snipe-IT](http://snipeitapp.com/) on Debian based systems. 

* Quick Installation can be performed on production/development server with attached script.
* Sample playbook is available for standalone installations.
* [Vagrant](http://www.vagrantup.com) file is attached for quickly testing Snipe-IT on VM.

## Quick Installation

__Requirements:__

Ubuntu 12.04 and up. ( Testend on Ubuntu 14.04 )

__Installation:__

Connect to target Ubuntu machine and run:

```
wget --no-check-certificate https://raw.github.com/GR360RY/snipeit-ansible/master/scripts/snipeit.sh -O - | sh
```

Following the installation completion, open browser and connect to ubuntu machine using it's FQDN or IP Address.

__Login Credentials__

User:      `foo@example.com`  
Password:  `bar`

Installation will be performed using the default configuration values.


## Default Configuration Values:

| Variable Name                |   Default Value   | 
|:-----------------------------|:-----------------:|
|snipeit_source                |/opt/snipe-it      |
|snipeit_version               |master             |
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
    sudo apt-get -y install python-software-properties software-properties-common
    sudo apt-add-repository -y ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get -y install ansible git

### Clone the repository

    cd $HOME
    git clone https://github.com/GR360RY/snipeit-ansible.git

### Modify the configuration

    cd $HOME/snipeit-ansible

Edit `snipeit.yml` and overwrite the default values:

```yaml
---
- hosts: snipeit 
  sudo: true

  vars:

    snipeit_source: /opt/snipe-it

    snipeit_dbname: snipeit
    snipeit_dbuser: snipeit
    snipeit_dbuser_password: secret

    smtp_host: smtp.example.com
    smtp_port: 25

    admin_first_name: Admin
    admin_last_name: Admin
    admin_email: foo@example.com
    admin_password: bar

    disable_default_apache_site: True
    run_mysql_on_all_interfaces: False

    # If you want to import users from Active Directory to Snipe-IT, uncomment and modify the below values.
    # To import AD users, run /usr/local/bin/import_ad_users.py

    #ldap_uri: 'ldap://dc01.foo.com'
    #ldap_admin: 'CN=Administrator,DC=foo,DC=com'
    #ldap_passwd: 'your_secret_password'
    #users_ou: 'OU=Users,DC=foo,DC=com'

  roles:
    - snipeit-ansible

```
### Install Snipe-IT

    sudo ansible-playbook -i hosts -c local snipeit.yml


### Active Directory User Import

One major feature that is missing from Snipe-IT is Active Directory user import/synchronization. It is important to say that this feature is on the roadmap. But what if you are eager to use Snipe-IT in production and do not want to add each and every user manually? This repository will also deploy simple python script that will import AD users directly into the Snipe-IT database.
Make sure to modify the last block of the vars section. To import AD users, run `/usr/local/bin/import_ad_users.py`


## Testing Snipe-IT with Vagrant

Install the following Requirements:

* [Virtualbox Download Page](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant Download Page](https://www.vagrantup.com/downloads)
* [Ansible Install Page](http://docs.ansible.com/intro_installation.html)

_Note:_ Currently working and tested on OS X only but should work just fine on Linux/BSD system and even Windows.

1. Clone the repository and run `vagrant up`

```bash
cd $HOME
git clone https://github.com/GR360RY/snipeit-ansible.git
cd $HOME/snipeit-ansible
vagrant up
```

2. Open you browser and connect to http://172.20.1.2
3. Login credentials:

User:      `foo@example.com`  
Password:  `bar`
