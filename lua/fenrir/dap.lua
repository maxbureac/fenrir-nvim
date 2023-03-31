local dap = require('dap')
local dapui = require('dapui')
local daptext = require('nvim-dap-virtual-text')

local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

daptext.setup({})
dapui.setup()

dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end

dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end

dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end

-- nnoremap('<leader><leader>', dap.close, 'DEBUG: Close debugger')

vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DEBUG: Continue debugging' })
vim.keymap.set('n', '<F6>', function()
    dap.close()
    dapui.close()
end, { desc = 'DEBUG: Close debugger' })
vim.keymap.set('n', '<F7>', dap.step_over, { desc = 'DEBUG: Step over' })
vim.keymap.set('n', '<F8>', dap.step_into, { desc = 'DEBUG: Step into' })
vim.keymap.set('n', '<F9>', dap.step_out, { desc = 'DEBUG: Step out' })

-- nnoremap('<leader>dbc', dap.continue, 'DEBUG: Continue debugging')
-- nnoremap('<leader>dbs', dap.step_over, 'DEBUG: Step over')
-- nnoremap('<leader>dbi', dap.step_into, 'DEBUG: Step into')
-- nnoremap('<leader>dbo', dap.step_out, 'DEBUG: Step out')

vim.keymap.set('n', '<leader>dbb', dap.toggle_breakpoint, { desc = 'DEBUG: Toggle breakpoint' })
vim.keymap.set('n', '<leader>dbB', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'DEBUG: Set breakpoint with condition' })
vim.keymap.set('n', '<leader>dbr', dap.repl.open, { desc = 'DEBUG: Open repl' })
vim.keymap.set('n', '<leader>dbe', function() dap.repl.eval() end, { desc = 'DEBUG: evaluate under cursor' })
vim.keymap.set('v', '<leader>dbe', function() dap.repl.eval() end, { desc = 'DEBUG: evaluate selected' })

vim.api.nvim_create_user_command('RunDebugger', function() dap.run() end, {})
require('dap.ext.vscode').load_launchjs()
-- nnoremap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
-- nnoremap('gd', vim.lsp.buf.definition, bufopts, "Go to definition")
-- nnoremap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
-- nnoremap('K', vim.lsp.buf.hover, bufopts, "Hover text")
