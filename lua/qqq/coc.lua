local M = {}

function M.init()
	vim.g.coc_global_extensions = {
		"coc-marketplace",
		"coc-css",
		"coc-cssmodules",
		"coc-sql",
		"coc-actions",
		"coc-diagnostic",
		"coc-eslint",
		"coc-gitignore",
		"coc-html",
		"coc-html-css-support",
		"coc-jest",
		"coc-lists",
		"coc-prettier",
		"coc-json",
		"coc-stylelint",
		"coc-tsserver",
		"coc-vimlsp",
		"coc-vetur",
		"coc-yaml",
		"coc-xml",
		"coc-sh",
	}

  local keyset = vim.keymap.set
  -- Autocomplete
  function _G.check_back_space()
      local col = vim.fn.col('.') - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
  end

  -- Use Tab for trigger completion with characters ahead and navigate
  -- NOTE: There's always a completion item selected by default, you may want to enable
  -- no select by setting `"suggest.noselect": true` in your configuration file
  -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
  -- other plugins before putting this into your config
	-- 使用tab进行移动和补全;
  local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
	-- vim.api.nvim_command(":verbose imap <tab>")
  keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
  keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

  -- Make <CR> to accept selected completion item or notify coc.nvim to format
  -- <C-g>u breaks current undo, please make your own choice
	-- 回车补全
  keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

  -- Use `[g` and `]g` to navigate diagnostics
  -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
	-- [g 和 ]g 跳转错误
  keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
  keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

  -- GoTo code navigation
	-- <leader>d: 跳转定义
	-- <leader>td: 跳转类型定义
	-- <leader>i：跳转实现
	-- <leader>re: 跳转引用
  keyset("n", "<leader>d", "<Plug>(coc-definition)", {silent = true})
  keyset("n", "<leader>td", "<Plug>(coc-type-definition)", {silent = true})
  keyset("n", "<leader>i", "<Plug>(coc-implementation)", {silent = true})
  keyset("n", "<leade>re", "<Plug>(coc-references)", {silent = true})

  -- Use K to show documentation in preview window
	-- K查看文档
  function _G.show_docs()
      local cw = vim.fn.expand('<cword>')
      if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
      elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
      else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
      end
  end
  keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

  -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
  vim.api.nvim_create_augroup("CocGroup", {})
  vim.api.nvim_create_autocmd("CursorHold", {
      group = "CocGroup",
      command = "silent call CocActionAsync('highlight')",
      desc = "Highlight symbol under cursor on CursorHold"
  })

  -- Symbol renaming
	-- 重命名符号
  keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})
  
  -- Formatting selected code
	-- 格式化选择代码
  keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
  keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

  -- Setup formatexpr specified filetype(s)
	-- ?
  vim.api.nvim_create_autocmd("FileType", {
      group = "CocGroup",
      pattern = "typescript,json",
      command = "setl formatexpr=CocAction('formatSelected')",
      desc = "Setup formatexpr specified filetype(s)."
  })

  -- Update signature help on jump placeholder
	-- ?
  vim.api.nvim_create_autocmd("User", {
      group = "CocGroup",
      pattern = "CocJumpPlaceholder",
      command = "call CocActionAsync('showSignatureHelp')",
      desc = "Update signature help on jump placeholder"
  })

  -- Apply codeAction to the selected region
  -- Example: `<leader>aap` for current paragraph
	-- <leader>a{motion}显示区域action
  local opts = {silent = true, nowait = true}
  keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
  keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

  -- Remap keys for apply code actions at the cursor position.
  keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
  -- Remap keys for apply code actions affect whole buffer.
  keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
  -- Remap keys for applying codeActions to the current buffer
  keyset("n", "<leader>ac", "<Plug>(coc-codeaction)", opts)
  -- Apply the most preferred quickfix action on the current line.
  keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

  -- Remap keys for apply refactor code actions.
  keyset("n", "<leader>rf", "<Plug>(coc-codeaction-refactor)", { silent = true })
  keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
  keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

  -- Run the Code Lens actions on the current line
  keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


  -- Map function and class text objects
  -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
  keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
  keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
  keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
  keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
  keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
  keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
  keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
  keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)

end

return M
