#!/bin/bash

echo ""
echo "-----MAC ADDRESS presenti nel file VBox-----"
echo ""

p_vbox=$p_vbox$1
#seleziono solo le righe in cui compare MACAddress=
selezione=$(fgrep "MACAddress" $p_vbox)
#spezzo i campi separati da spazio in nuove righe e riseleziono le righe del tipo MACAddress=*, poi ordino ed elimino i mac duplicati
selezione=$(echo $selezione | tr ' ' '\n' | grep "MACAddress" | sort | uniq )
while read riga
do
    echo ${riga:12:12}  #per ogni riga estraggo solamente la sottostringa di 12 caratteri contenete il MACAddress
done <<< "$selezione" #gli apici servono per vedere la stringa stampata su più righe

