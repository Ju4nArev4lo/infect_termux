#!/usr/bin

# COLORES
red='\e[1;31m'
default='\e[0m'
yellow='\e[0;33m'
orange='\e[38;5;166m'
green='\033[92m'
clear
# banner
echo -e "$green ██ ███    ██ ███████ ████████  █████  ██       █████  ███    ██ ██████   ██████  "
echo -e "$green ██ ████   ██ ██         ██    ██   ██ ██      ██   ██ ████   ██ ██   ██ ██    ██ "
echo -e "$green ██ ██ ██  ██ ███████    ██    ███████ ██      ███████ ██ ██  ██ ██   ██ ██    ██ "
echo -e "$green ██ ██  ██ ██      ██    ██    ██   ██ ██      ██   ██ ██  ██ ██ ██   ██ ██    ██ "
echo -e "$green ██ ██   ████ ███████    ██    ██   ██ ███████ ██   ██ ██   ████ ██████   ██████  "
echo -e "$green                                  BY JU4N                                         "

#revisando internet
ping -c 1 google.com > /dev/null 2>&1
if [[ "$?" == 0 ]]; then
echo ""
echo -e "$orange[revisando internet]..........[ OK ]"
sleep 1.5
else
echo ""
echo -e "$red[revisando internet]..........[ FALLO ]"	
echo ""
exit
fi

# revisando dependencias
echo -e $orange
echo -n [*] Checando dependencias...= ;
sleep 3 & while [ "$(ps a | awk '{print $1}' | grep $!)" ] ; do for X in '-' '\' '|' '/'; do echo -en "\b$X"; sleep 0.1; done; done 
echo ""

# checando si tienes instalado apktool
which apktool > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo ""
echo -e "$green[Apktool]..........[ OK ]"
sleep 1.5
else
echo ""
echo -e "$red[ X ][Apktool]..........[ FALLO ]"
sleep 1.5
echo -e "$yellow[INSTALANDO APKTOOL...]"
git clone https://github.com/rendiix/termux-apktool
cd termux-apktool
chmod +x *
bash install.sh 
fi

# checando si tienes intalado jarsigner
which jarsigner > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo ""
echo -e "$green[Jarsigner]........[ OK ]"
sleep 1.5
else
echo ""
echo -e "$red[ X ][Jarsigner]..........[ FALLO ]"
sleep 1.5
echo -e "$yellow[INSTALANDO JARSIGNER...]"
apt-get install openjdk-17 -y
fi

# checando si tienes intalado zipalign
which zipalign > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo ""
echo -e "$green[Zipalign].........[ OK ]"
sleep 1.5
else
echo ""
echo -e "$red[ X ][Zipalign]..........[ FALLO ]"
sleep 1.5
echo -e "$yellow[INSTALANDO ZIPALIGN...]"
apt-get install zipalign -y
fi

# checando si tienes instalado metasploit-framework
which msfconsole > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo ""
echo -e "$green[Metasploit].......[ OK ]"
sleep 1.5
else
echo ""
echo -e "$red[ X ][Metasploit].........[ FALLO ]"
sleep 1.5
echo -e "$yellow[INSTALANDO METASPLOIT-FRAMEWORK...]"
git clone https://github.com/yassange/METASPLOIT_YASSANGE7
cd METASPLOIT_YASSANGE7
chmod +x *
apt-get install wget -y
apt-get install curl -y
bash METASPLOIT7.sh 
fi

# final
sleep 2
echo -e $orange
echo -e "╔───────────────────────────╗"
echo -e "|[✔] INSTALACION COMPLETADA.|"
echo -e "┖───────────────────────────┙"
exit