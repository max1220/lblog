#!/usr/bin/env luajit

return function(data, outdir)
	local outfile = io.open(outdir .. "index.html")
	for k,v in pairs(data) do
		print(k,v)
	end
end
