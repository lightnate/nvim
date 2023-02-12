local M = {}

function M.init()
	local ok, toggleterm = pcall(require, "toggleterm")
	if not ok then
		return
	end

	local keyset = vim.keymap.set
	
	-- {number}<leader>`打开多个终端
	keyset("n", "<leader>`", ":ToggleTerm<CR>")
	-- ;; 从终端插入模式恢复到终端普通模式
	keyset("t", ";;", [[<C-\><C-n>]])
	-- esc 隐藏终端
	keyset("t", "<Esc>", [[<C-\><C-n>:q<CR>]])

	toggleterm.setup{
	}

	
	local Terminal  = require('toggleterm.terminal').Terminal
	local lazygit = Terminal:new({
		cmd = "lazygit",
		dir = "git_dir",
		direction = "float",
		float_opts = {
			border = "double",
		},
		-- function to run on opening the terminal
		on_open = function(term)
			vim.cmd("startinsert!")
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
		end,
		-- function to run on closing the terminal
		on_close = function(term)
			vim.cmd("startinsert!")
		end,
	})

	function _lazygit_toggle()
		lazygit:toggle()
	end

	-- <leader>lg 打开lazygit
	vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
end

return M

