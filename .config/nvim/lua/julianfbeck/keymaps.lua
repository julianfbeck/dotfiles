vim.g.mapleader = ' '
local keymap = function(tbl)
    -- Some sane default options
    local opts = {
        noremap = true,
        silent = true
    }
    -- Dont want these named fields on the options table
    local mode = tbl['mode']
    tbl['mode'] = nil
    local bufnr = tbl['bufnr']
    tbl['bufnr'] = nil

    for k, v in pairs(tbl) do
        if tonumber(k) == nil then
            opts[k] = v
        end
    end
    if bufnr ~= nil then
        vim.api.nvim_buf_set_keymap(bufnr, mode, tbl[1], tbl[2], opts)
    else
        vim.api.nvim_set_keymap(mode, tbl[1], tbl[2], opts)
    end
end

nmap = function(tbl)
    tbl['mode'] = 'n'
    keymap(tbl)
end

imap = function(tbl)
    tbl['mode'] = 'i'
    keymap(tbl)
end

-- NvimTree
nmap{"<leader>e", "<cmd>NvimTreeToggle<CR>", opts}


-- telescope shortcuts
nmap {"<leader>ff", "<cmd>Telescope find_files<CR>"}
nmap {"<leader>fg", "<cmd>Telescope live_grep<CR>"}
nmap {"<leader>fb", "<cmd>Telescope buffers<CR>"}
nmap {"<leader>fh", "<cmd>Telescope help_tags<CR>"}
nmap {"<leader>fb", "<cmd>Telescope file_browser<CR>"}
nmap {"<leader>fh", "<cmd>Telescope help_tags<CR>"}
nmap{"<leader>fp", "<cmd>Telescope projects<CR>"}



nmap {"<leader>bn", "<cmd>:bnext<CR>"}
nmap {"<leader>bp", "<cmd>:bprevious<CR>"}
nmap {"<leader>bf", "<cmd>:bfirst<CR>"}
nmap {"<leader>bl", "<cmd>:blast<CR>"}
nmap {"<leader>fn", "<cmd>Telescope find_files cwd=~/.config/nvim<cr>"}
nmap {"<leader>fd", "<cmd>Telescope find_files cwd=~/Development<cr>"}
nmap {"<leader>fw", "<cmd>Telescope find_files cwd=~/Development/work<cr>"}