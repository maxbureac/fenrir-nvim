vim.opt.laststatus = 2
vim.cmd('set noshowmode')

-- local function winbar()
--     return require('lspsaga.symbolwinbar'):get_winbar() or ''
-- end
--
require('lualine').setup({
    options = {
        theme = 'tokyonight',
        globalstatus = true;
        disabled_filetypes = {
            'dap-repl',
            'dapui_console',
            'dapui_scopes',
            'dapui_breakpoints',
            'dapui_stacks',
            'dapui_watches',
            'TelescopePrompt'
        },
    },
    sections = {
        lualine_b = {
            {'filename'},
            {'branch'},
        },
        lualine_c = {
            {'diff'},
            {"diagnostics", sources = {"nvim_lsp"}},
			'lsp_progress',
        },
    },
    winbar = {
        lualine_z = {
            {'filename', path = 1}
        },
    },
    extensions = {
        'quickfix',
        'man',
        'nvim-dap-ui',
    },
})
