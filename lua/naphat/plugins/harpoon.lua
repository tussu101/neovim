return {
	-- Harpoon plugin configuration
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		lazy = false,
		requires = { "nvim-lua/plenary.nvim" }, -- if harpoon requires this
		config = function()
			require("harpoon").setup({})

			local function toggle_telescope_with_harpoon(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = require("telescope.config").values.file_previewer({}),
						sorter = require("telescope.config").values.generic_sorter({}),
					})
					:find()
			end
			vim.keymap.set("n", "<leader>fh", function()
				local harpoon = require("harpoon")
				toggle_telescope_with_harpoon(harpoon:list())
			end, { desc = "Open harpoon window" })
		end,
		keys = {
			{
				"<leader>F",
				function()
					require("harpoon"):list():append()
				end,
				desc = "harpoon file",
			},
			{
				"<leader>f",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "harpoon quick menu",
			},
			{
				"<leader>1",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "harpoon to file 1",
			},
			{
				"<leader>2",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "harpoon to file 2",
			},
			{
				"<leader>3",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "harpoon to file 3",
			},
			{
				"<leader>4",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "harpoon to file 4",
			},
			{
				"<leader>5",
				function()
					require("harpoon"):list():select(5)
				end,
				desc = "harpoon to file 5",
			},
			{
				"<leader>6",
				function()
					require("harpoon"):list():select(6)
				end,
				desc = "harpoon to file 6",
			},
			{
				"<leader>7",
				function()
					require("harpoon"):list():select(7)
				end,
				desc = "harpoon to file 7",
			},
			{
				"<leader>8",
				function()
					require("harpoon"):list():select(8)
				end,
				desc = "harpoon to file 8",
			},
			{
				"<leader>9",
				function()
					require("harpoon"):list():select(9)
				end,
				desc = "harpoon to file 9",
			},
		},
	},
}
