-- the openpdu controller

local mymodule = {}

mymodule.default_action = "status"

mymodule.status = function(self)
	return self.model.status()
end

mymodule.poweron = function(self)
	return self.handle_form(self, self.model.get_setpower, self.model.setpoweron, self.clientdata, "commitpower", "Action result")
end

mymodule.poweroff = function(self)
	return self.handle_form(self, self.model.get_setpower, self.model.setpoweroff, self.clientdata, "commitpower", "Action result")
end

function mymodule.expert(self)
	return self.handle_form(self, self.model.get_filedetails, self.model.update_filedetails, self.clientdata, "Save", "Edit Config File", "Configuration Set")
end

return mymodule
