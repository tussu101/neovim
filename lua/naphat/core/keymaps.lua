-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps --
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("n", "<leader>o", "<cmd>tabo<CR>", { desc = "Switch to other tab" }) -- switch to other tab
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save current file" }) -- save current file
keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit current buffer" }) -- quit current buffer
keymap.set("n", "<leader>Q", "<cmd>q!<CR>", { desc = "Force quit current buffer" }) -- force quit current buffer
keymap.set("n", "<leader>x", "<cmd>wq<CR>", { desc = "Save and quit current buffer" }) -- save and quit current buffer
keymap.set("n", "<leader>wa", "<cmd>wa<CR>", { desc = "Write all changes" }) -- write all changes
keymap.set("n", "<leader>qa", "<cmd>qa<CR>", { desc = "Quit all buffers" }) -- quit all buffers

keymap.set("n", "<leader>cn", ":%s/", { desc = "%s/oldName/newName/g" })
