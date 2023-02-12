local M = {}

function M.init()
	local ok, bufferline = pcall(require, "bufferline")
	if not ok then
		return
	end
	
	local keyset = vim.keymap.set

	bufferline.setup{
	}
end

return M

