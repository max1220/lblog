bklgo32 <-- Arbeitstitel

Author-ID-Auflösung:
Jder author hat:
 - Profil Seite
 - name
 - Bild
 - link zu dingen

turbo server
 [ ] Admin-Interface -> modul   - bei neuem blog-post etc. wird die json neu generiert, und der blog-rendere aufgerufen.
 [ ] RSS-Feed -> module
 [ ] JSON-API -> module/statisch verlinkt zu data/blog(s.unten)
 [x] Liefert statische dinge statisch aus
 [x] Liest liste von dynamischen seiten aus ordner aus.



 Implementation notes
======================

 - References are by post ID

 post data format
------------------

	 Field name   | type   | desv
	--------------|--------|---------------
	 title        | string |
	 created      | number | unix timestamp
	 content_type | string | markdown or raw, ...
	 content      | string |
	 authors      | table  | list of author ids
	 tags         | table  | list of tags
	 visible      | bool   | is the post shown per default?





 directory structure
---------------------

	 Path            | Usage
	-----------------|-----------------
	./server.lua     | Main Server Module
	./config.lua     | Global config
  ./statics.lua    | Unconfigurable static values
	./generate.lua   | Exports the static part of the generator
	./utils.lua      | Generic nutz & boltz
	./add*.lua       | Adds a *
	./modules/*.lua  | Contains modules
	./data/          | Contains generated data
	./data/blog      | Blog-internal data(posts etc)
	./data/static    | static content
	./data/templates | templates

	in ./data/blog/:

	 Path           | Usage
	----------------|----------
	posts.json      | post data
	authors.json    | infos about authors
	references.json | references to posts, by tag, author, ...
