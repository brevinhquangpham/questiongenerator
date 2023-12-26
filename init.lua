local M = {}
local openai = require("openai")

local function get_question_filepath()
	local absolute_path = vim.fn.expand("%:p")
	local name = vim.fn.expand("%:t")

	return
end

M.generate_questions = function()
	if not vim.bo.filetype == "markdown" then
		print()
	end
	local current_filepath = vim.fn.expand("%:p")
	file = io.open(current_filepath)
	-- Read filepath
	-- parse the lines
	-- Send to openai
	-- Write openai
end

return M
