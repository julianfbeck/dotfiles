-- require cmp
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end


-- Native LSP Setup
-- Global setup.
local source_mapping = {
    nvim_lsp = "[LSP]",
    buffer = "[Buffer]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TN]",
    path = "[Path]"
}
-- load comments extension

-- used to show formatted icons
local lspkind = require("lspkind")
local lsp_kind_statuos, lspkind = pcall(require, "lspkind")
if not lsp_kind_statuos then
    return
end

cmp.setup({
    snippet = {
        expand = function(args)
            local snip_status_ok, luasnip = pcall(require, "luasnip")
            if not snip_status_ok then
                return
            end
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end
    },
    mapping = {
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({
            select = true
        })
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == "cmp_tabnine" then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. " " .. menu
                end
                vim_item.kind = ""
            end
            vim_item.menu = menu
            return vim_item
        end
    },
    sources = cmp.config.sources({{
        name = "nvim_lsp"
    }, {
        name = "cmp_tabnine"
    }, {
        name = "luasnip",
        max_item_count = 10
    }, {
        name = "buffer",
        max_item_count = 10

    }})
})

local tab_nine_status_ok, tabnine = pcall(require, "cmp_tabnine.config")
if not tab_nine_status_ok then
    return
end

tabnine:setup({
    max_lines = 1000,
    max_num_results = 7,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = ".."
})
