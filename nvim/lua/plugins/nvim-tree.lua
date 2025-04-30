return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- Optional: for file icons
			"nvim-lua/plenary.nvim", -- Required by Telescope
			"nvim-telescope/telescope.nvim", -- Fuzzy finder
		},
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
		},
		opts = {
			disable_netrw = true,
			hijack_netrw = true,
			filters = {
				dotfiles = false,
			},
			view = {
				width = 50,
				side = "right",
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				local function opts(desc)
					return {
						desc = "nvim-tree: " .. desc,
						buffer = bufnr,
						noremap = true,
						silent = true,
						nowait = true,
					}
				end

				-- Default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- Custom focus mappings
				vim.keymap.set("n", "t", api.tree.focus, opts("Focus Tree"))
				vim.keymap.set("n", "e", "<C-w>h", opts("Focus Left Window (Editor)"))

				-- 🔍 Live filter inside tree
				vim.keymap.set("n", "/", api.live_filter.start, opts("Start Live Filter"))
				vim.keymap.set("n", "?", api.live_filter.clear, opts("Clear Live Filter"))

				-- 🔎 Fuzzy find using Telescope (includes folders!)
				vim.keymap.set("n", "<leader>f", function()
					local node = api.tree.get_node_under_cursor()
					local path = node and node.absolute_path or vim.fn.getcwd()

					require("telescope.builtin").find_files({
						cwd = path,
						prompt_title = "Find Files and Folders",
						find_command = { "fd", "--type", "f", "--type", "d", "--hidden", "--follow" },
					})
				end, opts("Telescope: Find Files and Folders"))
			end,
		},
		config = function(_, opts)
			require("nvim-tree").setup(opts)

			-- Autocommand to increase font size for NvimTree (for GUI clients)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "NvimTree",
				callback = function()
					if vim.g.neovide then
						vim.g.neovide_font_size = 18
					else
						vim.o.guifont = "FiraCode Nerd Font:h14"
					end
				end,
			})
		end,
	},
}
