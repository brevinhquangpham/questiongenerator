local tree_node = require("treenode")
local M = {}

local function is_only_whitespace(line)
	return line:match("^%s*$") ~= nil
end

local function starts_with_tab(line)
	return line:match("^%s%s") ~= nil
end

local function count_tokens(str)
	local count = 0
	-- Iterate over all words in the string
	for word in string.gmatch(str, "%S+") do
		count = count + 1
	end
	return count
end

local function str_starts_with(input_str, start_str)
	local str = input_str:gsub("^%s*(.-)%s*$", "%1")
	return string.find(str, "^" .. start_str) == 1
end

local function handle_third_tier(node, current_node)
	local current_level = current_node:get_level()

	if current_level == 3 then
		node:set_parent(current_node.parent)
		current_node.parent:add_children(node)
	else
		node:set_parent(current_node)
		current_node:add_children(node)
	end
end

local function handle_second_tier(node, current_node)
	local highest_parent = current_node:get_top_parent()
	node.parent = highest_parent
	current_node:add_children(node)
end

local function memoize_file_to_tree(file)
	local tree = {}
	local current_node = tree_node.new("", 1)

	for line in file:lines() do
		if str_starts_with(line, "###") then
			local node = tree_node.new(line, 3)
			handle_third_tier(node, current_node)
			current_node = node
		elseif str_starts_with(line, "##") then
			local node = tree_node.new(line, 2)
			handle_second_tier(node, current_node)
			current_node = node
		elseif str_starts_with(line, "#") then
			local node = tree_node.new(line, 1)
			table.insert(tree, node)
			current_node = node
		elseif starts_with_tab(line) then
			current_node:add_to_prev_content(line)
			print("ran")
		else
			current_node:add_to_contents(line)
		end
	end
	-- Prints for tests
	-- for i = 1, #tree do
	-- 	print(tree[i].header)
	-- 	tree[i]:print_contents()
	-- 	for j = 1, #tree[i].children do
	-- 		print(tree[i].children[j].header)
	-- 		tree[i].children[j]:print_contents()
	-- 		for z = 1, #tree[i].children[j].children do
	-- 			print(tree[i].children[j].children[z].header)
	-- 			tree[i].children[j].children[z]:print_contents()
	-- 		end
	-- 	end
	-- end
	-- End Prints
	return tree
end

local function table_concat(t1, t2)
	local result = t1
	for i = 1, #t2 do
		table.insert(result, t2[i])
	end
	return result
end

local function reverse_table_as_string(table)
	local result = ""
	for i = #table, 1, -1 do
		result = result .. table[i] .. "\n"
	end
	return result
end

local function get_parent_headers(node)
	local result = {}
	local current_node = node

	table.insert(result, current_node.header)

	while current_node.parent ~= nil do
		table.insert(result, current_node.parent.header)
		current_node = current_node.parent
	end
	return result
end

local function handle_header(node, chunk, token_max)
	local header_table = get_parent_headers(node)
	if count_tokens(chunk) + count_tokens(node.header) < token_max then
		return chunk .. node.header .. "\n"
	else
		return reverse_table_as_string(header_table)
	end
end

local function handle_contents(node, chunk, token_max, result)
	for i = 1, #node.contents do
		local content = node.contents[i]
		if not is_only_whitespace(content) then
			if count_tokens(chunk) + count_tokens(content) < token_max then
				chunk = chunk .. content .. "\n"
			else
				table.insert(result, chunk)
				chunk = reverse_table_as_string(get_parent_headers(node)) .. content .. "\n"
			end
		end
	end
	return chunk
end

local function handle_children(node, token_max, chunk, result) end

local function reconstruct_header(node, token_max, current_chunk, header_node)
	local result = {}
	local chunk = current_chunk

	chunk = handle_header(node, chunk, token_max)
	chunk = handle_contents(node, chunk, token_max, result)
	chunk = handle_children(node, token_max, chunk, result)

	return result, chunk
end

handle_children = function(node, token_max, chunk, result)
	for i = 1, #node.children do
		local inner_result, output_chunk = reconstruct_header(node.children[i], token_max, chunk, false)
		chunk = output_chunk
		table_concat(result, inner_result)
	end
	return chunk
end

local function reconstruct_tree(tree, token_max)
	local result = {}
	local chunk = ""
	print(tree)
	for i = 1, #tree do
		local inner_result, output_chunk = reconstruct_header(tree[i], token_max, chunk, true)
		table_concat(result, inner_result)
		chunk = output_chunk
	end
	table.insert(result, chunk)
	return result
end

function M.read_md_file(path)
	local file, err = io.open(path, "r")

	if not file then
		print("Error opening file:", err)
		return
	end
	-- AST
	local tree = memoize_file_to_tree(file)
	file:close()

	return reconstruct_tree(tree, 500)
end

return M
