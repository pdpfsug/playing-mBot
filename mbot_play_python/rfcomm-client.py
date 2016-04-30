import bluetooth

# bd_addr = "00:0A:94:16:AE:66"
# bd_addr = "0C:60:76:DB:A4:1D"
bd_addr = "74:2F:68:36:4F:F9"

port = 1

sock=bluetooth.BluetoothSocket( bluetooth.RFCOMM )
sock.connect((bd_addr, port))

sock.send("hello!!")

sock.close()
