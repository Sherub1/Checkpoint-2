# **Exercice 1 : Modification IP client serveur**

**Q1.1**

![Ping serveur to client](https://github.com/Sherub1/Checkpoint-2/assets/160050170/4a6c3631-affc-41b7-8f5d-8a6cf01edbb7)

On peut voir d'après le résultat du ping qu'il n'y a aucune communication entre les deux machines.

Donc je regarde les détails de connexion réseau des deux appareils. 

![Network Connection Details SRVWIN2022](https://github.com/Sherub1/Checkpoint-2/assets/160050170/0beb1574-d436-41fa-8368-b6712975aef8) ![Détails de connexion réseau CLIWIN10](https://github.com/Sherub1/Checkpoint-2/assets/160050170/8fdd311a-a8e2-461d-a8d4-0d5d53dac2eb)

Les machines utilisent deux réseaux différent: 
- le serveur est sur le réseau 172.16.10.0
- le client est sur le réseau 172.16.100.0

Pour les faire communiquer,je met le client sur le même réseau.

![172 16 100 50 to 172 16 10 50](https://github.com/Sherub1/Checkpoint-2/assets/160050170/5e68d2fb-9a96-4d66-8ead-58cce96a4e75)

Je test avec un nouveau ping

![Capture d'écran 2024-05-17 102649](https://github.com/Sherub1/Checkpoint-2/assets/160050170/dd37d4ab-8a9b-4799-8dcc-9efe21f7207c)


**Q1.2**

![image](https://github.com/Sherub1/Checkpoint-2/assets/160050170/8a42cd02-b055-4a44-b379-7581b374fa54)
- Le résultat de la commande ping CLIENT1 montre qu'il utilise le protocol IPV6 

**Q1.3**

Après avoir désactivé le protocole IPV6 sur le client.
Le ping montre que le serveur utilise l'IPV4 à la place
![image](https://github.com/Sherub1/Checkpoint-2/assets/160050170/b6123023-48b3-467e-b938-0eb1cac475c7)

**Q1.4**

Le DHCP est déjà configuré sur le serveur donc je n'ai qu'a l'activé sur le client
![image](https://github.com/Sherub1/Checkpoint-2/assets/160050170/783697e5-2bc2-4b16-9381-781158411698)

**Q1.5**

![image](https://github.com/Sherub1/Checkpoint-2/assets/160050170/007af316-45a3-4f76-9c34-5283ef3eaefa)
- Le DHCP a attribué l'adresse IP 172.16.10.20 au client car il y a une exclusion d'adresse sur le serveur allant de 172.16.10.1 à 172.16.10.19

**Q1.6**

Je fais une réservation à cette adresse 172.16.10.15


![Capture d'écran 2024-05-17 112422](https://github.com/Sherub1/Checkpoint-2/assets/160050170/7d43daf1-2ceb-4779-ae3f-9758fa44acd2)

- Puis j'ajuste la plage d'exclusion
- 
![image](https://github.com/Sherub1/Checkpoint-2/assets/160050170/1d04e839-38e3-4e96-95e6-a16711011f47)

- Et mon client se connecte bien avec cette adresse
  
![image](https://github.com/Sherub1/Checkpoint-2/assets/160050170/930b5a1d-f37b-4a01-8467-48b61bc82742)

**Q1.7**

- Pour ce réseau je ne vois aucun intéret de le passer en IPV6, a part pour la configuration automatique.

**Q1.8**

- Non car on peut utiliser DHCPv6 pour les informations de configuration DNS par exemple.
- Tout en gardant la gestion de l'IPV4, il faudrait configurer la version IPV6 du DHCP.



