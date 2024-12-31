#!/bin/sh

if [ "$(id -u)" != "0" ]; then
    echo "Este script debe ejecutarse como superusuario
	asi sudo ./instalacion_minima.sh" 1>&2
   exit 1
fi

printf "%s" "
max_parallel_downloads=10
countme=false
" | sudo tee -a /etc/dnf/dnf.conf


#obtener el home del usuario normal
#USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
USER_HOME=$(eval echo ~$SUDO_USER)
echo $USER_HOME
echo $SUDO_USER
echo -e "\e[34m importando e instalando repositorios de terceros\e[0m"
echo -e "\e[34m vs code \e[0m"
echo -e "\e[34m paciencia \e[0m"
sudo dnf install -y dnf-plugins-core 
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' 
##cd /home/cris/
sudo dnf upgrade -y
echo -e "\e[34m rpm fusion \e[0m"
sudo dnf install -y \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
sudo dnf install -y \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm 

# add the Azul RPM repository 
sudo dnf  install -y https://cdn.azul.com/zulu/bin/zulu-repo-1.0.0-1.noarch.rpm


echo -e "\e[34m brave browser \e[0m"
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo 
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc 
dnf check-update > /dev/null
sudo dnf update  > /dev/null


# Definir el array de paquetes
paquetes=("wget" "tilix"  "git"  "curl" "sway-config-fedora" "flameshot" "zulu17-jdk"
 "rofi"  "leafpad" "pavucontrol.x86_64"  "papirus-icon-theme" "sddm" "xdg-desktop-portal"
"network-manager-applet" "lxappearance" "brave-browser" "brave-keyring" "pipewire" "xdg-desktop-portal-gtk"
"code"  "playerctl" "curl" "bc"  "polkit-gnome" "nitrogen.x86_64" "xscreensaver-base.x86_64" "zsh")

# Iterar sobre los paquetes e imprimir el comando de instalación
#for paquete in "${paquetes[@]}"; do
 #  dnf install -y $paquete > /dev/null
#done
echo -e "\e[34m instalando paquetes basicos \e[0m"
for ((i=1;i<=${#paquetes[@]};i++)); do
    dnf install -y ${paquetes[i-1]}
    echo -e "\e[31mpaquete numero $i instalado\e[0m"
done 
echo -e "\e[32mpaquetes basicos instalados\e[0m"
#cat $USER_HOME/light_dm.txt  
#cd /etc/lightdm/

#cat $USER_HOME/cat light_dm.txt   > /etc/lightdm/lightdm.conf  << "EOF"

#

#EOF



mkdir -p $USER_HOME/.config 
mkdir -p $USER_HOME/.local/share/fonts
cd $USER_HOME/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
fc-cache -f -v
cd $USER_HOME
git clone --depth=1 https://github.com/adi1090x/rofi.git
chown -R $SUDO_USER:$SUDO_USER  $USER_HOME/rofi 
cd rofi
chmod u+x setup.sh
./setup.sh 
#cd $USER_HOME/.config/rofi/launchers/type-5
#cat > launcher.sh  << "EOF"
##!/usr/bin/env bash
#
#dir="~/.config/rofi/launchers/type-5"
#theme='style-4'
#
### Run
#rofi \
#    -show drun \
#    -theme ${dir}/${theme}.rasi
#EOF
usuario="$SUDO_USER"

cd $USER_HOME
cd  $USER_HOME/dotfiles
cp -r  fonts $USER_HOME/.local/share/
fc-cache -f -v
#unzip themes.zip
#unzip icons.zip
#cp -r .themes $USER_HOME

chown -R $SUDO_USER:$SUDO_USER  $USER_HOME/.config 
 
#chown -R usuario:grupo directorio
rm -r $USER_HOME/.config/rofi
cp -r polybar $USER_HOME/.config 
cp -r qtile $USER_HOME/.config 
cp -r openbox  $USER_HOME/.config 
cp -r rofi $USER_HOME/.config 
cp -r conky $USER_HOME/.config 
cp -r i3 $USER_HOME/.config 
cp -r sway $USER_HOME/.config 
cp -r waybar $USER_HOME/.config 
cp -r Imagenes  $USER_HOME
cp -r .themes  $USER_HOME
cd  $USER_HOME
cd $USER_HOME/.config/qtile 
chown $usuario:$usuario  autostart.sh
chmod u+x autostart.sh
cd 

chown -R $SUDO_USER:$SUDO_USER  $USER_HOME/.config 
chown -R $SUDO_USER:$SUDO_USER  $USER_HOME/.local
chown -R $SUDO_USER:$SUDO_USER  $USER_HOME/qtile
chown -R $SUDO_USER:$SUDO_USER  $USER_HOME/Imagenes
chown -R $SUDO_USER:$SUDO_USER  $USER_HOME/zscroll

cd $USER_HOME
sudo localectl set-keymap es
systemctl enable sddm.service 
systemctl set-default graphical.target
reboot