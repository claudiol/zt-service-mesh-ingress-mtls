#!/bin/sh

for i in jaeger elasticsearch kiali servicemesh
do
	PACKNAME=$(oc get packagemanifests | grep -i $i | awk '{ print $1}')
	for j in $PACKNAME
	do 
          echo "Package Info for [$j]"
	  OUT=$(oc get packagemanifest/$j -o json | jq '.metadata.name, .metadata.namespace, .metadata.labels.catalog, .status.defaultChannel, .status.channels[].currentCSV')
	  let COUNT=1
	  for k in $OUT
	  do
	    case $COUNT in 
	  	1) echo "  - name: $k" | tr -d '"'
	    	   ;;
	  	2) echo "    namespace: $k" | tr -d '"'
	    	   ;;
	   	3) echo "    source: $k" | tr -d '"'
		   ;;
   		4) echo "    channel: $k" | tr -d '"'
		   ;;
   		5) echo "    csv: $k" | tr -d '"'
		   ;;
	    esac
	    let COUNT++
	  done
	done
done

