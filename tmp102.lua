------------------------------------------------------------------------------
-- TMP102 query module
--
-- LICENCE: http://opensource.org/licenses/MIT
-- Andy Coulson <acoulson2000@practical-apps.com>
-- Heavily based on work of Christee <Christee@nodemcu.com>
--
-- Example:
--  id=0
--  sda=5 ESP8266 GPIO14
--  scl=6 ESP8266 GPIO12
-- dofile("tmp102.lua").read(id, sda, scl)
------------------------------------------------------------------------------
local M
do
  -- cache
  local i2c, tmr = i2c, tmr
  
  
  local TMP102_ADDRESS = 0x48

  local read = function(id, sda, scl)
    i2c.setup(id, sda, scl, i2c.SLOW)
	i2c.address(id, TMP102_ADDRESS, i2c.TRANSMITTER)
    i2c.write(id, 0)	-- use register 0
	i2c.stop(id)
	
	tmr.delay(1000)
    i2c.start(id)
    i2c.address(id, TMP102_ADDRESS, i2c.RECEIVER)
    local r = i2c.read(id, 2)
    i2c.stop(id)
	local msb = r:byte(1) -- receive high byte
	local lsb = r:byte(2) -- receive low byte
    local tempval = bit.rshift(bit.bor(bit.lshift(msb, 8), lsb), 4) 
    --print("tempval: " .. tempval)
	local f = (tempval / 16) * 9 / 5 + 32   -- convert to fahrenheit
    --print("celsius: " .. celsius)
    return f
  end
	
  -- expose
  M = {
    read = read,
  }
end
return M
