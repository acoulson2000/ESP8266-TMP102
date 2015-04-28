# ESP8266-TMP102

I started a project to read the temperature from a TMP102 sensor from Sparkfun (my version has been retired, 
but the new one is essentially the same) and publish it to my OpenHAB server via MQTT over WiFi.

OpenHAB is a great, open source, home automation appplication with plugins to interface with just about anything.
Among them is support for MQTT, a lighweight message bus framework that seems ideal for smart devices to talk to
each other over WiFi in a way that is a bit more robust than simple socket connections. I encourage anyone 
interested in "connecting" their home to check out OpenHAB.

The TMP102 uses an I2C connection with some specific addressing. Fortunately, both MQTT and I2C libraries are 
compiled into the latest NodeMCU firmware - I really just had to write a little MQTT code and pilfer some I2C 
communication code from Christee@nodemcu.com (which I found in the BMP085 module under the LUA firmware 
project: https://github.com/nodemcu/nodemcu-firmware), and wire the SDA and SCL pins to GPIO14 and 12, 
respectively. 

The resulting code is hosted here for the benefith of other hobbyeits. 

One more thing - apparently LUA is integer-based (lame!) and this messed up my conversions to Centigrade. 
I had to download and flash a floating-point-capable firmware image (nodemcu_float_0.9.6-dev_20150406.bin) 
from https://github.com/nodemcu/nodemcu-firmware/releases.

More about the effort, and the nuances of prototyping with inexpensive ESP8266 modules can be found on my
blog: https://austinlightguy.wordpress.com/2015/04/28/esp8266-update/