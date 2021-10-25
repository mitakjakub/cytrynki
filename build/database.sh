#!/bin/bash
    data=`date +'%Y-%m-%d'`
    url=`curl -d "data=$data&submit=Zmie%C5%84+dat%C4%99" -H "Content-Type: application/x-www-form-urlencoded" -X POST https://zlobki.waw.pl/nasze-placowki/statystyki/ | grep zlobek-nr-69 | cut -d '"' -f2`
    ilosc=`curl -s $url | grep -A1 'Dzieci obecnych' | grep -m 1 [0-9] | tr -d '<>td' | awk '{ print $1 }'`

if [ ! $ilosc ]; then
    ilosc='0';
fi
sqlite3 /cytrynkidb/cytrynki.db "insert into cytrynki(data, ilosc) values(\"$data\", $ilosc)"
