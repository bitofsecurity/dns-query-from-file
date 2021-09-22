!/bin/bash
if [ "$1" == "" ]
then
  # Display help if wrong usage
  echo "Usage: /bin/bash resolverDNS.sh /path/to/file"
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
      dns=`dig a $line +short|tr 'n' ' '`
    fi
    echo -e "$linetis resolving intot${dns}"
  done < "$1"
fi
# todo
# add delay
# add other requests NS, MX etc.. 

