FROM centos
MAINTAINER Fawad Halim <fawad@fawad.net>

RUN yum -y install logrotate unzip initscripts
RUN rpm -Uvh http://download.gopivotal.com/rabbitmq/erlang/R15B02/erlang-R15B-02.1.el6.x86_64.rpm
RUN rpm -Uvh http://www.rabbitmq.com/releases/rabbitmq-server/v3.4.1/rabbitmq-server-3.4.1-1.noarch.rpm
RUN rabbitmq-plugins enable rabbitmq_management
RUN rabbitmq-plugins enable rabbitmq_federation
RUN rabbitmq-plugins enable rabbitmq_federation_management

ADD rabbitmq-startup.sh /usr/local/sbin/rabbitmq-startup.sh
ADD rabbitmq.config /etc/rabbitmq/rabbitmq.config
ADD erlang-cookie /var/lib/rabbitmq/.erlang.cookie
RUN chown rabbitmq /var/lib/rabbitmq/.erlang.cookie
RUN chmod 700 /usr/local/sbin/rabbitmq-startup.sh /var/lib/rabbitmq/.erlang.cookie

CMD /usr/local/sbin/rabbitmq-startup.sh

EXPOSE 5672 15672

