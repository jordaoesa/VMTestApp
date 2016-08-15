#!/bin/bash

sudo su <<HERE

sudo cp /etc/asterisk/sip.conf /etc/asterisk/sip.conf.bkp;
sudo cp /etc/asterisk/extensions.conf /etc/asterisk/extensions.conf.bkp;
sudo cp /etc/asterisk/extensions.ael /etc/asterisk/extensions.ael.bkp;
sudo cp /etc/asterisk/iax.conf /etc/asterisk/iax.conf.bkp;
sudo cp /etc/asterisk/users.conf /etc/asterisk/users.conf.bkp;
sudo cp /etc/asterisk/queues.conf /etc/asterisk/queues.conf.bkp;
sudo cp /etc/asterisk/agents.conf /etc/asterisk/agents.conf.bkp;
sudo cp /etc/asterisk/voicemail.conf /etc/asterisk/voicemail.conf.bkp;
sudo cp /etc/asterisk/musiconhold.conf /etc/asterisk/musiconhold.conf.bkp;
sudo cp /etc/asterisk/meetme.conf /etc/asterisk/meetme.conf.bkp;

echo "" > /etc/asterisk/extensions.conf;
echo "" > /etc/asterisk/extensions.ael;
echo "" > /etc/asterisk/sip.conf;
echo "" > /etc/asterisk/iax.conf;
echo "" > /etc/asterisk/users.conf;
echo "" > /etc/asterisk/queues.conf;
echo "" > /etc/asterisk/agents.conf;
echo "" > /etc/asterisk/voicemail.conf;
echo "" > /etc/asterisk/musiconhold.conf;
echo "" > /etc/asterisk/meetme.conf;

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
;------------------------------
;-         ramais SIP         -
;------------------------------
exten => 9001,1,Dial(SIP/9001)
exten => 9002,1,Dial(SIP/9002)

" > /etc/asterisk/extensions.conf;

sudo chown -R asterisk.asterisk /usr/share/asterisk/sounds/;

sudo asterisk -rx 'dialplan reload';
sudo asterisk -rx 'reload';

HERE

