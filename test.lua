#!/usr/bin/env lua
json = require("cjson")
require("utils")


local t = readFile("data/blog/references.json")
local o = json.decode(t)

dump(dump, o)
