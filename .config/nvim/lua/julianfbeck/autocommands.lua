-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"gitcommit", "markdown"},
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({"TextYankPost"}, {
    callback = function()
        vim.highlight.on_yank {
            higroup = "Visual",
            timeout = 200
        }
    end
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({"User"}, {
    pattern = {"AlphaReady"},
    callback = function()
        vim.cmd [[
		set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
		set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
	  ]]
    end
})

-- format on save commented out because it causes problems on non lsp buffers
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]

