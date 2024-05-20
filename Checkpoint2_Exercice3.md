# **Exercice 3 : Vérification d'une infrastructure réseau**

## **Q3.1**
### **Quel est le matériel réseau A ?**
- Cela représente un switch.   
### **Quel est son rôle sur ce schéma vis-à-vis des ordinateurs ?**  
- Le switch fait la liaison entre les ordinateurs qui sont sur le même réseau et la passerelle 10.10.255.254/16. 

## **Q3.2**
### **Quel est le matériel réseau B ?**
- Cela représente un routeur.  
### **Quel est son rôle pour le réseau 10.10.0.0/16 ?**  
- Il fait communiquer le reseau 10.10.0.0/16 avec le reseau 10.12.0.0/24,il sert de passerelle au réseau 10.10.0.0/16 jusqu'au routeur R2.

## **Q3.3**
### **Que signifie f0/0 et g1/0 sur l’élément B ?**  
- Ce sont des noms d'interfaces,Fast Ethernet et Gigabit Ethernet.Cette dernière a un meilleur débit. 


## **Q3.4**
### **Pour l'ordinateur PC2, que représente /16 dans son adresse IP ?**
- Il représente le CIDR ,masque de réseau de l'adresse IP. 

## **Q3.5**
### **Pour ce même ordinateur, que représente l'adresse 10.10.255.254 ?**
- PC2 étant sur le réseau 10.11.0.0/16 il ne peut pas voir 10.10.255.254 (Peut etre qu'il utilise une route par défaut 0.0.0.0). 

## **Q3.6**
### **Pour les ordinateur PC1, PC2, et PC5 donne** : L'adresse de réseau, La première adresse disponible, La dernière adresse disponible, L'adresse de diffusion
| | PC1 | PC2 | PC5|  
|--|--|-|---|
| Adresse | 10.10.4.1/16| 10.11.80.2/16 | 10.10.4.7/15 |
| Adresse réseaux | 10.10.0.0/16| 10.11.0.0/16 | 10.10.0.0/15|
| Première adresse disponible| 10.10.0.1/16 | 10.11.0.1/16 | 10.10.0.1/15|
| Dernière adresse disponible| 10.10.255.254/16| 10.11.255.254/16| 10.11.255.254/15|
| Adresse de broadcast | 10.10.255.255/16 | 10.11.255.255/16 | 10.11.255.255/15|


## **Q3.7**
### **Indiquer parmi tous les ordinateurs du schéma, lesquels vont pouvoir communiquer entre-eux.**
- PC1, PC3, PC4 et PC5 peuvent communiquer ensemble.  
Seul PC5 peut communiquer avec PC2.

## **Q3.8**
### **Quel ordinateurs peuvent atteindre le réseau 172.16.5.0/24?**
- Les ordinateurs qui peuvent atteindre 172.16.5.0/24 sont PC1,PC3,PC4 et PC5.

## **Q3.9**
### **Quel incidence y-a-t'il pour les ordinateurs PC2 et PC3 si on interverti leur ports de connexion sur le matériel A ?**
- Sans plus de détails , je dirais aucune.


## **Q3.10**
### **Quelles sont les modifications possible afin de mettre la configuration IP des ordinateurs en dynamique?** 
- Il faudrait mettre en place un serveur DHCP et mettre tout les PC sur le même réseau.
________________________
# **Analyse de trames**
## **Fichier 1**  
## **Q3.11**
### **Sur le paquet N°5, quelle est l'adresse mac du matériel qui initialise la communication ? Déduire le nom du matériel.**
- L'adresse MAC est 00:50:79:66:68:00 , c'est l'adresse MAC de PC1.

## **Q3.12**
### **Est-ce que la communication enregistrée dans cette capture a réussi?**
- Oui, la ligne 6 montre que c'est une réponse à ligne 5. C'est un ping avec PC4.

## **Q3.13**
### **Dans cette capture, à quel matériel correspond le request et le reply ?** 
- La machine qui fait un request est PC1 00:50:79:66:68:00 et celle qui reply est PC4 00:50:79:66:68:03

## **Q3.14**
### **Dans le paquet N°2, quel est le protocole encapsulé ? Quel est son rôle ?**
- C'est le protocole ARP, son role et de faire le lien entre adresse IP et adresse MAC.

## **Q3.15**
### **Quels ont été les rôles des matériels A et B dans cette communication ?**
- Le matériel A (Switch) a fait la liaison entre PC1 et PC4 pour le transfert de paquets tandis que le matériel B (routeur) n'a pas été solicité car les deux machines sont sur le même réseau.

___________________________

## **FICHIER 2**
## **Q3.16**
### **Qui initialise la communication ? Donner l'adresse IP ainsi que le nom du matériel.**
- PC3 dont l'adresse IP est 10.10.80.3

## **Q3.17**
### **Quel est le protocole encapsulé ? Quel est son rôle ?**
- ICMP, il envoie des messages du destinataire à l'expéditeur lorsque les données n'arrivent pas comme elles le devraient.

## **Q3.18**
### **Est-ce que cette communication a réussi ? Si oui, indique entre quels matériel, si non indique pourquoi cela n'a pas fonctionné.**
- Non ,car PC3 et PC2 ne sont pas sur le même réseau donc sont incapable de communiquer entre eux.

## **Q3.19**
### **Expliquer la ligne du paquet N° 2**
- La ligne 2 indique que le destinataire avec l'adresse IP 10.10.80.2 n'est pas accessible depuis la passerelle 10.10.255.254.

## **Q3.20**
### **Quels ont été les rôles des matériels A et B ?**
- Le switch A, a fait le lien entre PC3 et le routeur, il a reçu de PC3 un paquet à destination de la default gateway dont il connaît l'interface et l'a transmis.
- Le routeur B, a reçu le paquet en provenance de PC3 pour PC2. Il ne connaît pas l'adresse de PC2 et n'a pas pu le transmettre car le réseau de PC2 ne fait pas partie de sa table de routage, ICMP lui renvoie donc une erreur.
_____________________________

## **FICHIER 3**
## **Q3.21**
### **Dans cette trame, donner les noms et les adresses IP des matériels sources et destination.**
- Source: PC4 , IP 10.10.4.2/16.  
- Destination: machine sur le réseau 172.16.5.0 , IP est 172.16.5.253. 

## **Q3.22**
### **Quelles sont les adresses mac source et destination ? Qu'en déduis-tu ?**
- MAC source: ca:03:9e:ef:00:38. 
- MAC destination: ca:01:da:d2:00:1c.
- Des machines sont présentent sur le réseau 172.16.5.0/24 et sont accessible via R2.  

## **Q3.23**
### **A quel emplacement du réseau a été enregistré cette communication ?**
- C'est une capture faite entre R1(A) et R2.  
