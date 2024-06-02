vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 7
vim.opt.startofline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.termguicolors = true
vim.opt.encoding = "UTF-8"
vim.opt.fileencoding = "UTF-8"
vim.opt.background = "dark"
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.cmdheight = 1
vim.opt.signcolumn = "yes"
vim.opt.exrc = false
vim.opt.colorcolumn = "120"

vim.filetype.add({
	extension = {
		templ = "templ",
	}
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = {
		"*.go",
		"*.rs",
		"*.tf",
		"*.tfvars",
	},
	command = "lua vim.lsp.buf.format()",
})

vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = {
		"*.tf",
		"*.tfvars",
	},
	command = "set commentstring=#\\ %s",
})

-- Color helper functions {
function HexToRGB(hex)
	hex = hex:gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

function RGBToHex(cr, cg, cb)
	return string.format("#%02x%02x%02x", cr, cg, cb)
end

function MakeColorDarker(hex)
	-- convert hex to RGB components
	local cr, cg, cb = HexToRGB(hex)

	-- decrease each component by 25%
	cr = cr * 0.75
	cg = cg * 0.75
	cb = cb * 0.75

	-- ensure that each component stays within the valid range of 0 to 255
	cr = math.min(cr, 255)
	cg = math.min(cg, 255)
	cb = math.min(cb, 255)

	-- convert RGB components back to hex
	return RGBToHex(cr, cg, cb)
end

function MakeColorMoreVibrant(hex)
	-- convert hex to RGB components
	local cr, cg, cb = HexToRGB(hex)

	-- increase each component by 10%
	cr = cr * 1.1
	cg = cg * 1.1
	cb = cb * 1.1

	-- ensure that each component stays within the valid range of 0 to 255
	cr = math.min(cr, 255)
	cg = math.min(cg, 255)
	cb = math.min(cb, 255)

	-- convert RGB components back to hex
	return RGBToHex(cr, cg, cb)
end

function SetAyuColorscheme()
	local theme = "dark"
	local theme_file = io.open("/tmp/rs_iterm2_theme", "r")
	if theme_file then
		local content = theme_file:read "*a"
		if content == "light" then
			theme = content
		end
	end

	if theme == "dark" then
		vim.opt.background = "dark"
	else
		vim.opt.background = "light"
	end

	require("ayu").setup({
		overrides = function()
			if theme == "dark" then
				return {
					ColorColumn  = { bg = "#222222" },
					CursorLine   = { bg = "#222222" },
					LineNrAbove  = { fg = "#808080" },
					LineNrBelow  = { fg = "#808080" },
					LspInlayHint = { fg = MakeColorMoreVibrant("#FACD02") },
					Normal       = { bg = "none" },
				}
			else
				local colors = require("ayu.colors")
				colors.generate(false) -- Pass `true` to enable mirage
				return {
					Comment               = { fg = MakeColorDarker(colors.comment), italic = true },
					Conceal               = { fg = MakeColorDarker(colors.comment) },
					Constant              = { fg = MakeColorDarker(colors.constant) },
					CursorLineConceal     = {
						fg = MakeColorDarker(colors.guide_normal),
						bg = MakeColorDarker(colors.line),
					},
					Delimiter             = { fg = MakeColorDarker(colors.special) },
					Error                 = { fg = MakeColorDarker(colors.white), bg = MakeColorDarker(colors.error) },
					Exception             = { fg = MakeColorDarker(colors.markup) },
					Function              = { fg = MakeColorDarker(colors.func) },
					Identifier            = { fg = MakeColorDarker(colors.entity) },
					Ignore                = { fg = MakeColorDarker(colors.fg) },
					LineNr                = { fg = MakeColorDarker(colors.guide_normal) },
					LspInlayHint          = { fg = MakeColorDarker("#FACD02") },
					Normal                = { bg = "#FFFFFF" },
					Operator              = { fg = MakeColorDarker(colors.operator) },
					PreProc               = { fg = MakeColorDarker(colors.accent) },
					Special               = { fg = MakeColorDarker(colors.accent) },
					Statement             = { fg = MakeColorDarker(colors.keyword) },
					String                = { fg = MakeColorDarker(colors.string) },
					Structure             = { fg = MakeColorDarker(colors.special) },
					Todo                  = { fg = MakeColorDarker(colors.markup) },
					Type                  = { fg = MakeColorDarker(colors.entity) },
					Underlined            = { sp = MakeColorDarker(colors.tag), underline = true },
					qfError               = { fg = MakeColorDarker(colors.error) },
					qfLineNr              = { fg = MakeColorDarker(colors.keyword) },
					["@property"]         = { fg = MakeColorDarker(colors.tag) },
					["@field"]            = { fg = MakeColorDarker(colors.tag) },
					["@parameter"]        = { fg = MakeColorDarker(colors.fg) },
					["@namespace"]        = { fg = MakeColorDarker(colors.func) },
					["@variable.builtin"] = { fg = MakeColorDarker(colors.func) },
					["@text.title"]       = { fg = MakeColorDarker(colors.keyword) },
					["@type.qualifier"]   = { fg = MakeColorDarker(colors.keyword) },
					["@storageclass"]     = { fg = MakeColorDarker(colors.keyword) },
					["@tag"]              = { fg = MakeColorDarker(colors.keyword) },
					["@tag.attribute"]    = { fg = MakeColorDarker(colors.entity) },
					["@variable"]         = { fg = MakeColorDarker(colors.fg) },
				}
			end
		end
	})
	vim.cmd "colorscheme ayu"
end

-- }

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " "       -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.floaterm_keymap_toggle = "<f10>"

