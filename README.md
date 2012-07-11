Kipatra
=======

Experiment with a standalone Sipatra server.


INSTALLATION
============

TODO

TEST APPLICATION
================

In first shell:

jruby -Ilib -rubygems bin/kipatra -u 127.0.0.2:5060 sample.rb


In second shell:

./sipp -sn uas -bind_local -i 127.0.0.3


In third shell:

./sipp -sn uac -s 127.0.0.1 -i 127.0.0.1 -rsa 127.0.0.2 127.0.0.3


On mac, don't forget to execute:

ifconfig lo0 add 127.0.0.2

ifconfig lo0 add 127.0.0.3