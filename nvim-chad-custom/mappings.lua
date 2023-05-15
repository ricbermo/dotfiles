local M = {}

M.debugging = {
  n = {
    ["<leader>d"] = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "toggle breakpoint" },
    ["<leader>dc"] = { "<CMD>lua require('dap').continue()<CR>", "start/continue" },
  },
}

return M
