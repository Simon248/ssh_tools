# ssh_tools  

## ssh-cpy-multiple-server.sh    
This script make ssh-copy-id to multiple server.    
It send the same public key to all server.    

It get server (User@IP) from a ssh config file.  
A dedicated config file can be created and included in the 'main' ssh config via ```Include config_2```  

then:  
```
./ssh-cpy-multiple-server.sh /chemin/vers/clé.pub /chemin/vers/config_2
```
