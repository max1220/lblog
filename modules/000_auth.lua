local turbo = require("turbo")

local ips = {}

function checkAuth(_self)
	local ok, username = pcall(_self.get_secure_cookie, _self, "logged_in")
	if ok then
		return username
	else
		return nil
	end
end


local loginHandler = class("loginHandler", turbo.web.RequestHandler)
function loginHandler:get()
	if checkAuth(self) then
		self:redirect("/")
	else
		local bad = self:get_argument("bad", false) == "yes"
		self:write(templates:render("login.mustache", {bad=bad}))
	end
end

function loginHandler:post()
	local username = self:get_argument("username")
	local password = turbo.hash.SHA1(self:get_argument("password")):hex()
	local time = os.time()
	local ip = self.request.remote_ip
	if (ips[self.request.remote_ip] or 0) > time then
		-- Not yet allowed to make a request
		ips[ip] = ips[ip] + 1
		local timeleft = ips[ip] - time
		turbo.log.warning("IP reached rate limit! Time left: " .. timeleft)
		self:write("Login rate limit for IP reached! Time left: " .. timeleft)
	else
		ips[ip] = nil
		if (config.users[username] or {}).password == password then
			self:set_secure_cookie("logged_in", username, 21600)
			self:redirect("/")
		else
			self:redirect("?bad=yes")
			ips[ip] = time + 1
		end
	end
end





local mod = {
	title = "authentication",
	desc = "Provides authentication functionality",
	handlers = {
		{"/login", loginHandler}
	}
}
return mod
