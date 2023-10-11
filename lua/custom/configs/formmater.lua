
local conform = require("conform")

conform.setup({
  formatters_by_ft = {
      dart = { "dart_format" },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  }
})

