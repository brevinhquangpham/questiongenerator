local TreeNode = {}

function TreeNode.new(header, level, parent)
	local node = { level = level, header = header, parent = nil, contents = {}, children = {} }

	if parent then
		node.parent = parent
	end

	return node
end

function TreeNode:add_children(children)
	table.insert(self.children, children)
end

function TreeNode:set_parent(parent)
	self.parent = parent
end

function TreeNode:get_level()
	return self.level
end

function TreeNode:add_to_contents(contents_to_add)
	table.insert(self.contents, contents_to_add)
end

function TreeNode:edit_contents(contents)
	self.contente = contents
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
