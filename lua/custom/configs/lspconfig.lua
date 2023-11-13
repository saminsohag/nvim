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
  settings = {
    python = {
      pythonPath = "/opt/homebrew/bin/python3.11",
    },
  },
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

