#!/usr/bin/env lua
config = require("config")
json  = require("cjson")
require("utils")

posts = json.decode(readFile(config.posts_path))


addPost{
	title = getInput("title"),
	content = getInput("content"),
	author = {1}
}



syncPostsRefs()
