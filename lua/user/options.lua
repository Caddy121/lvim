lvim.colorscheme = "duskfox"
lvim.transparent_window = false
lvim.log.level = "warn"
lvim.builtin.alpha.active = true
lvim.builtin.illuminate.active = true
lvim.builtin.indentlines.active = true
lvim.builtin.indentlines.options.enabled = true
lvim.builtin.indentlines.options.show_current_context = true
lvim.builtin.bufferline.active = false
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.breadcrumbs.active = true
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.dap.active = true
lvim.builtin.cmp.cmdline.enable = false
lvim.builtin.cmp.window.documentation = true
lvim.builtin.cmp.window.completion = {
  border = "rounded",
  winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
}
lvim.builtin.cmp.formatting.source_names = {
  nvim_lsp = "",
  luasnip = "",
  buffer = "",
  path = "",
  vsnip = "",
  treesitter = "",
}

-- ejs setup
lvim.autocommands.custom_groups = {
  -- Set njk,hbs,ejs as html syntax
  -- { "BufReadPost", "*.njk", "set filetype=html" },
  -- { "BufReadPost", "*.hbs", "set filetype=html" },
  { "BufReadPost", "*.ejs", "set filetype=html" },
}

lvim.builtin.treesitter.on_config_done = function()
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.embedded_template = {
    install_info = {
      url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
      files = { "src/parser.c" },
      requires_generate_from_grammar = true,
    },
    filetype = "ejs",
  }
end

vim.opt.showtabline = 0

local options = {
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0, -- always show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 100, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  laststatus = 3,
  showcmd = false,
  ruler = false,
  relativenumber = true, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  scrolloff = 8,
  sidescrolloff = 8,
  guifont = "Iosevka", -- the font used in graphical neovim applications
  title = true,
}

-- Indentlines
lvim.autocommands = {
  {
    { "Colorscheme" },
    {
      pattern = "*",
      callback = function()
        vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
        vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
        vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
        vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
        vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
        vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])
      end,
    },
  },
}

vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars:append({
  stl = " ",
})

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work

vim.filetype.add({
  extension = {
    conf = "dosini",
  },
})
