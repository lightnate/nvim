local M = {}

function M.init()
	local ok = M.setup_treesitter_configs()
	if not ok then
			return
	end

	require("nvim-treesitter.install").prefer_git = true
	for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
		config.install_info.url = config.install_info.url:gsub("https://github.com/", "git@github.com:")
	end

	M.setup_treesitter_context()
	M.setup_treesitter_folds()
end

M.setup_treesitter_configs = function()
	local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
	if not ok then
		return false
	end

	ts_configs.setup({
		ensure_installed = {
			"css",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"tsx",
			"typescript",
			"vue",
			"dart",
		},
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
			config = {
				-- TODO：vue和tsx 多行注释
				-- vue = {
				-- 	scss: '// %s',
				-- },
				-- check_node = function(node, config, key)
				-- 	print(node)
				-- end,
				-- tsx = {
				-- 	__default = '//11 %s',
				-- 	__multiline = '/*22 %s */',
				-- 	jsx_element = '{/*33 %s */}',
				-- 	jsx_fragment = '{/*44 %s */}',
				-- 	jsx_attribute = { __default = '//55 %s', __multiline = '/*555 %s */' },
				-- 	comment = { __default = '//66 %s', __multiline = '/*666 %s */' },
				-- 	call_expression = { __default = '//77 %s', __multiline = '/*777 %s */' },
				-- 	statement_block = { __default = '//88 %s', __multiline = '/*888 %s */' },
				-- 	spread_element = { __default = '//99 %s', __multiline = '/*999 %s */' },
				-- },
			}
		},
	})

    return true
end

M.setup_treesitter_context = function()
    local ok, tscontext = pcall(require, "treesitter-context")
    if ok then
        tscontext.setup({})
    end
end

M.setup_treesitter_folds = function()
    local ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
    if ok then
        return
    end

    local group = vim.api.nvim_create_augroup("FoldsWithTreesitter", { clear = true })
    local additional_file_types = {
        "typescriptreact",
    }
    local all_file_types = {}

    local parsers = ts_parsers.available_parsers()
    for _, filetype in ipairs(parsers) do
        table.insert(all_file_types, filetype)
    end
    for _, filetype in ipairs(additional_file_types) do
        table.insert(all_file_types, filetype)
    end

    for _, filetype in ipairs(all_file_types) do
        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetype,
            command = "setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()",
            group = group,
        })
    end
end

return M

