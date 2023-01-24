local null_ls = require'null-ls'

if not vim.fs.find('.prettierrc', { upward = true })[1] then
    return
end

local filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
}

local formatGroup = vim.api.nvim_create_augroup('FenrirTypescriptFormatOnSave', { clear = true })

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier.with({
            filetypes = filetypes,
        }),
    },
    on_attach = function(client, bufnr)
        local opts = { silent = true, buffer = bufnr }
        if client.server_capabilities.documentFormattingProvider then
            vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format { async = true } end, vim.tbl_extend('force', opts, { desc = 'LSP: Format file' }))
            -- vim.api.nvim_create_autocmd('BufWritePre', {
            --     group = formatGroup,
            --     buffer = bufnr,
            --     desc = 'Autoformats typescript files based on prettier',
            --     callback = function()
            --         vim.lsp.buf.format { async = true, bufnr = bufnr }
            --         vim.notify("done")
            --     end,
            -- })
        end

        if client.server_capabilities.documentRangeFormattingProvider then
            vim.keymap.set('x', "<leader>cf", function() vim.lsp.formatexpr()  end, vim.tbl_extend('force', opts, { desc = 'LSP: Format range' }))
        end
    end
})

require('nvim-ts-autotag').setup()

local prettier = require'prettier'
prettier.setup({
  bin = 'prettierd',
  filetypes = filetypes,
  ['null-ls'] = {
      condition = function()
          return prettier.config_exits({ check_package_json = true })
      end,
      runtime_condition = function() return false end,
  },
})
