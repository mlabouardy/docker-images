Introduction
============

Docker container for RabbitMQ 3.3.x with ability to form cluster

Usage
=====

Start a [consul](http://consol.io/) node using

`docker run --name=consul -p 8500:8500 -p 8600:8600/udp -p 8400:8400 fhalim/consul`

Master
------

`docker run --link=consul:consul -p 5672:5672 -p 15672:15672 --name="rmq1" fhalim/rabbitmq`

Additional nodes
----------------

`docker run --link=consul:consul --link=rmq1:master fhalim/rabbitmq`
