#!/bin/bash

echo ""
echo "-------Modifica MAC ADDRESS-------"
echo ""

p_vbox=$p_vbox$1
p_maclist=$p_maclist$2

selezione=''
while [ -z "$selezione" ]
do
	control="true"
	while [ "$control" = "true" ]
	do
    		bash VisualizzaVBox.sh $p_vbox
    		echo ""
    		echo "Inserire l'indirizzo MAC da modificare:"
    		read old
    		len=${#old} #ricavo la lunghezza del MAC da modificare
    		if [ "$len" = "12" ]; then
       			control="false" #la lunghezza è corretta
    		else
       			control="true"
        		echo "lunghezza mac NON CORRETTA, deve essere di 12 CARATTERI ESADECIMALI"
   	 	fi
		index=0
    		while [ $index -le "11" -a "$control" = "false" ]   #ciclo finchè index < 12 (<= 11) && control false (ovvero le cifre inserite sono 12)
    		do
			if [[ "${old:$index:1}" =~ [[:xdigit:]] ]]; then    #controllo che ogni carattere sia esadecimale
            			control="$control"
        		else
            			control="true"
            		echo "i caratteri inseriti non sono esadecimali"
        		fi
    			let "index+=1"
    		done
	done
	selezione=$(fgrep "$old" $p_vbox)   #controllo che il mac sia presente nel file *.vbox
    	if [ -z "$selezione" ]; then    #se il risultato della grep è la stringa vuota non è presente
        	echo "L'INDIRIZZO INSERITO NON ESISTE"
    	fi
done

control="true"
while [ "$control" = "true" ]
do
    	echo ""
    	echo "Inserire un nuovo indirizzo mac:"
    	read new
    	len=${#new}  #ricavo la lunghezza del nuovo MAC
    	if [ "$len" = "12" ]; then
        	control="false"
    	else
        	control="true"
        	echo "lunghezza nuovo mac NON CORRETTA, deve essere di 12 CARATTERI ESADECIMALI"
    	fi
    	index=0
    	while [ $index -le "11" -a "$control" = "false" ]       #ciclo finchè index < 12 (<= 11) && control false (ovvero le cifre inserite sono 12)
    	do
        	if [[ "${new:$index:1}" =~ [[:xdigit:]] ]]; then    #controllo che ogni carattere sia esadecimale
            		control="$control"
        	else
            		control="true"
            		echo "i caratteri inseriti non sono esadecimali"
        	fi
    		let "index+=1"
    	done
    	selezionemac=$(fgrep -i "$new" $p_maclist)           #controllo che il mac sia presente nel database dei MAC
	if [ -n "$selezionemac" ]; then                          #se già presente non è possibile utilizzarlo
        	control="true"
        	echo "indirizzo già PRESENTE nel file maclist"
    	fi
    	if [ "$control" = "false" ]; then                    #se tutto è corretto andrò a scrivere nei file le modifiche
		vbox=$(cat $p_vbox)                                  #leggo il file *.vbox
        	echo "${vbox//$old/$new}" > $p_vbox              #sostiusico il vecchio MAC con quello nuovo, e sovrascrivo la nuova stringa nel file *.vbox
        	echo "$new" >> $p_maclist                        #aggiungo alla fine del database di MAC
        	echo "!!! file modificati !!!"
    	fi
done

