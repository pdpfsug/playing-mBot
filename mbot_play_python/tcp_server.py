# -*- coding: utf-8 -*-

"""Server TCP MakerBot

Il server si mette in ascolto sulla porta 4000
ci si può collegare tramite telnet e passargli le stringhe (piu' comodo)
da inviare a MakerBot.

Si puo' simulare la connessione al MakerBot mettendo TEST_MODE = True

Ci si può connettere con telnet localhost 4000
o altro client TCP
"""

import SocketServer
import bluetooth as Bluetooth

__author__ = "Luca Ferroni <fero@befair.it>"
__license__ = "GNU Affero Public License v3"

HOST, PORT = "", 4000
address = "00:07:02:03:20:94"  # indirizzo MAC device bluetoot del robottino di @KiraColci
channel = 1
TEST_MODE = False  # Mettere True per testare il tutto


class MakerBotTCPHandler(SocketServer.BaseRequestHandler):
    """
    The request handler class for our server.

    It is instantiated once per connection to the server, and must
    override the handle() method to implement communication to the
    client.
    """

    def serve_forever(self, client_socket):
        self.client_socket = client_socket
        super(MakerBotTCPHandler, self).serve_forever()

    def traduci_da_client_a_mbot(self, data):
        """Traduce il comando da caratteri a bytes per MakerBot.

        Ogni byte viene tradotto da 2 caratteri separati da spazio

        (potremmo utilizzare self.data, ma didatticamente e' meglio passare il parametro)
        """
        SPAZIO = " "
        CARATTERI_ESADECIMALI = data.split(SPAZIO)
        INTERI_ESADECIMALI = [int(x, 16) for x in CARATTERI_ESADECIMALI]
        return "".join([chr(x) for x in INTERI_ESADECIMALI])

    def handle(self):
        # self.request is the TCP socket connected to the client
        self.data = self.request.recv(1024).strip()
        print("{} ha scritto:".format(self.client_address[0]))
        print(self.data)

        cmd_to_mbot = self.traduci_da_client_a_mbot(self.data)

        # Invia il comando al MakerBot
        self.client_socket.sendall(cmd_to_mbot)

        # Attende la risposta del robot
        mbot_data = self.client_socket.recv(1024)

        # e lo rimanda indietro al client
        printable_mbot_data = [hex(ord(x)) for x in mbot_data]
        print("received %s" % printable_mbot_data)
        self.request.sendall(printable_mbot_data)


class TestSocket(object):

    def __init__(self, *args):
        print("Inizializzato il socket. Parametri %s" % args)

    def connect(self, *args):
        print("Mi connetto a: %s" % args)

    def recv(self):
        print("Restituisco quello che mi e' stato dato")
        return self.data

    def send(self, data):
        print("Il Makerbot riceve %s" % data)
        self.data = data

    sendall = send


if __name__ == "__main__":

    # Create the server, binding to localhost on port 9999
    server = SocketServer.TCPServer((HOST, PORT), MakerBotTCPHandler)

    if TEST_MODE:
        SocketClass = TestSocket
    else:
        SocketClass = Bluetooth.BluetoothSocket

    client_socket = SocketClass(Bluetooth.RFCOMM)
    client_socket.connect((address, channel))

    # Activate the server; this will keep running until you
    # interrupt the program with Ctrl-C
    server.serve_forever(client_socket)