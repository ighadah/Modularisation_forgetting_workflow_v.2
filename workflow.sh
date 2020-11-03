#############################################################################
#!/bin/sh
# Subject : Workflow of combining ontology modularity and forgetting.
# Author : Ghadah Alghamdi
# Date   : 01-11-2020
# Email  : ghadah.alghamdi@manchester.ac.uk
##############################################################################

cdir=`pwd`

ONTOLOGY="$cdir/testing_files/sct-International-2020-07-31.owl"
SIGFILE="$cdir/testing_files/sct-International-2020-07-31.owl_new_sig_2.owl"
DEPTH="2"

echo "#############################################################################"
echo "# Subject : Workflow of combining ontology modularity and forgetting."
echo "# Author : Ghadah Alghamdi"
echo "##############################################################################"

#SIGFILE=${SIGDIR}${file}

EXDSIG=${SIGFILE}'_extendedSig.owl'
MODULE=${EXDSIG}'_starModule.owl'
LETHEVIEW=${MODULE}'_lethe-view.owl'
DELETHEVIEW=${LETHEVIEW}'_denormalised.owl'


echo "-----start to extend signature----------------------------------"
echo "-----Author: Ghadah Alghamdi---------------------------------------"

java -jar sigExtension-ghadah.jar ${SIGFILE} ${ONTOLOGY} ${DEPTH}

echo "-----start to extract star module-------------------------------"
echo "-----Author: Ghadah Alghamdi, by using OWLAPI----------------------"

java -jar starModule.packaged.ghadah.jar ${EXDSIG} ${ONTOLOGY}


echo "-----start to compute uniform interpolants----------------------"

echo "-----LETHE------------------------------------------------------"
echo "-----Author: Patrick Koopmann, packaged by Ghadah Alghamdi------"

java -jar lethe.packaged.06SA.ghadah-2.jar ${EXDSIG} ${MODULE}

echo "-----start to denormalise the results---------------------------"
echo "-----Author: Ghadah Alghamdi------------------------------------"

java -jar Denormalise.jar ${LETHEVIEW} ${LETHEVIEW}


echo "-----start to add annotation------------------------------------"
echo "-----Author: Ghadah Alghamdi------------------------------------"

java -jar Add_annotations.jar ${ONTOLOGY} ${EXDSIG} ${EXDSIG}
java -jar Add_annotations.jar ${ONTOLOGY} ${DELETHEVIEW} ${DELETHEVIEW}