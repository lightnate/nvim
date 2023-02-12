local M = {}

function M.init()
	local ok, tree = pcall(require, "nvim-tree")
	if not ok then
		return
	end
	
	-- disable netrw at the very start of your init.lua (strongly advised)
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	local function open_nvim_tree()
		-- open the tree
		require("nvim-tree.api").tree.open()
	end
	
	-- 启动自动打开
	vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
	
	local keyset = vim.keymap.set
	keyset("n", "<leader>e", ":NvimTreeFindFileToggle<CR>")

	tree.setup{
		view = {
			mappings = {
				custom_only = false,
				list = {
					{ key = "l", action = "edit" },
					{ key = "L", action = "vsplit_preview" },
					{ key = "h", action = "close_node" },
					{ key = "H", action = "collapse_all"  },
				},
			},
    },
    actions = {
			open_file = {
				quit_on_open = false,
			},
    },
		renderer = {
			icons = {
				glyphs = {
					git = {
						unstaged = "M",
						staged = "|",
						unmerged = "",
						renamed = "R",
						untracked = "U",
						deleted = "D",
						ignored = "I",
					},
				},
			},
		},
	}
end

return M

