#!/usr/bin/luajit
TURBO_SSL = true
turbo = require("turbo")
lfs = require("lfs")
json = require("cjson")
config = require("config")
utils = require("utils")


-- Get the crrent ioloop
ioloop = turbo.ioloop.instance()


-- Template load helper(Caches imidiate forms before rendering)
templates = turbo.web.Mustache.TemplateHelper(config.templates_path)


-- Read posts
posts = json.decode(readFile(config.posts_path))




-- Load Handlers & ioloop callbacks from files in config.modules_dir
local handlers = {}
for file in lfs.dir(config.modules_dir) do
	if file:endsWith(".lua") then
		local ok, mod = pcall(dofile, config.modules_dir .. file)
		if not ok then
			eexit("Can't load module: " .. file)
		end
		if not mod.disables then
			for _,handler in pairs(mod.handlers) do
				handlers[#handlers + 1] = handler
			end
			print("Loaded module: " .. mod.title)
		end
	end
end


-- Add handlers to an app object & set it to listen on config.web_port
local app = turbo.web.Application(handlers, {
	cookie_secret = config.secret or randString(256),
	default_host = "/" -- If a website is not found, go here
})

app:listen(config.port_web, nil, { ssl_options = config.ssl })
print("Listening on port " .. config.port_web)

-- Start the ioloop
ioloop:start()
