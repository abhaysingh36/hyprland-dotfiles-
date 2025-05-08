return {
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			icons = {
				mappings = vim.g.have_nerd_font,
				keys = vim.g.have_nerd_font and {} or {
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-",
					M = "<M-",
					D = "<D-",
					S = "<S-",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},
			-- Document existing key chains
			spec = {
				{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
				{ "<leader>d", group = "[D]ocument", mode = "n" },
				{ "<leader>r", group = "[R]ename", mode = "n" },
				{ "<leader>s", group = "[S]earch", mode = "n" },
				{ "<leader>w", group = "[W]orkspace", mode = "n" },
				{ "<leader>t", group = "[T]oggle", mode = "n" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
				{ "<leader>f", group = "[F]ind", mode = "n" }, -- Added group for Find
				{ "<leader>k", group = "[K]eys", mode = "n" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			-- Register additional mappings not covered by spec
		end,
	},
}
