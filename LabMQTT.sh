#!/bin/bash

################################################################################
# Declaration des variables standards
#
DEBUG=true
INFO=true
NomScript=${0##*/} 
NomLab=${NomScript%%.*}
Lab="mqtt" #${NomScript%%_*}
ListeStack=(s01_172.3.0.11_eclipse-mosquitto s02_172.3.0.12_mqttx-web s03_172.3.0.13_python s04_172.3.0.14_scapy) 
                                      
################################################################################
# Affichage des variable en mode debug
echo -e "#######################################################################"
$DEBUG && echo -e "\033[34m => Nom script      : $NomScript \033[0m" >/dev/tty
for Stack in ${ListeStack[@]}
      do
            LibStack=${Stack##*_}; NumStack=${Stack%%_*}; Ip=${Stack:4:10}
            $INFO && echo -e "\033[34m => Stack $NumStack       : $Ip $NumStack:$LibStack \033[0m" >/dev/tty
done
Stack=""

################################################################################
# Fonction CreationImageDocker : Creation des images docker en fonction des dockerfiles
CreationImagesDocker ()
{
      $DEBUG && echo -e "\033[34m => Fonction de création des images docker \033[0m" >/dev/tty
      for Stack in ${ListeStack[@]}
      do
            LibStack=${Stack##*_}; NumStack=${Stack%%_*}
            $INFO && echo -e "\033[34m => Création de l'image $NomLab:$LibStack...  \033[0m" >/dev/tty
            docker build -t $Lab:$LibStack ./$NumStack"_"$LibStack 
      done
      Stack=""
      docker image ls 
}

# ################################################################################
# # Fonction SuppressionImagesDocker : Suppression des images docker en fonction des dockerfiles
SuppressionImagesDocker ()
{
      $DEBUG && echo -e "\033[34m => Fonction de sippression des images docker \033[0m" >/dev/tty
      for Stack in ${ListeStack[@]}
      do
            LibStack=${Stack##*_}; NumStack=${Stack%%_*}
            $INFO && echo -e "\033[34m => Suppression de l'image $Lab:$LibStack...  \033[0m" >/dev/tty
            docker rmi -f $Lab:$LibStack 
      done
      Stack=""
      docker image ls 
}

# ################################################################################
# # Fonction CreationConteneurs : Creation des conteneurs à partir du docker-compose.yml
# # Création également du réseau dédié au lab
CreationConteneurs ()
{
      $DEBUG && echo -e "\033[34m => Fonction de création des conteneurs \033[0m" >/dev/tty
      docker compose up -d 
      docker container ls 
}

# ################################################################################
# # Fonction SuppressionConteneurs : Suppression des conteneurs à partir du docker-compose.yml
# # Suppression également du réseau dédié au lab 
SuppressionConteneurs ()
{
      $DEBUG && echo -e "\033[34m => Fonction de création des conteneurs \033[0m" >/dev/tty
      docker compose down -v
      docker compose rm -f 
      docker container ls 
}

# ################################################################################
# # Fonction ConnexionConteneurPincipal : Connection au conteneur principal du labo 
ConnexionConteneurBroker ()
{
      #docker exec -it -u $Lab $NomLab bash
      docker exec -it mqtt_broker sh
}

# ################################################################################
# # Fonction ConnexionConteneurPincipal : Connection au conteneur principal du labo 
ConnexionConteneurScapy ()
{
      #docker exec -it -u $Lab $NomLab bash
      #docker exec -it mqtt_sniffer bash
      docker exec -it -u root mqtt_scapy bash
}

# ################################################################################
# # Affichage du menu / Programme principale
# # Set PS3 prompt
PS3="Entrez le numéro de l'action souhaitée : "
select action in "Créer les images docker" "Supprimer les images docker" "Créer les conteneurs" "Supprimer les conteneurs" "Connexion au broker" "Connexion à scapy" "Quitter" 
do
      case $action in
      "Créer les images docker" )
            $DEBUG && echo -e "\033[34m => Création des images docker \033[0m" >/dev/tty
            CreationImagesDocker
            break  
      ;;
      "Supprimer les images docker" )
            $DEBUG && echo -e "\033[34m => Suppression des images docker \033[0m" >/dev/tty
            SuppressionImagesDocker
            break
      ;;
      "Créer les conteneurs" )
            $DEBUG && echo -e "\033[34m => Création des conteneurs \033[0m" >/dev/tty
            CreationConteneurs
            break 
      ;;
      "Supprimer les conteneurs" )
            $DEBUG && echo -e "\033[34m => Suppression des conteneurs \033[0m" >/dev/tty
            SuppressionConteneurs
            break
      ;;
      "Connexion au broker" )
            $DEBUG && echo -e "\033[34m => Connexion au broker \033[0m" >/dev/tty
            ConnexionConteneurBroker
            break
      ;;
      "Connexion à scapy" )
            $DEBUG && echo -e "\033[34m => Connexion au sniffeur \033[0m" >/dev/tty
            ConnexionConteneurScapy
            break
      ;;
      "Quitter" )
            $DEBUG && echo -e "\033[34m => Sortie du menu \033[0m" >/dev/tty
            break
      ;;
      * ) 
            $DEBUG && echo -e "\033[31m => [Erreur] Choix non valide du menu \033[0m" >/dev/tty
            break
      ;;
      esac
done
exit
