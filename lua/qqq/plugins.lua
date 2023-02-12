local plugins = {
	-- theme
	{
		"lunarvim/darkplus.nvim",
		url = "git@github.com:lunarvim/darkplus.nvim.git",
		lazy = false,
		priority = 1000,
		config = function()
			require("qqq.colorscheme").init()
		end,
	},
	-- coc
	{
    "neoclide/coc.nvim",
		url = "git@github.com:neoclide/coc.nvim.git",
		branch = "release",
		config = function()
			require("qqq.coc").init()
		end,
  },
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		url = "git@github.com:nvim-telescope/telescope.nvim.git",
		config = function()
			require("qqq.telescope").init()
		end,
		dependencies = {
			{
				"nvim-lua/plenary.nvim",
				url = "git@github.com:nvim-lua/plenary.nvim.git",
			},
		},
	},
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		url = "git@github.com:nvim-treesitter/nvim-treesitter.git",
		config = function()
			require("qqq.treesitter").init()
		end,
	},
	-- pairs
	{
		"jiangmiao/auto-pairs",
		url = "git@github.com:jiangmiao/auto-pairs.git",
		config = function()
			require("qqq.auto-pairs").init()
		end,
	},
	-- comment
	{
		"numToStr/Comment.nvim",
		url = "git@github.com:numToStr/Comment.nvim.git",
		config = function()
			require("qqq.comment").init()
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		url = "git@github.com:JoosepAlviste/nvim-ts-context-commentstring.git",
	},
	-- git
	{
		"lewis6991/gitsigns.nvim",
		url = "git@github.com:lewis6991/gitsigns.nvim.git",
		config = function()
			require("qqq.gitsigns").init()
		end,
	},
	-- nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		url = "git@github.com:nvim-tree/nvim-tree.lua.git",
		config = function()
			require("qqq.nvim-tree").init()
		end,
		dependencies = {
			{
				"nvim-tree/nvim-web-devicons",
				url = "git@github.com:nvim-tree/nvim-web-devicons.git",
			},
		},
	},
	-- bufferline
	{
		"akinsho/bufferline.nvim",
		url = "git@github.com:akinsho/bufferline.nvim.git",
		tag = "v3.2.0",
		config = function()
			require("qqq.bufferline").init()
		end,
	},
	-- terminal
	{
		"akinsho/toggleterm.nvim",
		url = "git@github.com:akinsho/toggleterm.nvim.git",
		config = function()
			require("qqq.toggleterm").init()
		end,
	},
	-- motion
	{
		"ggandor/leap.nvim",
		url = "git@github.com:ggandor/leap.nvim.git",
		config = function()
			require("qqq.leap").init()
		end,
	},
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "git@github.com:folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins)

