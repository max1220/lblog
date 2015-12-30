local comments = {}


local commentHandler = class("commentHandler", turbo.web.RequestHandler)
function commentHandler:get(postID)
	local postID = tonumber(postID)
	if not postID then
		error(turbo.web.HTTPError(400, "Bad post ID"))
	end
	if posts[postID]then
		return templates.render("comments.lua", comments)
	else
		error(turbo.web.HTTPError(400, "Bad post ID"))
	end
end
function commentHandler:post(postID)
	local postID = tonumber(postID)
	if not postID then
		error(turbo.web.HTTPError(400, "Bad post ID"))
	end

	if posts[postID]then
		comments[#comments + 1] = {
			username = self:get_argument("username", "Anonym"),
			comment = self:get_argument("comment")
		}
		self:redirect("/comments/"..postID.."/", false)

	else
		error(turbo.web.HTTPError(400, "Bad post ID"))
	end
end




-- TODO: check for if ID exists in posts

local mod = {
	title = "comments",
	handlers = {
		{"^/comments/(%d+)/$", commentHandler}
	}
}
return mod
