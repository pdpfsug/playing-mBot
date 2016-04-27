# minetest-digiline-arduino
A minetest Mod to control a real Arduino YUN with the REST protocol

With the digilines_arduino block you can send REST POST command to a real Arduino connected in the same WLAN.
You need to set the channel to connect the block to digilines and the IP Address of Arduino.

With the LUACONTROLLER function:

digiline_send("ch1","digital/13/1") 

you will send through the channel ch1, to your YUN, the POST :  

http://192.168.1.44/arduino/digital/13/1

You need to install on your system the lua-socket library.


Tested only on Debian 8. May be buggy. Comments and suggestions are welcome.
