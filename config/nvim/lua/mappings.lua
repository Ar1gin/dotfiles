vim.keymap.set("n", "<Down>", "g<Down>", { noremap = true })
vim.keymap.set("n", "<Up>", "g<Up>", { noremap = true })
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })

-- Buffer actions
vim.keymap.set("n", "<leader>br", function()
	vim.ui.input({ prompt = prompt }, function(input)
		if not input then
			return
		end
		vim.cmd(command .. input)
	end)
end)
vim.keymap.set("n", "<leader>bt", "<cmd>terminal<cr>")
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>")
vim.keymap.set("n", "<leader>bD", "<cmd>%bdelete<cr>")
-- Window actions
vim.keymap.set("n", "<leader>w<Left>", "<cmd>lefta vnew<cr>")
vim.keymap.set("n", "<leader>w<Down>", "<cmd>rightb new<cr>")
vim.keymap.set("n", "<leader>w<Up>", "<cmd>lefta new<cr>")
vim.keymap.set("n", "<leader>w<Right>", "<cmd>rightb vnew<cr>")
vim.keymap.set("n", "<leader>wd", "<cmd>quit<cr>")
vim.keymap.set("n", "<leader>w", "<C-w>")

vim.keymap.set("n", "<C-Left>", "<C-w><Left>", { noremap = true })
vim.keymap.set("n", "<C-Down>", "<C-w><Down>", { noremap = true })
vim.keymap.set("n", "<C-Up>", "<C-w><Up>", { noremap = true })
vim.keymap.set("n", "<C-Right>", "<C-w><Right>", { noremap = true })

-- Unify PaguUp/PageDown, H/L and ^u/^d
vim.keymap.set({ "n", "v" }, "<PageUp>", "<C-u>")
vim.keymap.set({ "n", "v" }, "H", "<C-u>")
vim.keymap.set({ "n", "v" }, "<PageDown>", "<C-d>")
vim.keymap.set({ "n", "v" }, "L", "<C-d>")

-- `s` shortcut is occupied by surround plugin
vim.keymap.set("n", "<C-s>", "s")
vim.keymap.set("v", "s", "<Nop>")

vim.keymap.set("i", "<C-f>", "<C-n>")

-- Tab actions
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>")
vim.keymap.set("n", "<leader>tN", "<cmd>-tabnew<cr>")
vim.keymap.set("n", "<leader>td", "<cmd>tabclose<cr>")
vim.keymap.set("n", "<leader>tD", "<cmd>tabonly<cr>")

vim.keymap.set("n", "<C-S-Left>", "<cmd>-tabmove<cr>")
vim.keymap.set("n", "<C-S-Right>", "<cmd>+tabmove<cr>")

vim.keymap.set("n", "<C-Right>", "<C-w><Right>", { noremap = true })
local keys = "12345"
for i = 1, #keys do
	local key = keys:sub(i, i)
	vim.keymap.set("n", "<leader>" .. key, "<cmd>tabn " .. key .. "<cr>")
end
