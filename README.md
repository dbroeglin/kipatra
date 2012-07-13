Kipatra
=======

Experiment with a standalone Sipatra server.


INSTALLATION
============

TODO

TEST APPLICATION
================

Launch a cipango server with a simple sipatra application as servlet to work sip proxy :

bin/kipatra -u 127.0.0.2:5060 -s sample.rb


Launch a sipp server :

sipp -sn uas -bind_local -i 127.0.0.3


Launch a sipp client to communicate with sipp server through cipango proxy

sipp -sn uac -s 127.0.0.1 -i 127.0.0.1 -rsa 127.0.0.2 127.0.0.3


On mac, don't forget to execute:

ifconfig lo0 add 127.0.0.2

ifconfig lo0 add 127.0.0.3
