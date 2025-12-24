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

vim.opt.autoread = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.softtabstop = 0
vim.opt.preserveindent = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.sidescrolloff = 16
vim.opt.list = true
vim.opt.listchars = {
	tab = "┆  ",
	leadmultispace = "│   ",
	multispace = "·",
	extends = "»",
	precedes = "«",
	trail = "─",
}
vim.opt.signcolumn = "yes"
vim.opt.hlsearch = false
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.shortmess = "aoOstTWIcC"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.undofile = true
vim.opt.fillchars = { eob = " " }
vim.opt.virtualedit = "all"
vim.opt.timeout = false
vim.opt.showmode = false
vim.opt.pumheight = 7
vim.diagnostic.config({ virtual_text = false, underline = false, signs = false })

-- FTPlugin, begone
vim.cmd("autocmd BufReadPre,BufNewFile * let b:did_ftplugin = 1")
vim.cmd("filetype plugin off")

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

vim.keymap.set({ "n", "v" }, "<PageUp>", "<C-u>")
vim.keymap.set({ "n", "v" }, "H", "<C-u>")
vim.keymap.set({ "n", "v" }, "<PageDown>", "<C-d>")
vim.keymap.set({ "n", "v" }, "L", "<C-d>")

-- `s` shortcut is occupied by surround plugin
vim.keymap.set("n", "<C-s>", "s")
vim.keymap.set("v", "s", "<Nop>")

vim.keymap.set("i", "<C-f>", "<C-n>")

if vim.g.neovide then
	require("neovide")
end

require("lazy").setup("plugins")

vim.fn.digraph_setlist(require("digraphs"))

require("marks")
