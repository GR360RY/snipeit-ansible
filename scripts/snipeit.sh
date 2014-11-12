echo "\n\033[0;32m >> Install Git and Ansible\033[0m"
sudo apt-get update
sudo apt-get -y install software-properties-common python-software-properties
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y install git ansible
if [ ! -d "$HOME/snipeit-ansible" ]; then
	echo "\n\033[0;32m >> Clone snipeit-ansible installation repository\033[0m"
	git clone git://github.com/GR360RY/snipeit-ansible.git "$HOME/snipeit-ansible"
else
	"\n\033[0;32m >> Snipeit-Ansible Installation repo is already available\033[0m"
fi
cd "$HOME/snipeit-ansible"
echo "\n\033[0;32m >> Install Snipe-IT\033[0m"
USER_ID=$(id -u)
if test "$USER_ID" = "0"
then
        ansible-playbook -i hosts -c local snipeit.yml
else
        ansible-playbook -i hosts -K -c local snipeit.yml
fi
