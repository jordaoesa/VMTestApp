#!/bin/bash


sudo su <<HERE

echo "---------------------------------";
echo "------ Instalação Asterisk ------";
echo "---------------------------------";

sudo apt-get update;

sudo apt-get install asterisk;

sudo cp /etc/asterisk/sip.conf /etc/asterisk/sip.conf.bkp;

sudo cp /etc/asterisk/extensions.conf /etc/asterisk/extensions.conf.bkp;

sudo echo "

[general]
udpbindaddr = 0.0.0.0
bindport = 5060
language = pt_BR
disallow = all

[opcoes-basicas](!)
host = dynamic
type = friend
context = ramais

[codecs](!)
disallow = all
allow = alaw
allow = ilbc

[somente-alaw](!,opcoes-basicas)
disallow = all
allow = alaw

;------------------------------
;- Montagem de protocolos SIP -
;------------------------------

[9001](opcoes-basicas,codecs)
secret = senha01
callerid = Secretaria <9001>

[9002](opcoes-basicas,codecs)
secret = senha02
callerid = Diretoria <9002>

" > /etc/asterisk/sip.conf;

sudo echo "

[ramais]
; ramais SIP
exten => 9001,1,Dial(SIP/9001)
exten => 9002,1,Dial(SIP/9002)

" > /etc/asterisk/extensions.conf;

sudo asterisk -rx 'dialplan reload';


HERE
