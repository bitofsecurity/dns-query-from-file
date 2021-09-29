#!/bin/bash
RED='\033[0;31m'
NC='\033[0m' 
# No Color
if [ "$1" == "" ]
then
  # Display help if wrong usage
  echo "Usage: bash dns-query-from-file.sh"
  exit 35
else 
  # Loop over dns and resolve
  while IFS='' read -r line || [[ -n "$line" ]]; do
    dns=''
    # Resolve reverse DNS
    if [[ $line =~ ^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}$ ]]; then
      dns=`dig +noall +answer -x $line +short|tr 'n' ' '`
    # Resolve A record
    else
      dns=`dig A $line +short|tr 'n' ' '`
#      dns=`dig MX $line +short|tr 'n' ' '`
    fi
#    echo -e "$line $linetis resolving into:\n${dns}"
    echo -e "\n${RED}$line${NC} resolving into:\n${dns}"
    sleep 1
  done < "$1"
fi
# todo
# add delay - done
# add some formatting + color - done
# add other requests NS, MX etc.. 
# I believe I got the original script from here: https://www.bggofurther.com/2017/05/dns-queries-from-a-filelist-to-csv/
# to get top 100 domains: wget -q http://s3.amazonaws.com/alexa-static/top-1m.csv.zip;unzip top-1m.csv.zip; awk -F ',' '{print $2}' top-1m.csv|head -1000 > top-1000.txt; rm top-1m.csv*

