vim.g.mapleader = " "        -- sets leader key
vim.g.netrw_banner = 0       -- gets rid of the annoying banner for netrw
vim.g.netrw_browse_split = 4 -- open in prior window
vim.g.netrw_altv = 1         -- change from left splitting to right splitting
vim.g.netrw_liststyle = 3    -- tree style view in netrw
vim.opt.title = true         -- show title
vim.cmd('set path+=**')      -- search current directory recursively
vim.opt.syntax = "ON"
vim.opt.backup = false
vim.opt.compatible = false     -- turn off vi compatibility mode
vim.opt.number = true          -- turn on line numbers
vim.opt.cursorline = true
vim.opt.relativenumber = true  -- turn on relative line numbers
vim.opt.mouse = 'a'            -- enable the mouse in all modes
vim.opt.ignorecase = true      -- enable case insensitive searching
vim.opt.smartcase = true       -- all searches are case insensitive unless there's a capital letter
vim.opt.hlsearch = false       -- disable all highlighted search results
vim.opt.incsearch = true       -- enable incremental searching
vim.opt.wrap = false           -- enable text wrapping
vim.opt.tabstop = 4            -- tabs=4spaces
vim.opt.shiftwidth = 4
vim.opt.pumheight = 10         -- number of items in popup menu
vim.opt.showtabline = 2        -- always show the tab line
vim.opt.laststatus = 2         -- always show statusline
vim.opt.signcolumn = "no"
vim.opt.expandtab = false      -- expand tab
vim.opt.smartindent = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.scrolloff = 8     -- scroll page when cursor is 8 lines from top/bottom
vim.opt.sidescrolloff = 8 -- scroll page when cursor is 8 spaces from left/right
vim.opt.clipboard = unnamedplus
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.splitbelow = true    -- split go below
vim.opt.splitright = true    -- vertical split to the right
vim.opt.termguicolors = true -- terminal gui colors
vim.opt.guicursor = ""
vim.diagnostic.config({
	virtual_text = false,
})
vim.cmd('filetype plugin on') -- set filetype
vim.cmd('set wildmenu')



local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
	print('Installing lazy.nvim....')
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "auto", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = false,
				extend_background_behind_borders = true,
				enable = {
					terminal = true,
					legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},
				styles = {
					bold = true,
					italic = false,
					transparency = false,
				},
			})
			vim.cmd("colorscheme rose-pine")
		end
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({})

			vim.keymap.set("n", "<leader>ff", require('fzf-lua').files, {})
			vim.keymap.set("n", "<leader>fg", require('fzf-lua').live_grep, {})
			vim.keymap.set("n", "<leader>fb", require('fzf-lua').buffers, {})
		end
	},
	{
		'echasnovski/mini.nvim',
		version = false,
		config = function()
			require('mini.ai').setup()
			require('mini.bracketed').setup()
			require('mini.comment').setup()
			require('mini.cursorword').setup()
			require('mini.jump2d').setup()
			require('mini.operators').setup()
			require('mini.pairs').setup()
			require('mini.statusline').setup()
			require('mini.surround').setup()
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					svelte = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					graphql = { "prettier" },
					liquid = { "prettier" },
					lua = { "stylua" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 5000,
				},
			})
		end,
	},
	{
		'Exafunction/codeium.vim',
		event = 'BufEnter',
		config = function()
			vim.keymap.set('i', '<Tab>', function() return vim.fn['codeium#Accept']() end,
				{ expr = true, silent = true })
			vim.keymap.set('i', '<C-f>', function() return vim.fn['codeium#CycleCompletions'](1) end,
				{ expr = true, silent = true })
			vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
				{ expr = true, silent = true })
			vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end,
				{ expr = true, silent = true })
		end
	},
	{ 'VonHeikemen/lsp-zero.nvim',        branch = 'v4.x' },
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'neovim/nvim-lspconfig' },
	{ 'L3MON4D3/LuaSnip' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'saadparwaiz1/cmp_luasnip' },
	{ 'rafamadriz/friendly-snippets' },
})

