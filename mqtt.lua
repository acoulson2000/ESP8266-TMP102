BROKER = "192.168.2.51"
BRPORT = 1883
BRUSER = ""
BRPWD  = ""
CLIENTID = "ESP8266-" ..  node.chipid()

id=0
sda=5 -- ESP8266 GPIO14
scl=6 -- ESP8266 GPIO12

print "Connecting to MQTT broker. Please wait..."
m = mqtt.Client( CLIENTID, 120, BRUSER, BRPWD)
m:connect( BROKER , BRPORT, 0, function(conn)
     print("Connected to MQTT:" .. BROKER .. ":" .. BRPORT .." as " .. CLIENTID )
     tmp = dofile("tmp102.lua").read(id, sda, scl)
     m:publish("/sensors/temperature",tmp,0,0, function(conn)
          print ("temp published") 
          tmr.delay(10000)
     end)
end)

