# ENI-LabMQTT

**ENI-LabMQTT** est un projet pour apprendre et manipuler **MQTT**, un protocole léger et adapté à l'IoT. Ce projet utilise Docker pour simuler un environnement complet.

## Table des matières
1. [Introduction](#introduction)
2. [Architecture du projet](#architecture-du-projet)
3. [Prérequis](#prérequis)
4. [Installation et démarrage](#installation-et-démarrage)
5. [Détails des conteneurs](#détails-des-conteneurs)
6. [Auteurs](#auteurs)

## Introduction

Ce projet permet de :
- Lancer un broker MQTT (Eclipse Mosquitto).
- Simuler un publisher et un subscriber MQTT.
- Analyser le trafic MQTT avec des outils réseau.

## Architecture du projet

1. **mqtt_broker** :  
   - Rôle : Serveur MQTT basé sur Eclipse Mosquitto.  
   - IP : `172.3.0.11`

2. **mqtt_publisher** :  
   - Rôle : Émetteur de messages MQTT.  
   - IP : `172.3.0.13`

3. **mqtt_subscriber** :  
   - Rôle : Récepteur de messages MQTT.  
   - IP : `172.3.0.12`

4. **mqtt_scapy** :  
   - Rôle : Outil d’analyse réseau basé sur Scapy.  
   - IP : `172.3.0.14`

## Prérequis

- **Docker** et **Docker Compose** installés sur votre machine.
- *Git* pour cloner le dépôt.
- Éditeur de texte (par ex. : **VSCode**).

## Installation et démarrage

1. Clonez ce dépôt :
   ```bash
   git clone https://github.com/votrecompte/ENI-LabMQTT.git
   cd ENI-LabMQTT

2. Démarrez les conteneurs Docker :
    ```bash
    docker-compose up -d

3. Vérifiez l'état des conteneurs :
    ```bash
    docker ps

4. Arrêtez les conteneurs après utilisation :
    ```bash
    docker-compose down

---

## Détails des conteneurs

| Conteneur       | Rôle                | IP            | Ports exposés |
|-----------------|---------------------|---------------|---------------|
| mqtt_broker     | Serveur MQTT        | 172.3.0.11    | 1883, 9001    |
| mqtt_publisher  | Émetteur MQTT       | 172.3.0.13    | N/A           |
| mqtt_subscriber | Récepteur MQTT      | 172.3.0.12    | N/A           |
| mqtt_scapy      | Analyse réseau      | 172.3.0.14    | N/A           |


## Auteurs

- Prénom Nom
- Collaborateur 2

