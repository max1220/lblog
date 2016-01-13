local turbo = require("turbo")

local ips = {}


local addPostHandler = class("addPostHandler", turbo.web.RequestHandler)
function addPostHandler:get()
	function garg(argname)
		-- Shortcut for getting an argument
		self:get_argument(argname, false, true)
	end



	if checkAuth(self) then
		local args = {
			title = assert(garg("title"), turbo.web.HTTPError(400, "Must specify title!")),
			created = tonumber(garg("created")) or os.time(),
			content_type = selectFrom(statics.content_types, garg("content_type")),
			content = assert(garg("content"), turbo.web.HTTPError(400, "Must specify content!")),
			authors = args.authors or {1},
			tags = args.tags or {"Uncategorized"},
			visible = args.visible or true
		}







	else
		-- User not logged in; Redirect to login page, show bad login
		self:redirect("/login?bad=yes")
	end
end

function addPostHandler:post()
	if checkAuth(self) then

	else
		-- User not logged in; Redirect to login page, show bad login
		self:redirect("/login?bad=yes")
	end
end





local mod = {
	title = "addpost",
	desc = "Provides authentication functionality",
	handlers = {
		{"/login", loginHandler}
	}
}
return mod