require("lazy").setup({
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "c", "go", "html", "lua", "python", "rust", "vimdoc" },
				auto_install = true,
				sync_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						node_incremental = "<CR>",
						scope_incremental = "<S-CR>",
						node_decremental = "<BS>",
					},
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"hiphish/rainbow-delimiters.nvim",
		},
	},

	{ "raimon49/requirements.txt.vim" },

	{
		"Shatur/neovim-ayu",
		config = function()
			local mirage = false
			local colors = require("ayu.colors")
			colors.generate(mirage) -- Pass `true` to enable mirage

			require("ayu").setup({
				mirage = mirage,
				terminal = false,
			})
			SetAyuColorscheme()
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("mason").setup {}
			require("mason-lspconfig").setup {
				ensure_installed = {},
			}
			local disable_semantic_tokens = function(client, bufnr)
				client.server_capabilities.semanticTokensProvider = nil
				require("lsp-format").on_attach(client, bufnr)
			end
			require("mason-lspconfig").setup_handlers {
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server_name) -- default handler (optional)
					local lsp = require("lspconfig")[server_name]
					lsp.setup {
						on_attach = disable_semantic_tokens,
					}
				end,
				["basedpyright"] = function()
					require("lspconfig").basedpyright.setup {
						on_attach = disable_semantic_tokens,
						settings = {
							basedpyright = {
								analysis = {
									autoSearchPaths = true,
									diagnosticMode = "openFilesOnly",
									useLibraryCodeForTypes = true
								},
							},
						},
					}
				end,
				["gopls"] = function()
					require("lspconfig").gopls.setup {
						on_attach = disable_semantic_tokens,
						settings = {
							gopls = {
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									compositeLiteralTypes = true,
									constantValues = true,
									functionTypeParameters = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
							},
						},
					}
				end,
				["rust_analyzer"] = function()
					require("lspconfig").rust_analyzer.setup {
						on_attach = disable_semantic_tokens,
						settings = {
							rust_analyzer = {
								inlayHints = {
									bindingModeHints = { enable = true },
									chainingHints = { enable = true },
									closingBraceHints = { enable = true, minLines = 0 },
									closureCaptureHints = { enable = true },
									closureReturnTypeHints = { enable = "always" },
									implicitDrops = { enable = true },
								},
							},
						},
					}
				end,
			}
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = ".gitlab*",
				callback = function()
					vim.bo.filetype = "yaml.gitlab"
				end,
			})
			vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format()<cr>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { noremap = true })
		end,
		dependencies = {
			"williamboman/mason.nvim",
			{
				"williamboman/mason-lspconfig.nvim",
				setup = { automatic_installation = true, ensure_installed = {} },
			},
			{
				"lukas-reineke/lsp-format.nvim",
				setup = {
					templ = {
						order = { "html", "templ" },
					},
				},
			},
		},
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			{ "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
		},
		config = function()
			require("null-ls").setup()
			require("mason-null-ls").setup({
				ensure_installed = { "tflint" }
			})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			{
				"L3MON4D3/LuaSnip",
				version = "v1.*",
				build = "make install_jsregexp",
			},
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			vim.opt.completeopt = { "menu", "menuone", "noinsert" }

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" },
				}, {
					{ name = "buffer" },
				})
			})
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" }
				}
			})
		end
	},

	{ "lukas-reineke/indent-blankline.nvim" },

	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = true,
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },

	{
		"Wansmer/treesj",
		keys = { "<Leader>m", "<Leader>j", "<Leader>s" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},

	{
		"voldikss/vim-floaterm",
		keys = {
			{ "<f10>" },
		},
	},

	{ "airblade/vim-rooter" },

	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		keys = {
			{ "<leader>b",  function() require("telescope.builtin").buffers() end },
			{ "<leader>f",  function() require("telescope.builtin").find_files() end },
			{ "<leader>gb", function() require("telescope.builtin").git_branches() end },
			{ "<leader>G",  function() require("telescope.builtin").live_grep() end },
			{ "<leader>t",  function() require("telescope.builtin").treesitter() end },
		},
		config = function()
			require("telescope").setup {
				ripgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--trim",
				},
				pickers = {
					find_files = {
						find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
						hidden = true,
					},
				},
			}
			require("telescope").load_extension("fzf")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
	},

	{
		"aklt/plantuml-syntax",
		ft = "plantuml",
		dependencies = {
			{
				"weirongxu/plantuml-previewer.vim",
				dependencies = { "tyru/open-browser.vim", },
			},
		},
	},

	{ "tpope/vim-fugitive",  cmd = "G" },

	{ "famiu/bufdelete.nvim" },

	{ "jghauser/mkdir.nvim" },

	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{ "<leader>\\", "<cmd>NvimTreeToggle<cr>" },
		},
		opts = {
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 40,
				side = "right",
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				enable = true,
				dotfiles = false,
			},
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {},
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"folke/trouble.nvim",
		version = "v3.*",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
		opts = {}, -- for default options, refer to the configuration section for custom setup.
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false,
		},
	},
})

vim.cmd.colorscheme("ayu")

vim.lsp.set_log_level("off")

vim.api.nvim_set_keymap("n", "Q", "<Nop>", { noremap = true, silent = true }) -- Disable ex mode
vim.api.nvim_set_keymap("n", "<leader>h", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>",
	{ noremap = true, silent = true })
