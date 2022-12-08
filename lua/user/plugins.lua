-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]

lvim.plugins = {

	-- Colorschemes
	"ellisonleao/gruvbox.nvim",
	"Shatur/neovim-ayu",
	"EdenEast/nightfox.nvim",
	{ "catppuccin/nvim", as = "catppuccin" },
	"habamax/vim-habaurora",
	"sainnhe/sonokai",
	"navarasu/onedark.nvim",
	"lunarvim/horizon.nvim",
	{ "rose-pine/neovim", as = "rose-pine" },
	"rafamadriz/neon",
	"marko-cerovac/material.nvim",
	"bluz71/vim-nightfly-colors",
	"sainnhe/edge",
	"Mofiqul/dracula.nvim",
	"projekt0n/github-nvim-theme",
	"olimorris/onedarkpro.nvim",
	"rebelot/kanagawa.nvim",
	"cpea2506/one_monokai.nvim",

	-- LSP
	"lvimuser/lsp-inlayhints.nvim",

	-- Syntax/Treesitter
	"nvim-treesitter/playground",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"folke/todo-comments.nvim",
	"windwp/nvim-ts-autotag",
	"kylechui/nvim-surround",
	"p00f/nvim-ts-rainbow",

	-- Marks
	"christianchiarulli/harpoon",
	"MattesGroeger/vim-bookmarks",

	-- Color
	"NvChad/nvim-colorizer.lua",

	-- Utility
	"ghillb/cybu.nvim",
	"moll/vim-bbye",
	"mattn/webapi-vim",
	"is0n/jaq-nvim",
	"jose-elias-alvarez/typescript.nvim",
	"phaazon/hop.nvim",
	-- "b0o/incline.nvim",

	-- Debugging
	"leoluz/nvim-dap-go",
	"mfussenegger/nvim-dap-python",
	"mxsdev/nvim-dap-vscode-js",

	-- Git
	"f-person/git-blame.nvim",
	"ruifm/gitlinker.nvim",
	"mattn/vim-gist",
	"sindrets/diffview.nvim",

	-- Quickfix
	"kevinhwang91/nvim-bqf",

	-- Editing Support
	"nacro90/numb.nvim",
	"karb94/neoscroll.nvim",
	"mg979/vim-visual-multi",
	"mbbill/undotree",

	-- Notes
	"vimwiki/vimwiki",

	-- Java
	"mfussenegger/nvim-jdtls",

	-- Extras
	{
		"saecki/crates.nvim",
		tag = "v0.3.0",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
			})
		end,
	},
	{ "christianchiarulli/telescope-tabs", branch = "chris" },
	"monaqa/dial.nvim",
	{
		"0x100101/lab.nvim",
		run = "cd js && npm ci",
	},
}
