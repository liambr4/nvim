local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function() 
	builtin.grep_string ({ search = vim.fn.input("Grep > ")})
end)
local action = require('telescope.actions')
require('telescope').setup({
  defaults = {
	  mappings = {
		  i = {
			  ["<C-j>"] = action.move_selection_next,
			  ["<C-k>"] = action.move_selection_previous,
		    }
	  }
  },
})


