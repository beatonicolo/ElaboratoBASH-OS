#!/bin/bash

echo ""
echo "-------Modifica Automatica MAC ADDRESS-------"
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
    		len=${#old}     #ricavo la lunghezza del MAC da modificare
    		if [ "$len" = "12" ]; then
       			control="false"
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
	selezione=$(fgrep "$old" $p_vbox)                           #controllo che il mac sia presente nel file *.vbox
    	if [ -z "$selezione" ]; then                            #se il risultato della grep è la stringa vuota non è presente
        	echo "L'INDIRIZZO INSERITO NON ESISTE"
    	fi
done

control="true"
while [ "$control" = "true" ]
do
    	new=$(cat /dev/urandom | tr -dc 'A-F0-9' | fold -w 12 | head -n 1)  	#genero una stringa random di valori esadecimali | lunghezza 12 | leggo la prima riga
    	selezionemac=$(fgrep -i "$new" $p_maclist)                              #controllo che non sia presente nel database dei MAC
	    if [ -n "$selezionemac" ]; then
        	control="true"
        else
            control="false"
    	fi
    	if [ "$control" = "false" ]; then                                       #se è tutto legale vado ad apportare le modifiche ai file
		vbox=$(cat $p_vbox)
        	echo "${vbox//$old/$new}" > $p_vbox    
        	echo "$new" >> $p_maclist
        	echo "!!! file modificati !!!"
    	fi
done

