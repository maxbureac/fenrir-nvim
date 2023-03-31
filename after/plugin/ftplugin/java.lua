-- local home = os.getenv('HOME')
local jdtls = require('jdtls')
local path = require('plenary.path')

local is_unix = vim.fn.has('unix') == 1

local is_win = vim.fn.has('win32') == 1
local SYSTEM = 'mac'
if is_unix then
  SYSTEM = 'linux'
end
if is_win then
  SYSTEM = 'win32'
end
-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.

-- local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local JDTLS_LOCATION = path.new(vim.fn.stdpath('data'), 'mason', 'packages', 'jdtls').filename
local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == '' then
  return
end

local PROJECT_NAME = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h')
local workspace_dir = path.new(PROJECT_NAME, '.java-workspace').filename

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local bundles = {
  vim.fn.glob(path.new(vim.fn.stdpath("config"), "thirdparty", "java-debug", "com.microsoft.java.debug.plugin", "target"
    , "com.microsoft.java.debug.plugin-*.jar").filename, 1)
}

vim.list_extend(bundles,
  vim.split(vim.fn.glob(path.new(vim.fn.stdpath("config"), "thirdparty", "vscode-java-test", "server", "*.jar").filename
    , 1), "\n"))

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    JDTLS_LOCATION .. "/config_" .. SYSTEM,
    "-data",
    workspace_dir,
  },

  on_attach = function(client, bufnr)
    jdtls.setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()
    vim.lsp.codelens.refresh()
    -- Regular Neovim LSP client keymappings
    vim.keymap.set("n", '<C-k>', vim.lsp.buf.signature_help,
      { noremap = true, silent = true, buffer = bufnr, desc = "GENERAL: Show signature" })
    vim.keymap.set("n", '<leader>wa', vim.lsp.buf.add_workspace_folder,
      { noremap = true, silent = true, buffer = bufnr, desc = "GENERAL: Add workspace folder" })
    vim.keymap.set("n", '<leader>wr', vim.lsp.buf.remove_workspace_folder,
      { noremap = true, silent = true, buffer = bufnr, desc = "GENERAL: Remove workspace folder" })
    vim.keymap.set("n", '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { noremap = true, silent = true, buffer = bufnr, desc = "GENERAL: List workspace folders" })
    vim.keymap.set("n", '<leader>rn', vim.lsp.buf.rename,
      { noremap = true, silent = true, buffer = bufnr, desc = "REFACTOR: Rename" })
    vim.keymap.set("n", '<leader>ca', vim.lsp.buf.code_action,
      { noremap = true, silent = true, buffer = bufnr, desc = "REFACTOR: Code actions" })
    vim.keymap.set('v', "<leader>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
      { noremap = true, silent = true, buffer = bufnr, desc = "REFACTOR: Code actions" })
    vim.keymap.set("n", '<leader>f', function() vim.lsp.buf.format { async = true } end,
      { noremap = true, silent = true, buffer = bufnr, desc = "REFACTOR: Format file" })

    -- Java extensions provided by jdtls
    vim.keymap.set("n", "<C-o>", jdtls.organize_imports,
      { noremap = true, silent = true, buffer = bufnr, desc = "Organize imports" })
    vim.keymap.set("n", "<leader>ev", jdtls.extract_variable,
      { noremap = true, silent = true, buffer = bufnr, desc = "REFACTOR: Extract variable" })
    vim.keymap.set("n", "<leader>ec", jdtls.extract_constant,
      { noremap = true, silent = true, buffer = bufnr, desc = "REFACTOR: Extract constant" })
    vim.keymap.set('v', "<leader>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
      { noremap = true, silent = true, buffer = bufnr, desc = "REFACTOR: Extract method" })

    require("lsp-zero").on_attach(client, bufnr)
  end,
  capabilities = require("lsp-zero").capabilities,
  root_dir = root_dir,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
        settings = {
          url = path.new(vim.fn.stdpath("config"), "thirdparty", "eclipse-java-google-style.xml").filename,
          profile = "GoogleStyle",
        },
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = bundles,
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)

-- The on_attach function is used to set key maps after the language server
-- attaches to the current buffer
vim.keymap.set("n", "<leader>vc", jdtls.test_class, { silent = true, noremap = true, desc = "DEBUG: Test class (DAP)" })
vim.keymap.set("n", "<leader>vm", jdtls.test_nearest_method,
  { silent = true, noremap = true, desc = "DEBUG: Test method (DAP)" })
vim.keymap.set("n", "<C-S-Right>", "<cmd>:vertical resize -1<cr>", { desc = "RESIZE: Minimize window" })
vim.keymap.set("n", "<C-S-Left>", "<cmd>:vertical resize +1<cr>", { desc = "RESIZE: Maximize window" })

-- Finally, start jdtls. This will run the language server using the configuration we specified,
-- setup the keymappings, and attach the LSP client to the current buffer
vim.api.nvim_create_user_command("JavaRunTestClass", function() jdtls.test_class() end, {})
vim.api.nvim_create_user_command("JavaRunTestMethod", function() jdtls.test_nearest_method() end, {})
vim.api.nvim_create_user_command("JavaRunTestPick", function() jdtls.pick_test() end, {})
