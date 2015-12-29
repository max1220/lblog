return {
	modules_dir = "modules/", -- Final backslash is important!
	port_web = 8080,
	authors_path = "data/blog/authors.json",
	posts_path = "data/blog/posts.json",
	references_path = "data/blog/references.json",
	templates_path = "data/templates/", -- base path for template loading
	ssl = {
		key_file = "certs/test.key",
		cert_file = "certs/test.crt"
	},
	users = require("users"),
--	secret = "a94a8fe5ccb19ba61c4c0873d391e987982fbbd3 " -- cookie secret
}
