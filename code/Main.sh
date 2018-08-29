#!/bin/bash

echo ""
echo "------------------------------------------------"
echo "------------------------------------------------"
echo "------------Gestione MAC Address----------------"
echo "------------------------------------------------"
echo "------------------------------------------------"

#controllo l'effettiva esistenza del file passato come primo parametro
if ! [ -f "$1" ]; then
    echo "ERRORE: PARAMETRO 1 -> FILE NON ESISTENTE"
    echo "UTILIZZO: ./Main percorso_file_vibox percorso_file_lista_MAC"
    exit
#controllo l'effettiva esistenza del file passato come secondo parametro
elif ! [ -f "$2" ]; then
    echo "ERRORE: PARAMETRO 2 -> FILE NON ESISTENTE"
    echo "UTILIZZO: ./Main percorso_file_vibox percorso_file_lista_MAC"
    exit
#controllo se il terzo parametro non è nullo
elif ! [ -z "$3" ]; then
    echo "ERRORE: NUMERO PARAMETRI NON CORRETTO, UTILIZZARNE SOLAMENTE 2"
    echo "UTILIZZO: ./Main percorso_file_vibox percorso_file_lista_MAC"
    exit
fi

p_vbox=$p_vbox$1
p_maclist=$p_maclist$2

while true
do
    echo ""
    echo "Selezionare un'azione da eseguire:"
    echo ""
    echo "1. Visualizza MAC ADDRESS presenti nel file vbox"
    echo "2. Visualizza MAC ADDRESS già utilizzati"
    echo "3. Modifica MAC ADDRESS"
    echo "4. Modifica automatica MAC ADDRESS"
    echo "5. Esci"
    echo "------------------------------------------------"
    read sel

    case $sel in
        1) bash VisualizzaVBox.sh $p_vbox;;
        2) bash VisualizzaMAC.sh $p_maclist;;
        3) bash ModMAC.sh $p_vbox $p_maclist;;
        4) bash AutoMod.sh $p_vbox $p_maclist;;
        5) echo "-->>Hai scelto Esci<<--";echo "Uscendo... . .  .  .  .";exit;;
        *) echo "ERRORE: SELEZIONE NON VALIDA";;
    esac
done
