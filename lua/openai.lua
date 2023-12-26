local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("json-lua")

local function errorHandler(err)
	print("error")
end

local api_key = "api key"

local function get_prompt(notes, bullet_type)
	local file = io.open("../prompt.txt", "r")

	if not file then
		return
	end

	local prompt = file:read("*a").gsub("-", bullet_type)

	return prompt .. "\n" .. notes
end
