local M = {}

-- Function to set up custom keymaps
function M.setup()
	-- Clear search highlights with <Esc> in normal mode
	vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

	-- Copy to system clipboard with <C-c> in visual mode
	vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true, silent = true })

	-- Exit terminal mode with <Esc><Esc>
	vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

	-- Select all with <C-a> in normal mode
	vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", { noremap = true, silent = true })

	-- Paste from system clipboard with <C-v> in normal mode
	vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })

	-- Toggle comments with <C-/> in visual mode (requires vim-commentary plugin)
	vim.api.nvim_set_keymap("v", "<C-/>", ":Commentary<CR>", { noremap = true, silent = true })

	-- Undo with <C-z> in normal mode
	vim.api.nvim_set_keymap("n", "<C-z>", "u", { noremap = true, silent = true })

	-- Run Python file with <F5> in normal mode
	vim.keymap.set("n", "<F5>", ":w<CR>:!python3 %<CR>", { noremap = true, silent = false })
	vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show float diagnostics" })
	vim.keymap.set("i", "<A-a>", "b", { noremap = true })
	vim.keymap.set("i", "<A-w>", "n", { noremap = true })
end

return M
