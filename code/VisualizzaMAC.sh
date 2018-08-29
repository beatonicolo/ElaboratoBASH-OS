#!/bin/bash

echo ""
echo "-----MAC ADDRESS presenti nel file MAClist-----"
echo ""

p_maclist=$p_maclist$1

while read riga
do
    echo $riga
done < "$p_maclist"
