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

**Requisiti**: la libreria bluez, su Debian-like: libbluetooth e libbluetooth-dev, su ArchLinux: bluez-libs

## Compilare ed eseguire i programmi

Il C è un linguaggio compilato per questo è necessario creare file binari e poi eseguirli.
Questo si può fare con:

  # gcc -o <programma> <programma>.c -lbluetooth

Ad esempio:

  # gcc -o rfcomm-server rfcomm-server.c -lbluetooth

**NOTA**: In alcune versioni di gcc è importante mettere -lbluetooth alla fine!

Per eseguire è sufficiente fare:

  # ./<programma>

e quindi

  # ./rfcomm-server

