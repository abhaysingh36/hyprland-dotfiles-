return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = 15,
			open_mapping = [[<leader>t]],
			direction = "horizontal", -- or "float" for a floating terminal
			shade_terminals = false, -- Disable shading to match tokyonight-night
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			close_on_exit = true,
			highlights = {
				Normal = {
					guibg = "#1a1b26", -- TokyoNight-Night background
					guifg = "#c0caf5", -- TokyoNight-Night foreground
				},
				NormalFloat = {
					guibg = "#1a1b26", -- Same background for floating terminals
				},
				FloatBorder = {
					guifg = "#7aa2f7", -- Blue from tokyonight-night for borders
				},
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)

			-- Autocommand to ensure terminal buffers are modifiable and use colorscheme
			vim.api.nvim_create_autocmd("TermOpen", {
				pattern = "*",
				callback = function()
					vim.opt_local.modifiable = true
					vim.cmd("highlight! link Normal Normal") -- Link terminal Normal to Neovim Normal
				end,
			})
		end,
	},
}
