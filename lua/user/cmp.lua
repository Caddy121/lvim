local M = {}

M.config = function()
	local status_cmp_ok, cmp = pcall(require, "cmp")
	if not status_cmp_ok then
		return
	end
	local status_luasnip_ok, luasnip = pcall(require, "luasnip")
	if not status_luasnip_ok then
		return
	end

	lvim.builtin.cmp = {
		active = true,
		enabled = function()
			local buftype = vim.api.nvim_buf_get_option(0, "buftype")
			if buftype == "prompt" then
				return false
			end
			return lvim.builtin.cmp.active
		end,
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		completion = {
			---@usage The minimum length of a word to complete on.
			keyword_length = 1,
		},
		experimental = {
			ghost_text = false,
			native_menu = false,
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			max_width = 0,
			kind_icons = lvim.icons.kind,
			source_names = {
				nvim_lsp = "(LSP)",
				-- emoji = "(Emoji)",
				path = "(Path)",
				-- calc = "(Calc)",
				-- cmp_tabnine = "(Tabnine)",
				-- vsnip = "(Snippet)",
				luasnip = "(Snippet)",
				buffer = "(Buffer)",
				-- tmux = "(TMUX)",
				-- copilot = "(Copilot)",
				treesitter = "(TreeSitter)",
			},
			duplicates = {
				buffer = 1,
				path = 1,
				nvim_lsp = 0,
				luasnip = 1,
			},
			duplicates_default = 0,
			format = function(entry, vim_item)
				local max_width = lvim.builtin.cmp.formatting.max_width
				if max_width ~= 0 and #vim_item.abbr > max_width then
					vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. lvim.icons.ui.Ellipsis
				end
				if lvim.use_icons then
					vim_item.kind = lvim.builtin.cmp.formatting.kind_icons[vim_item.kind]

					if entry.source.name == "copilot" then
						vim_item.kind = lvim.icons.git.Octoface
						vim_item.kind_hl_group = "CmpItemKindCopilot"
					end

					if entry.source.name == "cmp_tabnine" then
						vim_item.kind = lvim.icons.misc.Robot
						vim_item.kind_hl_group = "CmpItemKindTabnine"
					end

					if entry.source.name == "crates" then
						vim_item.kind = lvim.icons.misc.Package
						vim_item.kind_hl_group = "CmpItemKindCrate"
					end

					if entry.source.name == "lab.quick_data" then
						vim_item.kind = lvim.icons.misc.CircuitBoard
						vim_item.kind_hl_group = "CmpItemKindConstant"
					end

					if entry.source.name == "emoji" then
						vim_item.kind = lvim.icons.misc.Smiley
						vim_item.kind_hl_group = "CmpItemKindEmoji"
					end
				end
				vim_item.menu = lvim.builtin.cmp.formatting.source_names[entry.source.name]
				vim_item.dup = lvim.builtin.cmp.formatting.duplicates[entry.source.name]
					or lvim.builtin.cmp.formatting.duplicates_default
				return vim_item
			end,
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		sources = {
			{
				name = "copilot",
				-- keyword_length = 0,
				max_item_count = 3,
				trigger_characters = {
					{
						".",
						":",
						"(",
						"'",
						'"',
						"[",
						",",
						"#",
						"*",
						"@",
						"|",
						"=",
						"-",
						"{",
						"/",
						"\\",
						"+",
						"?",
						" ",
						-- "\t",
						-- "\n",
					},
				},
			},
			{
				name = "nvim_lsp",
				entry_filter = function(entry, ctx)
					local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
					if kind == "Snippet" and ctx.prev_context.filetype == "java" then
						return false
					end
					if kind == "Text" then
						return false
					end
					return true
				end,
			},

			{ name = "path" },
			{ name = "luasnip" },
			{ name = "cmp_tabnine" },
			{ name = "nvim_lua" },
			{ name = "buffer" },
			{ name = "calc" },
			{ name = "emoji" },
			{ name = "treesitter" },
			{ name = "crates" },
			{ name = "tmux" },
		},
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
			["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-y>"] = cmp.mapping({
				i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
				c = function(fallback)
					if cmp.visible() then
						cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
					else
						fallback()
					end
				end,
			}),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				elseif jumpable(1) then
					luasnip.jump(1)
				elseif has_words_before() then
					-- cmp.complete()
					fallback()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-Space>"] = cmp.mapping.complete(),
			["<Right>"] = cmp.mapping.confirm({ select = true }),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					local confirm_opts = vim.deepcopy(lvim.builtin.cmp.confirm_opts) -- avoid mutating the original opts below
					local is_insert_mode = function()
						return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
					end
					if is_insert_mode() then -- prevent overwriting brackets
						confirm_opts.behavior = cmp.ConfirmBehavior.Insert
					end
					if cmp.confirm(confirm_opts) then
						return -- success, exit early
					end
				end

				fallback() -- if not exited early, always fallback
			end),
		}),
		cmdline = {
			enable = false,
			options = {
				{
					type = ":",
					sources = {
						{ name = "path" },
					},
				},
				{
					type = { "/", "?" },
					sources = {
						{ name = "buffer" },
					},
				},
			},
		},
	}
end

function M.setup()
	local cmp = require("cmp")
	cmp.setup(lvim.builtin.cmp)

	if lvim.builtin.cmp.cmdline.enable then
		for _, option in ipairs(lvim.builtin.cmp.cmdline.options) do
			cmp.setup.cmdline(option.type, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = option.sources,
			})
		end
	end
end

return M
