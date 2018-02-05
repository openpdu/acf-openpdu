local mymodule = {}

posix = require("posix")
fs = require("acf.fs")

local configpath = "/etc/openpdu/"

local config = {}
for i=1,8 do
	config[i]={socket=i,status="unknown",description="Socket " .. tostring(i),actions={"on","off"}}
end
config[1].gpio=1
config[2].gpio=2
config[3].gpio=3
config[4].gpio=7
config[5].gpio=8
config[6].gpio=9
config[7].gpio=11
config[8].gpio=12

mymodule.status = function()
  mymodule.updatestatus()
	return cfe({ type="structure", value=config, label="Outlets" })
end

mymodule.updatestatus = function()
	for i=1,8 do
	  f = "/sys/class/gpio/gpio" .. tostring(config[i].gpio) .. "/value"
		v = fs.read_file(f)
		if (tonumber(v) == 0) then
			s = "On"
		elseif (tonumber(v) == 1) then
			s = "Off"
		else
			s = "unknown (" .. v .. ")"
		end
		config[i].status = s
	end
end


mymodule.setpower = function(socket, power, ret)
  -- Check to make sure the socket is valid
  if (socket == nil) then
          ret.errtxt = "Socket cannot be nil"
  elseif (not type(socket) == "number") then
          ret.errtxt = "Socket must be a number"
	elseif (tonumber(socket) < 0) then
          ret.errtxt = "Socket must be >0"
	elseif (tonumber(socket) > 8) then
          ret.errtxt = "Socket must be <=8"
  end

  -- If it is, poweron the socket
  if (ret.errtxt == nil ) then
		f = "/sys/class/gpio/gpio" .. tostring(config[tonumber(socket)].gpio) .. "/value"
		if (power == 1) then
			ret.descr = "Socket " .. tostring(socket) .. " Powered ON"
			p = "0"
		else
  		ret.descr = "Socket " .. tostring(socket) .. " Powered OFF"
			p = "1"
		end
		v = fs.write_file(f, p)
	  return ret
  end

	return ret
end



mymodule.get_setpower = function(self, clientdata)
  local socket = cfe({label="Socket", value=clientdata.socket or ""})
	return cfe({ type="group", label="Set Socket Power state", value={socket=socket} })
end

mymodule.setpoweron = function(self, r)
  mymodule.setpower(r.value.socket.value, 1, r)
	return r
end

mymodule.setpoweroff = function(self, r)
  mymodule.setpower(r.value.socket.value, 0, r)
	return r
end

return mymodule
