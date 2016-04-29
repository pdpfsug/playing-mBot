# Primi passi con mBot in Python (= Getting started with mBot in the Python language)

[Python](http://www.python.org/) è un linguaggio di scripting leggero e molto usato
per la sua versatilità e praticità. Molte volte è utile per la prototipazione rapida,
altre volte per gestire complesse applicazioni.

In particolare abbiamo iniziato a giocare con Python per via della competenza di
alcuni di noi nel linguaggio e la possibilità quindi di concentrarci sulla comunicazione
con mBot (connessione e protocollo) rimuovendo quelle difficoltà che si incontrano nell'imparare
un linguaggio nuovo.

In questa directory mettiamo gli script realizzati:

## raw_makeblock_rfcomm.python

Questo script consente una comunicazione grezza di alcuni comandi predefiniti
a mBot tramite porta rfcomm.

**Requisiti**: la libreria pybluez

## rfcomm-server.py e rfcomm-client.py

Analoghi dei corrispondenti in C nella directory mbot_play_c, presi da
http://people.csail.mit.edu/albert/bluez-intro/x232.html
