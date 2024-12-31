
echo -e "\e[34m aplicando un hardering basico \e[0m"
# Cambiar el umask a 077
umask 077

# Configurar iptables para bloquear todas las conexiones entrantes
iptables -P INPUT DROP

# Desactivar el servicio SSH para evitar conexiones remotas
systemctl stop sshd
systemctl disable sshd

# Establecer una política de contraseñas más segura
#sudo authconfig --passalgo=sha512 --passminlen=12 --passminclass=4 --enablereqlower --enablerequpper --enablereqdigit --enablereqother --update

# Deshabilitar el acceso de root a través de SSH
sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
#sudo systemctl restart sshd

# Configurar SELinux para aplicar políticas restrictivas
sudo setenforce Enforcing
sudo sed -i 's/SELINUX=disabled/SELINUX=enforcing/' /etc/selinux/config
read -p "¿Quiere activar el modo pánico del firewall?
Puertos admitidos: 53/UDP, 443/TCP y 80/TCP.
Puede que algunas aplicaciones dejen de funcionar correctamente. (y/n): " opcion
if [[ "$opcion" =~ ^[Yy] ]]
	then
  dnf install -y iptables-services > /dev/null
  dnf remove -y firewalld  > /dev/null
interfaz=$(ip route | grep default | awk '{print $5}')

# Limpiar todas las reglas existentes
sudo iptables -t filter -F
sudo iptables -t nat -F 
sudo iptables -t filter -Z
sudo iptables -t nat -Z 

 sudo iptables -P INPUT DROP
 sudo iptables -P OUTPUT DROP
 sudo iptables -P FORWARD DROP 

interfaz=$(ip route | grep default | awk '{print $5}')

sudo iptables -A OUTPUT -o $interfaz  -p udp --dport 53 -j ACCEPT 
sudo iptables -A INPUT -i $interfaz  -p udp --sport 53 -j ACCEPT 

sudo iptables -A OUTPUT -o $interfaz  -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -i $interfaz  -p tcp --sport 80 -j ACCEPT

sudo iptables -A OUTPUT -o $interfaz -p tcp --dport 443 -j ACCEPT
sudo iptables -A INPUT -i $interfaz  -p tcp --sport 443 -j ACCEPT
iptables-save
systemctl enable iptables.service 
echo -e "\e[34m firewall usado: iptables consulte la documentacion\e[0m"
echo -e "\e[34m puerto admitidos 53/upd 443/tcp y 80/tcp, basicos para la nevagacion web\e[0m"
echo -e "\e[34m consulte $USER_HOME/dotfiles/firewall para ver ejemplos de configuracion o consulte la doc de iptables \e[0m"
fi
echo "Configuraciones restrictivas aplicadas."