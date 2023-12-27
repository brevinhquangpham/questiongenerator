package.path = package.path .. ";../lua/?.lua"

local luaunit = require("luaunit")
local mdreader = require("mdreader")

local result = mdreader.read_md_file("testfiles/MODMFinal.md")
for i = 1, #result do
	print(result[i])
	print("--------------------------------------------------")
end
