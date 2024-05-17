**Exercice 1 : Modification IP client serveur**

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

