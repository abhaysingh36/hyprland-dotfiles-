vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false
vim.opt.number = true
vim.opt.mouse = "a"
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.cursorline = true
vim.opt.scrolloff = 20

require("functions.autocommands").setup_yank_highlight()
require("functions.keymaps").setup()
-- Ensure lazy.nvim is installed and set up
require("setup_lazy").ensure_lazy()

-- Load icons and set up lazy.nvim
local icons = require("icons")
require("lazy").setup({
	{ import = "plugins" },
}, {
	ui = icons,
})
