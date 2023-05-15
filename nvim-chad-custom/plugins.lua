local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "javascript",
        "ruby",
        "css",
        "html",
        "dart",
        "json",
        "typescript",
        "tsx",
        "lua",
        "vim",
        "markdown",
        "markdown_inline",
        "python",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
          "lukas-reineke/lsp-format.nvim",
        },
        config = function()
          require "custom.configs.null-ls"
        end,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua_ls",
            "tsserver",
            "jsonls",
            "ruff_lsp",
          },
          automatic_installation = true,
        },
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lsp"
    end,
  },
  {
    "karb94/neoscroll.nvim",
    keys = { "<C-u>", "<C-d>", "gg", "G" },
    config = true,
  },
  {
    "mfussenegger/nvim-dap",
    event = "BufReadPost",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      {
        "rcarriga/nvim-dap-ui",
        config = true,
      },
    },
    config = function()
      require "custom.configs.debugging"
    end,
  },
}
return plugins
