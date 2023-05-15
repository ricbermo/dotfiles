local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local mason_lsp = require "mason-lspconfig"
local lsp = require "lspconfig"

mason_lsp.setup_handlers {
  function(server_name)
    lsp[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
}
