This ansible-playbook update system and deploy nginx
To deploy nginx you need:
1. Change inventory.yaml for your server (to specify user, a path to ssh key, server IP)
2. Ping your server run command below(you need to get pong answer):
```bash
ansible -i inventory.yaml all -m ping
```
3. To deploy nginx to run the command below:
```bash
ansible-playbook -i inventory.yaml playbook.yaml
``` 