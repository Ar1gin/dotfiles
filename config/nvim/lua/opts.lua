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
vim.opt.scrolloff = 5
vim.opt.pumheight = 7
vim.opt.completeopt = "menu,menuone,popup,fuzzy"
vim.opt.complete = "."
vim.opt.colorcolumn = "101"
vim.diagnostic.config({
	virtual_text = false,
	underline = false,
	signs = true,
	update_in_insert = false,
})

-- FTPlugin, begone
-- vim.cmd("autocmd BufReadPre,BufNewFile * let b:did_ftplugin = 1")
vim.cmd("filetype plugin off")
vim.cmd("filetype indent off")
