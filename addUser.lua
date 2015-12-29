#!/usr/bin/env lua

local config = require("config")
local json  = require("cjson")
require("utils")

local f = io.open(config.user_path, "r")
local obj = json.decode(f:read("*a"))
f:close()

obj[#obj + 1] = {
	username = getInput("Username"),
	fullname = getInput("Full name", ""),
	image = getInput("Image path", ""),
	homepage = getInput("Home page", ""),
}

local f = io.open(config.user_path, "w")
f:write(json.encode(obj))
f:close()

print("User ID:", #obj)
