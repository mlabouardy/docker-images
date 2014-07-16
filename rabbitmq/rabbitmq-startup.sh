#!/bin/bash


CONSUL_IP="${CONSUL_PORT_8500_TCP_ADDR}"
MASTER_IP="${MASTER_PORT_5672_TCP_ADDR}"
MASTER_HOSTNAME="master"

MASTER_NODENAME="rabbit@${MASTER_IP}"
MYIP=$( ip a s|grep 'inet '|grep -v '127.0.0.1'|awk '{print $2;}'|awk 'BEGIN {FS="/"} {print $1;}')
if [ -z $MASTER_IP ]; then
	MYNODENAME="rabbit@${MASTER_HOSTNAME}"
	echo "Running RabbitMQ server as standalone node using nodename ${MYNODENAME}.";
	#cp /usr/lib/rabbitmq/bin/rabbitmq-server /usr/lib/rabbitmq/bin/rabbitmq-server-copy
	#sed -i 's/sname ${RABBITMQ_NODENAME}/name ${RABBITMQ_NODELONGNAME}/' /usr/lib/rabbitmq/bin/rabbitmq-server
	export RABBITMQ_NODENAME="${MYNODENAME}"
	rabbitmq-server
	/bin/bash
else
	echo "Joining cluster to ${MASTER_IP}"
	rabbitmq-server -detached
	rabbitmqctl stop_app
	echo "${MASTER_IP} ${MASTER_HOSTNAME}" >> /etc/hosts
	rabbitmqctl join_cluster ${MASTER_NODENAME}
	rabbitmqctl stop
	rabbitmq-server
fi;
