#!/bin/bash

trap signal EXIT
trap signal SIGINT

function signal()
{
        echo "Exited due to signal recieved."
        exit
}

function main()
{
  while true;
   do 
     echo "Obtaining metrics..."
     mtr -w -c 600 --no-dns ${ETCD1} & mtr -w -c 600 --no-dns ${ETCD2}  & mtr -w -c 600 --no-dns ${ETCD3} 
   done
}

main
