local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local action_state = require('telescope.actions.state') -- runtime (Plugin) exists somewhere as lua/telescope/actions/state.lua
local actions = require "telescope.actions"

telescope.setup {
    defaults = {
        prompt_prefix = "$ ",
        mappings = {
            i = {
                ["<c-a>"] = function()
                    print(vim.inspect(action_state.get_selected_entry()))
                end,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous

            }
        },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            }
        },
        vimgrep_arguments = {"rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column",
                             "--smart-case", "--hidden", "--glob=!.git/"}
    }
}
telescope.load_extension('fzf')
telescope.load_extension('file_browser')
