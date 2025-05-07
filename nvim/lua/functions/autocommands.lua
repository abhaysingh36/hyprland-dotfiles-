-- lua/functions/autocommands.lua
local M = {}

-- Function to set up the TextYankPost autocommand for highlighting yanks
function M.setup_yank_highlight()
	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Highlight when yanking (copying) text",
		group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
		callback = function()
			vim.highlight.on_yank()
		end,
	})
end

return M
