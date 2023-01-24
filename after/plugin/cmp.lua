local path = require'plenary.path'

local snippet_search_path = path.new(vim.fn.stdpath('config'), 'luasnip')
local packer_root = path.new(vim.fn.stdpath('data'), 'site', 'pack', 'packer', 'start')

require("luasnip.loaders.from_lua").load({paths = snippet_search_path.filename})
require("luasnip.loaders.from_vscode").lazy_load({
    paths = { packer_root:joinpath("friendly-snippets").filename },
    include = nil, -- load all
    exclude = {},
})

local cmp = require'cmp'
local lspkind = require'lspkind'
local source_mapping = {
    buffer = '[Buffer]',
    nvim_lsp = '[LSP]',
    nvim_lua = '[Lua]',
    cmp_tabnine = '[TN]',
    path = '[Path]',
}

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.symbolic(vim_item.kind, {mode = "symbol"})
            vim_item.menu = source_mapping[entry.source.name]
            if entry.source.name == "cmp_tabnine" then
                local detail = (entry.completion_item.data or {}).detail
                vim_item.kind = ""
                if detail and detail:find('.*%%.*') then
                    vim_item.kind = vim_item.kind .. ' ' .. detail
                end

                if (entry.completion_item.data or {}).multiline then
                    vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
                end
            end

            local maxwidth = 80
            vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
            return vim_item
        end,
    },
    sources = cmp.config.sources(
    {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
    }, {
        { name = 'buffer' },
    })
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup("FenrirSqlComplete", { clear = true }),
    pattern = {'sql', 'mysql', 'plsql'},
    callback = function()
        cmp.setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
    end,
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})


cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        {name = 'cmdline', keyword_pattern = [[\!\@<!\w*]]},
    })
})
