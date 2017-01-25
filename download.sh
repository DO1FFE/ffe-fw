#!/bin/bash
#
# <c> Leon Hellmann 09.02.2016
# Auto Downloader für die Essener Firmware
# In der Firmware.txt Datei könnt ihr bestimmen welche Downloads ihr haben möchtet
# indem ihr die Downloads die ihr nicht braucht aus der Datei löscht.
#
# Aktuelle FW Version gluon-ffe-2.2.1-1
#
clear
# Die URL von der gedownloadet werden soll. An diese wird hinterher der Dateiname abgehangen
URL=https://images.freifunk-essen.de/stable/
BISJ=1
# Überprüfung ob der Server überhaupt erreichbar ist.
ping -c1 -W5 images.freifunk-essen.de >/dev/null 2>&1
# Ausgabe und Beendigung falls Server nicht erreichbar
case $? in
	0) ;;
	1) echo "Keine Verbindung zum Server" ; exit ;;
	2) echo "Keine Verbindung zum Server" ; exit ;;
esac

# Wenn firmware-Verzeichnis schon existiert, löschen
if [ -d "firmware" ]; then
  rm -rf firmware
fi
# firmware-Verzeichnis erstellen wenn es nicht existiert
if [ ! -d "firmware" ]; then
  mkdir firmware
fi
# Einzelne Dateinamen aus Firmware.txt holen
for LINK in $(cat Firmware.txt)
do
	if [ "1" != "$BISJ" ] 
	then 
		echo "$BISJ Downloads Geladen"
	else
		echo "$BISJ Download Geladen"
	fi
	BISJ=$(($BISJ + 1))
# Wer eine Ausgabe haben möchte die einem bei jedem Download den genauen Link ausgibt der muss die
# nächste Zeile auskommentieren und die übernächste einkommentieren.
	echo "$URL$LINK"
#	echo "$LINK"
# Download der Datei und Speicherung in Ordner firmware/
	wget -N -P firmware/  $URL$LINK >/dev/null 2>&1
done
echo "Fertig"
