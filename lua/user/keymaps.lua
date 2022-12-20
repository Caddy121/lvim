lvim.leader = "space"

lvim.keys.normal_mode["<C-Space>"] = "<cmd>WhichKey \\<space><cr>"
lvim.keys.normal_mode["<C-i>"] = "<C-i>"

-- Better window navigation
lvim.keys.normal_mode["<A-n>"] = "<C-w>h"
lvim.keys.normal_mode["<A-e>"] = "<C-w>j"
lvim.keys.normal_mode["<A-u>"] = "<C-w>k"
lvim.keys.normal_mode["<A-i>"] = "<C-w>l"
lvim.keys.normal_mode["<A-tab>"] = "<c-6>"

-- Quit/Save
lvim.keys.normal_mode["<C-q>"] = ":q! <cr>"
lvim.keys.normal_mode["<C-w>"] = ":w <cr>"
lvim.keys.normal_mode["<C-z>"] = ":wq <cr>"

-- Delete word backward
lvim.keys.insert_mode["<A-BS>"] = "<c-w>"

function _G.set_terminal_keymaps()
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]])
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>j]])
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>k]])
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]])
end

-- vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

-- Resize with arrows
lvim.keys.normal_mode["<C-Up>"] = ":resize -2<cr>"
lvim.keys.normal_mode["<C-Down>"] = ":resize +2<cr>"
lvim.keys.normal_mode["<C-Left>"] = ":vertical resize -2<cr>"
lvim.keys.normal_mode["<C-Right>"] = ":vertical resize +2<cr>"

-- Center
lvim.keys.normal_mode["n"] = "nzz"
lvim.keys.normal_mode["N"] = "Nzz"
lvim.keys.normal_mode["*"] = "*zz"
lvim.keys.normal_mode["#"] = "#zz"
lvim.keys.normal_mode["g*"] = "g*zz"
lvim.keys.normal_mode["g#"] = "g#zz"

-- Move text up and down
lvim.keys.normal_mode["E"] = ":move '>+1<CR>gv-gv"
lvim.keys.visual_mode["E"] = ":move '>+1<CR>gv-gv"
lvim.keys.normal_mode["U"] = ":move '<-2<CR>gv-gv"
lvim.keys.visual_mode["U"] = ":move '<-2<CR>gv-gv"

-- keymap("x", "E", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "U", ":move '<-2<CR>gv-gv", opts)

-- Select all
lvim.keys.normal_mode["<C-a>"] = "gg<S-v>G"

-- Don't yank
-- lvim.keys.normal_mode["x"] = "_x"
-- lvim.keys.visual_mode["p"] = "_dP"
-- lvim.keys.normal_mode["p"] = "_dP"
-- keymap("x", "x", '"_x', opts)

-- Stay in indent mode
lvim.keys.visual_mode["<"] = "<gv"
lvim.keys.visual_mode[">"] = ">gv"

-- Undotree
lvim.key.normal_mode["F5"] = ":UndotreeToggle <cr>"

-- keymap("n", "<F7>", "<cmd>TSHighlightCapturesUnderCursor<cr>", opts)
lvim.keys.normal_mode["-"] = ":lua require'lir.float'.toggle()<cr>"
-- keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)
-- keymap("n", "<m-v>", "<cmd>lua require('lsp_lines').toggle()<cr>", opts)

-- keymap("n", "<m-/>", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
-- keymap("x", "<m-/>", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', opts)

-- vim.api.nvim_set_keymap(
--   "n",
--   "<tab>",
--   "<cmd>lua require('telescope').extensions.harpoon.marks(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal', prompt_title='Harpoon'})<cr>"
-- )
-- vim.api.nvim_set_keymap(
--   "n",
--   "<s-tab>",
--   "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal'})<cr>"
-- )

vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]])

lvim.keys.normal_mode["<m-q>"] = ":call QuickFixToggle()<cr>"

-- vim.api.nvim_set_keymap("n", "K", ":lua require('user.keymaps').show_documentation()<CR>")
