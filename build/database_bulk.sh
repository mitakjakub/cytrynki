#!/bin/bash
d='20210901'
until [[ $d -eq `date +'%Y%m%d'` ]]; do 
    data=`date --date "$d" +'%Y-%m-%d'`
    url=`curl -s -d "data=$data&submit=Zmie%C5%84+dat%C4%99" -H "Content-Type: application/x-www-form-urlencoded" -X POST https://zlobki.waw.pl/nasze-placowki/statystyki/ | grep zlobek-nr-69 | cut -d '"' -f2`
    curl -s $url -o /tmp/file.html
    array=()
    for i in "obecnych" "zapisanych" "opiekunów"; do
    array+=(`cat /tmp/file.html | grep -A1 $i | grep -m 1 [0-9] | tr -d '</td>' | awk '{ print $1 }'`)
    done;
    if [ ! ${array[0]} ]; then
        array[0]='0'
        array[1]='0'
        array[2]='0'
    fi
    > /tmp/file.html
    d=$(date --date "$d + 1 day" +'%Y%m%d');
    w="$data"
    x=`echo ${array[0]} | sed 's/[^0-9]*//g'`
    y=`echo ${array[1]} | sed 's/[^0-9]*//g'`
    z=`echo "${array[2]}" | sed 's/[^0-9]*//g' `
    echo "$w|$x|$y|$z" >> bulk.txt    
done

