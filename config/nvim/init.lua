vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

if vim.g.neovide then
	vim.o.guifont = "Hack Nerd Font:h14:#h-slight"
	vim.g.neovide_transparency = 0.75
	vim.g.neovide_window_blurred = true
end

vim.opt.autoread = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.softtabstop = 0
vim.opt.preserveindent = true
vim.opt.eol = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wrap = true
vim.opt.signcolumn = "yes"
vim.opt.hlsearch = false
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.shortmess = "aoOstTWIcC"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.undofile = true
vim.opt.fillchars = { eob = " " }
vim.opt.virtualedit = "onemore"
vim.opt.timeout = false
-- vim.opt.scrolloff = 999

-- FTPlugin, begone
vim.cmd("autocmd BufReadPre,BufNewFile * let b:did_ftplugin = 1")

vim.diagnostic.config({
	severity_sort = true,
	signs = {
		text = {
			-- Don't ask, I like them
			[vim.diagnostic.severity.ERROR] = "🐈",
			[vim.diagnostic.severity.WARN] = "🔪",
			[vim.diagnostic.severity.INFO] = "🤔",
			[vim.diagnostic.severity.HINT] = "⭐",
		},
	},
})

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")     -- move line up(n)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")     -- move line down(n)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)
local buffer_action = function(prompt, command)
	return function()
		vim.ui.input({ prompt = prompt }, function(input)
			vim.cmd(command .. input)
		end)
	end
end
vim.keymap.set("n", "<leader>bn", buffer_action("New buffer", ":edit "))
vim.keymap.set("n", "<leader>bv", buffer_action("Vsplit: ", ":vnew "))
vim.keymap.set("n", "<leader>bs", buffer_action("Hsplit: ", ":new "))
vim.keymap.set("n", "<leader>br", buffer_action("Rename: ", ":file "))

require("lazy").setup("plugins")
