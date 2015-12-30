local turbo = require("turbo")

local mod = {
	title = "static",
	desc = "handles static content(such as the bootstrap CSS) under /static/",
	handlers = {
		{"^/static/(.*)$", turbo.web.StaticFileHandler, "data/static/"},
		{"^/$", turbo.web.StaticFileHandler, "data/index.html"}
	}
}
return mod
