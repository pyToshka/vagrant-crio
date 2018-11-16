#!/bin/bash
scriptname=`basename "$0"`

 if [ -z "$*" ]; then
    echo -e "No arguments or command for ${scriptname}\nUsage: ./${scriptname}  \"command\"\nexample ./${scriptname} \"podman images\"";
    exit 2
 fi

vagrant ssh -c "sudo $1"
