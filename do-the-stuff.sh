#!/bin/bash
for HOSTIP in $(terraform output | cut -d '=' -f2)
do
if [[ $(grep $HOSTIP hostfile) ]]; then
	echo "$HOSTIP already in hostfile"
else
	echo "$HOSTIP" >> hostfile
	echo "$HOSTIP added in hostfile"
fi
done
#ansible-playbook -i hostfile docker-install.yml
#ansible-playbook -i hostfile kubernetes-install.yml
ansible-playbook -i hostfile kubernetes-cluster-create.yml
