#!/usr/bin/env lua
config = require("config")
json  = require("cjson")
require("utils")

 math.randomseed(os.time())


posts = json.decode(readFile(config.posts_path))


addPost{
	title = randString(12),
	content = randString(math.random(128, 512)),
	tags = {randString(6), randString(5)}
}



syncPostsRefs()


dump(dump, references)


--for k,v in pairs(references.authors[1]) do
--	print("mmmm", k,v)
--end
