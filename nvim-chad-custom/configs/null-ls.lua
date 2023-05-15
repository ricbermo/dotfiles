local null_ls = require "null-ls"

null_ls.setup {
  sources = {
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.ruff,
  },
  on_attach = function(client, bufnr)
    require("lsp-format").on_attach(client)
  end,
}
