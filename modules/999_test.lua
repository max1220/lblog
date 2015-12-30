local turbo = require("turbo")

local testHandler = class("exampleHandler", turbo.web.RequestHandler)
function testHandler:get()
	self:write("<html><body><h1>Example!</h1></body></html>")
end






local mod = {
	title = "test module",
	handlers = {
		{"/test", testHandler}
	}
}
return mod
