local mymodule = {}

posix = require("posix")
fs = require("acf.fs")
json = require('cjson')
modelfunctions = require("modelfunctions")

local outletsConfigfile = "/etc/openpdu/outlets.conf"
local boardsConfigfile = "/etc/openpdu/boards.conf"
local s = modelfunctions.run_executable({"/usr/bin/openpdu", "outlets", "-j"})
local o = json.decode(s)
local outlets = {}

for Index, Value in pairs( o.outlets ) do
	if (Value.powerstatus) then
		s = "On"
	else
	  s = "Off"
	end
  outlets[Value.outlet+1] = {outlet=Value.outlet,status=s,description=Value.description,actions={"on","off"}}
end




mymodule.status = function()
	return cfe({ type="structure", value=outlets, label="Outlets" })
end

mymodule.setpower = function(outlet, power, ret)
	return modelfunctions.run_executable({"/usr/bin/openpdu", "setpower", outlet, power})
end



mymodule.get_setpower = function(self, clientdata)
  local outlet = cfe({label="Outlet", value=clientdata.outlet or ""})
	return cfe({ type="group", label="Set Outlet Power state", value={outlet=outlet} })
end

mymodule.setpoweron = function(self, r)
  mymodule.setpower(r.value.outlet.value, 1, r)
	return r
end

mymodule.setpoweroff = function(self, r)
  mymodule.setpower(r.value.outlet.value, 0, r)
	return r
end

function mymodule.get_outletsFiledetails()
	return modelfunctions.getfiledetails(outletsConfigfile)
end

function mymodule.update_outletsFiledetails(self, filedetails)
	return modelfunctions.setfiledetails(self, filedetails, {outletsConfigfile})
end

function mymodule.get_boardsFiledetails()
	return modelfunctions.getfiledetails(boardsConfigfile)
end

function mymodule.update_boardsFiledetails(self, filedetails)
	return modelfunctions.setfiledetails(self, filedetails, {boardsConfigfile})
end

return mymodule
