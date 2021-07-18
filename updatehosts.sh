## update hostname
## sudo hostname new-server-name-here
## -- On localhost
## scp .scriptlocation username@serverip:updatehosts.sh
## remote host usage
## sudo ./updatehosts.sh $HOSTNAME <<newname>>
## https://git.io/JWQWt
## curl https://raw.githubusercontent.com/mmockus/scripts/main/updatehosts.sh --output updatehosts.sh
## curl https://raw.githubusercontent.com/mmockus/scripts/main/updatehosts.sh | sh -s - oldhost newhost


oldname=$1
newname=$2
if [ -z "$oldname" ]
then
      exit N
fi
if [ -z "$newname" ]
then
      exit N
fi
sudo hostnamectl set-hostname $newname
## update the hosts 
sudo sed -i "s/$oldname/$newname/g" /etc/hosts
## Reset machineId
sudo rm -f /etc/machine-id /var/lib/dbus/machine-id
sudo dbus-uuidgen --ensure=/etc/machine-id
sudo dbus-uuidgen --ensure
## regen SSH
## regen ssh keys
sudo rm /etc/ssh/ssh_host_*
sudo dpkg-reconfigure openssh-server
##
sudo reboot
