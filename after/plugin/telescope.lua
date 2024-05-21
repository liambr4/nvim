local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function() 
	builtin.grep_string ({ search = vim.fn.input("Grep > ")})
end)
local action = require('telescope.actions')
require('telescope').setup({
	extensions = { require("telescope.themes").get_dropdown {}
},
  defaults = {
	  mappings = {
		  i = {
			  ["<C-j>"] = action.move_selection_next,
			  ["<C-k>"] = action.move_selection_previous,
		    }
	  }
  },
})
local harpoonui = require("harpoon.ui")
local harpoon = require("harpoon.mark")
vim.keymap.set('n', '<leader>hpv', function() harpoonui.toggle_quick_menu() end)
vim.keymap.set('n', '<leader>hpa', function() harpoon.add_file() end)
vim.diagnostic.config({virtual_text = true})
