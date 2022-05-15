
-- -- Aesthetic
-- local catppuccin = require("catppuccin")
-- catppuccin.setup {}
-- vim.cmd[[colorscheme catppuccin]]
-- require'nvim-treesitter.configs'.setup { ensure_installed = "all", ignore_install = {"phpdoc"}, highlight = { enable = true } }
-- -- Plugins
-- -- Set up Telescope

-- require('telescope').setup{
--      defaults  = {
--      };
--      file_browser = {
--     },
-- }

-- require('telescope').load_extension('fzf')
-- require("telescope").load_extension ('file_browser')

-- -- Use an on_attach function to only map the following keys
-- -- after the language server attaches to the current buffer

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

--  -- ensure_installed = { "rust_analyzer", "sumneko_lua" }, -- ensure these servers are always installed
-- local lsp_installer = require("nvim-lsp-installer")
-- lsp_installer.settings({
--     ui = {
--         icons = {
--             server_installed = "✓",
--             server_pending = "➜",
--             server_uninstalled = "✗"
--         }
--     }
-- })

-- -- Test setup
-- local on_attach = function(client, bufnr)

-- 	local function buf_set_keymap(...)
-- 		vim.api.nvim_buf_set_keymap(bufnr, ...)
-- 	end

-- 	-- Mappings.
-- 	local opts = { noremap = true, silent = true }

-- 	-- See `:help vim.lsp.*` for documentation on any of the below functions
-- 	-- leaving only what I actually use...
-- 	-- n stands for NormalMode
-- 	buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
-- 	buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

-- 	buf_set_keymap("n", "<C-j>", "<cmd>Telescope lsp_document_symbols<CR>", opts)
-- 	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)


-- 	-- not working currently 
-- 	buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
-- 	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)

-- 	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- 	buf_set_keymap("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)
-- 	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
-- 	buf_set_keymap("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<CR>", opts)
-- 	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
-- 	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
-- 	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
-- 	vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
-- 	vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
-- 	vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer=0})
-- 	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
-- 	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer=0})
-- 	-- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
-- 	-- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- 	-- buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- 	-- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- 	-- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- 	-- buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- 	-- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- 	-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- 	-- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- 	-- buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
-- 	-- buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- 	-- buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
-- 	-- buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

-- 	if client.resolved_capabilities.document_formatting then
-- 		vim.cmd([[
-- 			augroup formatting
-- 				autocmd! * <buffer>
-- 				autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
-- 				autocmd BufWritePre <buffer> lua OrganizeImports(1000)
-- 			augroup END
-- 		]])
-- 	end

-- 	-- Set autocommands conditional on server_capabilities
-- 	if client.resolved_capabilities.document_highlight then
-- 		vim.cmd([[
-- 			augroup lsp_document_highlight
-- 				autocmd! * <buffer>
-- 				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
-- 				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
-- 			augroup END
-- 		]])
-- 	end
-- end

-- local lua_opts = {}

-- lua_opts["gopls"] = {
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	settings = {
-- 		gopls = {
-- 			gofumpt = true,
-- 		},
-- 	},
-- 	flags = {
-- 		debounce_text_changes = 150,
-- 	},
-- }

-- lsp_installer.on_server_ready(function(server)
--   server:setup(lua_opts[server.name] or {})
-- end)

-- -- organize imports
-- -- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-902680058
-- function OrganizeImports(timeoutms)
-- 	local params = vim.lsp.util.make_range_params()
-- 	params.context = { only = { "source.organizeImports" } }
-- 	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
-- 	for _, res in pairs(result or {}) do
-- 		for _, r in pairs(res.result or {}) do
-- 			if r.edit then
-- 				vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
-- 			else
-- 				vim.lsp.buf.execute_command(r.command)
-- 			end
-- 		end
-- 	end
-- end
-- -- Setup nvim-cmp.
-- local cmp = require("cmp")
-- local source_mapping = {
-- 	buffer = "[Buffer]",
-- 	nvim_lsp = "[LSP]",
-- 	nvim_lua = "[Lua]",
-- 	cmp_tabnine = "[TN]",
-- 	path = "[Path]",


-- }
-- local lspkind = require("lspkind")

-- cmp.setup({
-- 	snippet = {
-- 	  expand = function(args)
-- 		require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
-- 	end,
-- },
-- 	mapping = {
-- 		["<Enter>"] = cmp.mapping.confirm({ select = true }),
-- 		['<C-k>'] = cmp.mapping.select_prev_item(),
-- 		['<C-j>'] = cmp.mapping.select_next_item(),
-- 		["<C-u>"] = cmp.mapping.scroll_docs(-4),
-- 		["<C-d>"] = cmp.mapping.scroll_docs(4),
-- 		["<C-Space>"] = cmp.mapping.complete(),

-- 	},

-- 	formatting = {
-- 		format = function(entry, vim_item)
-- 			vim_item.kind = lspkind.presets.default[vim_item.kind]
-- 			local menu = source_mapping[entry.source.name]
-- 			if entry.source.name == "cmp_tabnine" then
-- 				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
-- 					menu = entry.completion_item.data.detail .. " " .. menu
-- 				end
-- 				vim_item.kind = ""
-- 			end
-- 			vim_item.menu = menu
-- 			return vim_item
-- 		end,
-- 	},
-- 	experimental = {
--     -- I like the new menu better! Nice work hrsh7th
--     native_menu = false,

--     -- Let's play with this for a day or two
--     ghost_text = false,
--   },

-- 	sources = {
-- 		-- tabnine completion? yayaya

-- 		{ name = "cmp_tabnine" },

-- 		{ name = "nvim_lsp" },

-- 		 { name = "luasnip" },

-- 		{ name = "buffer" },
-- 	},
-- })

-- local tabnine = require("cmp_tabnine.config")
-- tabnine:setup({
-- 	max_lines = 1000,
-- 	max_num_results = 20,
-- 	sort = true,
-- 	run_on_every_keystroke = true,
-- 	snippet_placeholder = "..",
-- })
