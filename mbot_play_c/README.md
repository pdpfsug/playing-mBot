# Primi passi con mBot in C (= Getting started with mBot in the C language)

Il linguaggio C è alla base dei sistemi operativi Unix e non solo.
Quindi è quello che consente la più approfondita conoscenza dei meccanismi di base
dei nostri sistemi.

Perciò il C è anche un linguaggio "articolato" (per non dire complicato).

In questa directory mettiamo gli script realizzati/testati:

## Da http://people.csail.mit.edu/albert/bluez-intro/x502.html

* rfcomm-server.c
* rfcomm-client.c

Questi programmi consentono di avviare un server e un client rfcomm

**Requisiti**: la libreria bluez

## Compilare ed eseguire i programmi

Il C è un linguaggio compilato per questo è necessario creare file binari e poi eseguirli.
Questo si può fare con:

  # gcc -o <programma> -lbluetooth <programma>.c

Ad esempio:

  # gcc -o rfcomm-server -lbluetooth rfcomm-server.c

Per eseguire è sufficiente fare:

  # ./<programma>

e quindi

  # ./rfcomm-server

