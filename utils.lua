function string.endsWith(str1, str2)
	-- checks if a string ends with another.
	-- You can use this like ("abcd").endsWith("cd") -> true
	return str1:sub(-#str2) == str2
end

function eexit(msg)
	-- exits with an optional error message
	print("An error occured")
	if msg then
		print("Error was: " .. tostring(msg))
	end
	os.exit(1)
end

function getInput(question, default)
	-- Aks the user for input on the specified question and returns it.
	-- loops until the user inputet something or default if it's is specified
	io.write(question or "", "> ")
	while true do
		local input = io.read("*l")
		if input == "" then
			if default then
				return default
			else
				print("Must specify!")
			end
		else
			return input
		end
	end
end

function readDelimList(str, delim)
	-- Splits a list into substrings by delimiter-
	-- for example for a CSV use t = readDelimList("hello,world", ",")
	-- t[1] = "hello", t[2] = "world"
	local list = {}
	for match in str:gmatch("(.-)" .. delim) do
		list[#list + 1] = match
	end
	return list
end

function readFile(path)
	-- reads a file by path, returns it as a string or nil
	local f = io.open(path, "r")
	if f then
		local ret = f:read("*a")
		f:close()
		return ret
	else
		return nil
	end
end

function writeFile(path, data)
	-- writes a string to a file
	local f = io.open(path, "w")
	if f then
		f:write(data)
		f:close()
		return true
	else
		return nil
	end
end

function randString(len)
	local len = len or 32
	-- Generates a random string of lenght len(default 32)
	local ret = {}
	local char = string.char
	local rand = math.random
	for i=1, len do
		ret[#ret + 1] = char(rand(66, 123))
	end
	return table.concat(ret)
end

function addPost(args)
	-- Adds a post, returns post ID

	local post = {
		title = assert(args.title),
		created = tonumber(args.created) or os.time(),
		content_type = args.content_type or "raw",
		content = assert(args.content),
		authors = args.authors or {1},
		tags = args.tags or {"Uncategorized"},
		visible = args.visible or true
	}

	local postID = #posts + 1
	posts[postID] = post

	syncPostsRefs()

	return postID
end

function syncPostsRefs()
	-- Update references by posts
	references = {}
	for postID, post in pairs(posts) do
		for k, v in pairs(post) do
			references[k] = references[k] or {}
			if type(v) == "table" then
				for _,va in ipairs(v) do
					references[k][tostring(va)] = references[k][tostring(va)] or {}
					references[k][tostring(va)][#references[k][tostring(va)] + 1] = postID
				end
			else
				references[k][tostring(v)] = references[k][tostring(v)] or {}
				references[k][tostring(v)][#references[k][tostring(v)] + 1] = postID
			end
		end
	end

	-- sync to disk
	writeFile(config.posts_path, json.encode(posts))
	writeFile(config.references_path, json.encode(references))
end

function isList(tbl)
	-- Checks if a list only contains numeric indexes
	for key in pairs(tbl) do
		if not type(key) == "number" then
			return false
		end
	end
	return true
end

function dump(this, tbl, indent)
	-- Dumps a table
	local indent = indent or 0
	for k,v in pairs(tbl) do
		if type(v) == "table" then
			io.write(("\t"):rep(indent), tostring(k), ":\n")
			this(this, v, indent + 1)
		else
			io.write(("\t"):rep(indent), tostring(k), ":\t", tostring(v), "\n")
		end
	end
end
