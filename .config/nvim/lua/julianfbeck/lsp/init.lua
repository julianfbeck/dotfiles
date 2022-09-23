
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
    return
end



local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local custom_attach = function(client, bufnr)

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings.
    local opts = {
        noremap = true,
        silent = true
    }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- leaving only what I actually use...
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    buf_set_keymap("n", "ca", "<cmd>Telescope lsp_code_actions<CR>", opts)

    buf_set_keymap("n", "<C-j>", "<cmd>Telescope lsp_document_symbols<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
	buf_set_keymap( "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)


    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<CR>", opts)

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
        buffer = 0
    })
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {
        buffer = 0
    })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {
        buffer = 0
    })
    vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {
        buffer = 0
    })
    vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {
        buffer = 0
    })
    vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {
        buffer = 0
    })
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {
        buffer = 0
    })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
        buffer = 0
    })

    nmap {"C-f", "<cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending prompt_position=top<CR>"}
    nmap {"<leader>lg", "<cmd>Telescope live_grep<CR>"}

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
        vim.cmd([[
			augroup lsp_document_highlight
				autocmd! * <buffer>
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]])
    end

    if client.server_capabilities.document_formatting then
        vim.cmd([[
			augroup formatting
				autocmd! * <buffer>
				autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
				autocmd BufWritePre <buffer> lua OrganizeImports(1000)
			augroup END
		]])
    end

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

end
local servers = {
    gdscript = true,
    graphql = true,
    html = true,
    pyright = true,
    vimls = true,
    -- yaml extension
    -- currently enabeling kubernetes using https://github.com/neovim/nvim-lspconfig/issues/1207
    -- More info here: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
    yamlls = {
        settings = {
            yaml = {
                trace = {
                    server = "verbose"
                },
                schemas = {
                    kubernetes = "/*.yaml"
                },
                schemaDownload = {
                    enable = true
                },
                validate = true
            }
        }
    },
    eslint = true,
    sumneko_lua = true,
    svelte = true,
    elixirls = true,
    tsserver = {
        settings = {
            tsserver = {
                filetypes = {"typescript", "typescriptreact", "typescript.tsx"},
                cmd = {"typescript-language-server", "--stdio"},
				root_dir = lspconfig.util.root_pattern('.git');
            }
        }
    },
    tailwindcss = true,
    marksman = true,
    terraformls = true,
    tflint = true,
    gopls = {
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true
                },
                staticcheck = true
            }
        },
        flags = {
            debounce_text_changes = 150
        }

    },

    rust_analyzer = {
        settings = {
            rust_analyzer = {
                completion = {
                    enable_snippets = "true"
                },
                experimental_features = {"rust-analyzer-completion-tests", "rust-analyzer-completion-tests-tests"}
            }
        }
    }

}
local setup_server = function(server, config)
    if not config then
        return
    end

    if type(config) ~= "table" then
        config = {}
    end

    config = vim.tbl_deep_extend("force", {
        on_init = custom_init,
        on_attach = custom_attach,
        capabilities = updated_capabilities,
        flags = {
            debounce_text_changes = nil
        }
    }, config)

    lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
    setup_server(server, config)
end

-- organize imports
-- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-902680058
function OrganizeImports(timeoutms)
    local params = vim.lsp.util.make_range_params()
    params.context = {
        only = {"source.organizeImports"}
    }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end
end