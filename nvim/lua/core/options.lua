-- ~/.config/nvim/lua/core/options.lua
local opt = vim.opt

opt.number = true
opt.mouse = "a"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.cursorline = true
opt.scrolloff = 20

-- Schedule clipboard setting
vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)
