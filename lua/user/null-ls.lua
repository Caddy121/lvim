local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		command = "prettierd",
		args = { "--print-width=100", "--single-quote=true", "--jsx-single-quote=true", "--bracket-same-line=true" },
		filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "json", "scss" },
	},
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "black" },
})

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8" },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }
