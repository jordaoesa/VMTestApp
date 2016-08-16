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

;----------------------------------------------
;- Extensoes para gravacao de arquivos de som -
;----------------------------------------------
; - Ao ligar para o número 2001 pelo X-LITE, o asterisk atendera a chamada automaticamente 
;   (o numero 1 logo apos 2001 indica a prioridade nas acoes a serem tomadas)
; - A aplicacao Answer se responsabilizara por atender a chamada
; - A aplicacao Record sera executada em sequencia (devido a sua prioridade de numero 2) e 
;   recordara o audio no arquivo som_ura.gsm
; - A aplicacao PlayBack executara o arquivo som_ura
; - Em sequencia a ligacao sera terminada pela aplicacao Hangup
; - OBS.: A cada novo audio gravado deve-se atribuir um nome diferente. Voce pode configurar varios canais para gravacao.
; - exten => number,priority,application([parameter[,parameter2...]])

exten => 2001,1,Answer
exten => 2001,2,Record(som_ura.gsm)
exten => 2001,3,PlayBack(som_ura)
exten => 2001,4,Hangup

exten => 2002,1,Answer
exten => 2002,2,Record(bom.gsm)
exten => 2002,3,PlayBack(bom)
exten => 2002,4,Hangup

exten => 2003,1,Answer
exten => 2003,2,Record(medio.gsm)
exten => 2003,3,PlayBack(medio)
exten => 2003,4,Hangup

exten => 2004,1,Answer
exten => 2004,2,Record(ruim.gsm)
exten => 2004,3,PlayBack(ruim)
exten => 2004,4,Hangup

exten => 2005,1,Answer
exten => 2005,2,Record(beep.gsm)
exten => 2005,3,PlayBack(beep)
exten => 2005,4,Hangup

exten => 2006,1,Answer
exten => 2006,2,Record(finalizar.gsm)
exten => 2006,3,PlayBack(finalizar)
exten => 2006,4,Hangup

exten => 2007,1,Answer
exten => 2007,2,Record(escute.gsm)
exten => 2007,3,PlayBack(escute)
exten => 2007,4,Hangup

exten => 2008,1,Answer
exten => 2008,2,Record(avaliacao.gsm)
exten => 2008,3,PlayBack(avaliacao)
exten => 2008,4,Hangup

;----------------------------------------------
;-            Configuracao da URA             -
;----------------------------------------------
; exten => 2000,Goto(ura_dl,inicio_ura,1)
; - Ao ligar 2000 do X-LITE, o asterisk vai buscar o contexto chamado 'ura_dl' 
; e executar os passos configurados ali.
; - O 'inicio_ura' aqui usado refencia uma extensao que deve estar configurada no
; contexto da 'ura' e o 1 define a prioridade
; - A aplicacao Background(nome_som) tocara o som passado em parametro em backgroud
; - A aplicacao Goto pode ser utilizada sem passarmos o parametro de contexto (apenas extensoes e prioridade)
; - A aplicacao PlayBack executara o arquivo de som passado em parametro

exten => 2000,1,Goto(ura_dl,inicio_ura,1)

[ura_dl]
;exten => inicio_ura,1,Answer
exten => inicio_ura,2,PlayBack(som_ura)
exten => inicio_ura,3,PlayBack(beep)
exten => inicio_ura,4,Record(som_gravado.gsm,0,5,n)
exten => inicio_ura,5,PlayBack(escute)
exten => inicio_ura,6,PlayBack(som_gravado)
exten => inicio_ura,7,PlayBack(avaliacao)
exten => inicio_ura,8,Goto(ura_feedback,1)

[ura_feedback]
exten => 1,1,PlayBack(bom)
exten => 1,2,PlayBack(finalizar)
exten => 1,3,Goto(inicio_ura,1)

exten => 2,1,PlayBack(medio)
exten => 2,2,PlayBack(finalizar)
exten => 2,3,Goto(inicio_ura,1)

exten => 3,1,PlayBack(ruim)
exten => 3,2,PlayBack(finalizar)
exten => 3,3,Goto(inicio_ura,1)


" > /etc/asterisk/extensions.conf;


sudo chown -R asterisk.asterisk /usr/share/asterisk/sounds/;

sudo asterisk -rx 'dialplan reload';
sudo asterisk -rx 'reload';

HERE

