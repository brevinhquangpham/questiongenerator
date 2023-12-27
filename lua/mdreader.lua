local tree_node = require("treenode")
M = {}

local function str_starts_with(input_str, start_str)
	local str = input_str:gsub("^%s*(.-)%s*$", "%1")
	return string.find(str, "^" .. start_str) == 1
end

local function handle_lines(lines)
	for line in lines do
	end
end

local function handle_third_tier(node, current_node)
	local current_level = current_node:get_layer()

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
end

local function memoize_file_to_tree(file)
	local tree = {}
	local current_node = tree_node.new("", 1)

	for line in file:read("*l") do
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
		else
			current_node:add_to_contents(line)
		end
	end
	return tree
end

local function table_concat(t1, t2)
	local result = t1
	for element in t2 do
		table.insert(result, t2)
	end
	return result
end

local function reverse_table_as_string(table)
	local result = ""
	for i = #table, 0, -1 do
		result = result .. table[i] .. "\n"
	end
	return result
end

local function get_parent_headers(node)
	local result = {}
	local current_node = node

	table.insert(result, current_node.header)

	while current_node.parent ~= nil do
		table.insert(result, current_node.header)
	end

	return result
end

local function reconstruct_header(node, token_max, current_chunk)
	local result = {}
	local chunk = current_chunk

	if #chunk + node.header >= token_max then
		chunk = chunk .. node.contents[i] .. "\n"
	else
		table.insert(result, chunk)
		local header_table = get_parent_headers(node)
		chunk = reverse_table_as_string(header_table)
	end

	for i = 1, #node.contents, 1 do
		if #chunk + node.contents[i] >= token_max then
			chunk = chunk .. node.contents[i] .. "\n"
		else
			table.insert(result, chunk)
			local header_table = get_parent_headers(node)
			chunk = reverse_table_as_string(header_table)
		end
	end

	local current_node = node

	for i = 1, #current_node.children, 1 do
		local inner_result, output_chunk = reconstruct_header(current_node.children[i], token_max, chunk)
		chunk = output_chunk
		table_concat(result, inner_result)
	end

	return result, chunk
end

local function reconstruct_tree(tree, token_max)
	local result = {}
	for node in tree do
		table_concat(result, reconstruct_header(node, token_max, ""))
	end
end

function M.read_md_file(path)
	local file, err = io.open(path, "r")

	if not file then
		print("Error opening file:", err)
		return
	end
	-- AST

	return memoize_file_to_tree(file)
end

function M.read_tree(tree)
	local result = ""
	for node in tree do
		result = result .. node:get_header_and_contents() .. "\n"
	end
end
