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
			disable_netrw = false,
			hijack_netrw = true,
			filters = {
				dotfiles = true,
			},
			view = {
				width = 50,
				side = "right",
			},
			live_filter = {
				always_show_folders = false, -- Allow folders to be filtered
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

				-- Minimal mappings to avoid conflicts
				vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
				vim.keymap.set("n", "<C-e>", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "a", api.fs.create, opts("Create"))
				vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
				vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))

				-- Custom focus mappings
				vim.keymap.set("n", "t", api.tree.focus, opts("Focus Tree"))
				vim.keymap.set("n", "e", "<C-w>h", opts("Focus Left Window (Editor)"))

				-- Live filter mappings
				vim.keymap.set("n", "/", api.live_filter.start, opts("Start Live Filter"))
				vim.keymap.set("n", "?", api.live_filter.clear, opts("Clear Live Filter"))

				-- Telescope fuzzy find
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
