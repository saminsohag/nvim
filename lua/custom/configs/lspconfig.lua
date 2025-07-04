local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

lspconfig.clangd.setup {
  on_attach = function (client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client,bufnr)
  end,
  capabilities = capabilities
}

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
  root_directory = {},
  -- settings = {
  --   python = {
  --     pythonPath = "/opt/homebrew/bin/python3.11",
  --   },
  -- },
})

lspconfig.ts_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.eslint.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.gopls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = {"go","gomod","gowork","gotmpl"},
  root_dir = util.root_pattern("go.work","go.mod",".git"),
  settings={
    gopls ={
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      }
    }
  }
}

require("flutter-tools").setup {
  lsp = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  dev_log = {
    enabled = true,
    notify_errors = true,
    open_cmd = "tabnew", -- Open logs in a bottom split
      filter = function(log_line)
        return not (log_line:match("^D") or log_line:match("^I/MESA")) -- Exclude lines starting with "D"
      end,
  }
}
vim.api.nvim_set_keymap("n", "<leader>rr", ":FlutterReload<CR>",{noremap=true})
vim.api.nvim_set_keymap("n", "<leader>RR", ":FlutterRestart<CR>",{noremap=true})
