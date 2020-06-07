#!/bin/bash

LIMIT='10'
LOG="${1}"

if [[ ! -e "${LOG}" ]]
then 
  echo "No sha pogut obrir el fitxer: ${LOG}" >&2
  exit 1
fi

echo 'Count,IP,Ubicacion'

grep Failed ${LOG} | awk '{print $(NF - 3)}' | sort | uniq -c | sort -nr |  while read COUNT IP
do
  if [[ "${COUNT}" -gt "${LIMIT}" ]]
  then
    LOC=$(geoiplookup ${IP} | awk -F ', ' '{print $2}')
    echo "${COUNT},${IP},${LOC}"
  fi
done
exit 0