local lsp_zero = require('lsp-zero')

local lsp_attach = function(client, bufnr)
	local opts = { buffer = bufnr }

	vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
	vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
	vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
	vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
	vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

lsp_zero.extend_lspconfig({
	sign_text = true,
	lsp_attach = lsp_attach,
	float_border = 'rounded',
	capabilities = require('cmp_nvim_lsp').default_capabilities()
})

require('mason').setup({})
require('mason-lspconfig').setup({
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	}
})

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp' },
		{ name = 'luasnip', keyword_length = 2 },
		{ name = 'buffer',  keyword_length = 3 },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		-- confirm completion item
		['<Enter>'] = cmp.mapping.confirm({ select = true }),

		-- trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),

		-- scroll up and down the documentation window
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),

		-- navigate between snippet placeholders
		['<C-f>'] = cmp_action.luasnip_jump_forward(),
		['<C-b>'] = cmp_action.luasnip_jump_backward(),
	}),
	-- note: if you are going to use lsp-kind (another plugin)
	-- replace the line below with the function from lsp-kind
	formatting = lsp_zero.cmp_format({ details = true }),
	performance = {
		max_view_entries = 10,
	}
})


-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- fix ui size in terminal
local modified = false
vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
	callback = function()
		local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
		if normal.bg then
			io.write(string.format('\027]11;#%06x\027\\', normal.bg))
			modified = true
		end
	end,
})

vim.api.nvim_create_autocmd('UILeave', {
	callback = function()
		if modified then
			io.write('\027]111\027\\')
		end
	end,
})

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<leader><leader>", ":source ~/.config/nvim/init.lua<CR>") -- reload neovim config

map("n", "<leader>t", ":tabnew<CR>")                                -- space+t creates new tab
map("n", "<leader>x", ":tabclose<CR>")                              -- space+x closes current tab
map("n", "<leader>j", ":tabprevious<CR>")                           -- space+j moves to previous tab
map("n", "<leader>k", ":tabnext<CR>")                               -- space+k moves to next tab

map("n", "<leader>v", ":vsplit")                                    -- space+v creates a veritcal split
map("n", "<leader>s", ":split")                                     -- space+s creates a horizontal split

map("n", "<C-h>", "<C-w>h")                                         -- control+h switches to left split
map("n", "<C-l>", "<C-w>l")                                         -- control+l switches to right split
map("n", "<C-j>", "<C-w>j")                                         -- control+j switches to bottom split
map("n", "<C-k>", "<C-w>k")                                         -- control+k switches to top split

map("n", "<Tab>", ":bnext <CR>")                                    -- Tab goes to next buffer
map("n", "<S-Tab>", ":bprevious <CR>")                              -- Shift+Tab goes to previous buffer
map("n", "<leader>d", ":bd! <CR>")                                  -- Space+d delets current buffer

map("n", "<C-Left>", ":vertical resize +3<CR>")                     -- Control+Left resizes vertical split +
map("n", "<C-Right>", ":vertical resize -3<CR>")                    -- Control+Right resizes vertical split -
map("n", "<A-Left>", ":horizontal resize +3<CR>")                   -- Control+Left resizes vertical split +
map("n", "<A-Right>", ":horizontal resize -3<CR>")                  -- Control+Right resizes vertical split -

map("n", "<leader>e", ":25Lex<CR>")                                 -- space+e toggles netrw tree view

map("i", "kj", "<Esc>")                                             -- kj simulates ESC
map("i", "jk", "<Esc>")                                             -- jk simulates ESC
map("i", "jj", "<Esc>")                                             -- jk simulates ESC

map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("v", "<C-s>", ":sort<CR>") -- Sort highlighted text in visual mode with Control+S
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<C-j>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
