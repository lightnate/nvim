local M = {}

function M.init()
	local ok, leap = pcall(require, "leap")
	if not ok then
		return
	end
	
	local keyset = vim.keymap.set

	-- s + 2个字母进行查找
	leap.add_default_mappings{
	}
end

return M

