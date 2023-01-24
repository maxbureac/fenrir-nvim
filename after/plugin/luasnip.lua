local ls = require('luasnip')
local types = require('luasnip.util.types')
ls.setup({})

ls.config.set_config {
    -- You can jump back to previous expanded snippet
    history = true,

    -- update on text changed
    updateevents = 'TextChanged,TextChangedI',

    -- enables autosnippets
    enable_autosnippets = true,

    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { " « ", "Error" } },
            },
        },
    },
}

-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
local function jump()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end
vim.keymap.set({ 'i', 's' }, '<c-k>', jump, { silent = true }, { desc = 'SNIPPET: jump to next' })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
local function jump_back()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end
vim.keymap.set({ 'i', 's' }, '<c-j>', jump_back, { silent = true }, { desc = 'SNIPPET: jump to prev' })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
local function change_choice()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end
vim.keymap.set('i', '<c-l>', change_choice, { desc = 'SNIPPET: change choice' })
