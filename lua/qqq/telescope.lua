local M = {}

function M.init()
	local builtin = require "telescope.builtin"
	vim.keymap.set('n', '<C-p>', builtin.find_files, {})
	vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
	vim.keymap.set('n', '<C-;>', builtin.oldfiles, {})
	
	local actions = require "telescope.actions"
	
	require("telescope").setup{
		defaults = {
			mapping = {
				i = {
					-- TODO: 无效
					["<C-N>"] = actions.cycle_history_next,
					["<C-P>"] = actions.cycle_history_prev,

					-- 移动选中
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,

					-- 退出
					["<C-c>"] = actions.close,

					
					["<CR>"] = actions.select_default,
					-- 上下打开选中项
					["<C-x>"] = actions.select_horizontal,
					-- 左右打开选中项
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					-- 预览滚动
					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,
					["<PageUp>"] = actions.results_scrolling_up,
					["<PageDown>"] = actions.results_scrolling_down,

					["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
					["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
					-- TODO: ??
					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					["<C-l>"] = actions.complete_tag,
					["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
				},

				n = {
					["<esc>"] = actions.close,
					["<CR>"] = actions.select_default,
					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
					["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,
					["H"] = actions.move_to_top,
					["M"] = actions.move_to_middle,
					["L"] = actions.move_to_bottom,

					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,
					["gg"] = actions.move_to_top,
					["G"] = actions.move_to_bottom,

					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,

					["<PageUp>"] = actions.results_scrolling_up,
					["<PageDown>"] = actions.results_scrolling_down,

					["?"] = actions.which_key,
				},			
			}
		},
	}
end

return M
