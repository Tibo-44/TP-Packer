# TP-Packer

# Etape 1 : Mise en place de la VM Packer

Création de la machine virtuelle sous VMware Workstation avec le fichier VMDK fourni.
La machine virtuelle Packer tourne sur le système d'exploitation Rocky-8.

# Etape 2 : Générer la paire de clés SSH

Générer la paire de clés SSH permettra d'ajouter la clé publique à mon compte Github.
Pour générer, une clé SSH la commande est la suivante :
ssh-keygen -t ed25519

# Etape 3 : Construction de la VM tdhtest

Dans le dossier home de l’utilisateur root, se trouve le répertoire TP-Packer contenant :

- packer.pkr.hcl : Fichier de configuration de Packer, contenant la configuration du Provisionner et du Builder.
                   Le builder est Qemu (Logiciel permettant de faire tourner des VM)
                   Le provisionner, dans mon cas Shell : spécifier le script utilisé (launch-vm)

- ks/rocky-8.cfg : Fichier de configuration Kickstart. Ce fichier spécifie les paramètres pour l'installation de la VM.
                   Ajout de la clé SSH générée à l'étape 2 dans ce fichier.

- launch-vm.sh : Script permettant la personnalisation de la VM (Installation de paquets, création du service golang...)

Il est possible d'utiliser Ansible pour le déploiement de la VM tdhtest. Il faut alors modifier le provisionner dans le fichier 
packer.pkr.hcl en remplacant Shell par Ansible. Il faut également modifier le fichier source en le remplacant par le fichier playbook.yaml.

# Etape 4 : Construction automatisée de la VM tdhtest

Pour lancer la construction de la VM utiliser la commande ci-dessous :

packer build packer.pkr.hcl

Afin de vérifier l'installation de la VM il faut utiliser Putty+VNC
On peut alors suivre l'installation et la configuration de la VM.

# Liens utilisés pour la réalisation du TP : 

Créer des boxes Vagrant facilement en utilisant Packer
https://tferdinand.net/creer-des-boxes-vagrant-facilement-en-utilisant-packer/
Intégration d’un service en Go avec systemd
https://vincent.bernat.ch/fr/blog/2017-systemd-golang
