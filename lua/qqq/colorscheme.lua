local M = {}

function M.init()
	local colorscheme = "darkplus"
	local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
	if not status_ok then
		return
	end
end

return M


