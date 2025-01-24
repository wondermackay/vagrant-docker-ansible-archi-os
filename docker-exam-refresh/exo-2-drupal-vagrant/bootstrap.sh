#!/bin/bash

# Mettre à jour le système
echo "Mise à jour des paquets..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Installer les dépendances nécessaires
echo "Installation des dépendances..."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    python3-pip \
    gnupg

# Ajouter le dépôt Docker
echo "Ajout du dépôt Docker..."
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Installer Docker
echo "Installation de Docker..."
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Ajouter l'utilisateur vagrant au groupe docker (pour éviter d'utiliser sudo avec docker)
sudo usermod -aG docker vagrant

# Installer Docker Compose
echo "Installation de Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Vérifier l'installation de Docker Compose
docker-compose --version

# Installer Ansible
echo "Installation d'Ansible..."
sudo pip3 install ansible

# Vérifier les installations
echo "Vérifications :"
docker --version
ansible --version

echo "Installation terminée avec succès !"
