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

local function handle_third_tier(node, line, current_node)
	local current_level = current_node:get_layer()

	if current_level == 3 then
		node:set_parent(current_node.parent)
		current_node.parent:add_children(node)
	else
		node:set_parent(current_node)
		current_node:add_children(node)
	end
end

local function handle_second_tier(node, line, current_node)
	local node = tree_node.new(line)
	local highest_parent = current_node:get_top_parent()
end

local function memoize_file_to_tree(file)
	local tree = {}
	local current_node
	for line in file:read("*l") do
		if str_starts_with(line, "###") then
			local node = tree_node.new(line)
			handle_third_tier(node, line, current_node)
			current_node = node
		elseif str_starts_with(line, "##") then
			-- TODO: FIx This
			local node = tree_node.new(line, current_node)
			handle_second_tier(line, current_level, current_node)
		end
	end
end

function M.read_md_file(path)
	local file, err = io.open(path, "r")

	if not file then
		print("Error opening file:", err)
		return
	end
	-- AST

	for line in file:read("*l") do
		table.insert(lines, line)
	end

	return handle_lines(lines)
end
