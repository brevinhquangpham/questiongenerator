local TreeNode = {}
TreeNode.__index = TreeNode

function TreeNode.new(header, level, parent)
	local node = setmetatable({ level = level, header = header, parent = nil, contents = {}, children = {} }, TreeNode)

	if parent then
		node.parent = parent
	end

	return node
end

function TreeNode:add_children(children)
	table.insert(self.children, children)
end

function TreeNode:print_contents()
	for i = 1, #self.contents do
		print(self.contents[i])
	end
end

function TreeNode:set_parent(parent)
	self.parent = parent
end

function TreeNode:add_to_prev_content(line)
	self.contents[#self.contents] = self.contents[#self.contents] .. "\n" .. line
end

function TreeNode:get_level()
	return self.level
end

function TreeNode:add_to_contents(contents_to_add)
	table.insert(self.contents, contents_to_add)
end

function TreeNode:get_top_parent()
	local parent

	if not self.parent == nil then
		parent = self.parent
	else
		return self
	end

	while parent.parent ~= nil do
		parent = parent.parent
	end

	return parent
end

return TreeNode
