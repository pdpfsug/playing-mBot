#!/usr/bin/env python

import bluetooth as Bluetooth

__author__ = "Luca Ferroni <fero@befair.it>"

address = "00:07:02:03:20:94"  # canale specifico del robottino di @KiraColci
channel = 1
client_socket = Bluetooth.BluetoothSocket(Bluetooth.RFCOMM)
client_socket.connect((address, channel))

d = {
    'movd': [0xff, 0x55, 0x06, 0x60, 0x02, 0x0a, 0x0a, 0xff, 0x0],
    'ledb': [0xff, 0x55, 0x09, 0x0, 0x2, 8, 7, 2, 0, 0x0, 0x0, 0xff],
    'ledg': [0xff, 0x55, 0x09, 0x0, 0x2, 8, 7, 2, 0, 0x0, 0xff, 0x0],
    'tonec4': [0xff, 0x55, 0x07, 0x00, 0x02, 0x22, 0x7b, 0x00, 0xfa, 0x00]
}
d['HELP'] = d.keys()

if __name__ == "__main__":

    while True:
        input = raw_input("command> ")
        if input not in d or input == 'HELP':
            print("HELP available commands> %s" % d['HELP'])
        else:
            client_socket.sendall("".join([chr(x) for x in d[input]]))
            data = client_socket.recv(1024)
            print("received %s" % [hex(ord(x)) for x in data])
