return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
		},
		opts = {
			disable_netrw = true,
			hijack_netrw = true,
			filters = {
				dotfiles = true,
				exclude = { ".cconfig" }, -- Show .cconfig files
			},
			view = {
				width = 50,
				side = "right",
			},
			live_filter = {
				always_show_folders = false,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				local lib = require("nvim-tree.lib")
				local view = require("nvim-tree.view")
				local core = require("nvim-tree.core")
				local utils = require("nvim-tree.utils")

				local function opts(desc)
					return {
						desc = "nvim-tree: " .. desc,
						buffer = bufnr,
						noremap = true,
						silent = true,
						nowait = true,
					}
				end

				-- Function to check if a node or its children match the query
				local function node_or_children_match(node, query)
					local node_name = node.name:lower()
					if node_name:find(query:lower()) then
						return true
					end
					if node.nodes then -- If it's a folder, check its children
						for _, child in ipairs(node.nodes) do
							if child.name:lower():find(query:lower()) then
								return true
							end
						end
					end
					return false
				end

				-- Custom live filter implementation
				local function custom_live_filter()
					local query = vim.fn.input("[CUSTOM FILTER]: ")
					if query == "" then
						api.tree.reload()
						return
					end

					-- Get the current tree nodes
					local tree = core.get_explorer()
					if not tree then
						return
					end

					-- Traverse all nodes and filter based on query
					local function filter_nodes(nodes)
						local filtered = {}
						for _, node in ipairs(nodes) do
							if node_or_children_match(node, query) then
								-- If the node matches or has matching children, keep it
								table.insert(filtered, node)
								if node.nodes then
									node.nodes = filter_nodes(node.nodes) -- Recursively filter children
								end
							end
						end
						return filtered
					end

					-- Apply the filter
					tree.nodes = filter_nodes(tree.nodes)
					api.tree.reload()
				end

				-- Existing mappings
				vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
				vim.keymap.set("n", "<C-e>", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "a", api.fs.create, opts("Create"))
				vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
				vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
				vim.keymap.set("n", "t", api.tree.focus, opts("Focus Tree"))
				vim.keymap.set("n", "e", "<C-w>h", opts("Focus Left Window (Editor)"))

				-- Use custom live filter
				vim.keymap.set("n", "/", function()
					api.tree.collapse_all(true)
					custom_live_filter()
				end, opts("Start Custom Live Filter"))

				vim.keymap.set("n", "?", function()
					api.tree.reload() -- Clear filter by reloading the tree
				end, opts("Clear Live Filter"))

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
