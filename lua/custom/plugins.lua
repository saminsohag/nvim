local plugins = {
  {
    "williamboman/mason.nvim",
    opts ={
      ensure_installed = {
        "pyright",
        "gopls",
        "rust-analyzer",
        "clangd",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
  },
  {
    'stevearc/conform.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function ()
      require "custom.configs.formmater"
    end
  },
  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    'simrat39/rust-tools.nvim',
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function (_,opts)
      require('rust-tools').setup(opts)
    end,
  },
}

return plugins
