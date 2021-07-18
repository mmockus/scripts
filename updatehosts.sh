## update hostname
## sudo hostname new-server-name-here
## -- On localhost
## scp .scriptlocation username@serverip:updatehosts.sh
## remote host usage
## sudo ./updatehosts.sh $HOSTNAME <<newname>>

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
rm -f /etc/machine-id /var/lib/dbus/machine-id
dbus-uuidgen --ensure=/etc/machine-id
dbus-uuidgen --ensure
## regen SSH
## regen ssh keys
sudo rm /etc/ssh/ssh_host_*
sudo dpkg-reconfigure openssh-server
##
sudo reboot
