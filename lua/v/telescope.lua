local tele = require "telescope"
local builtin = require "telescope.builtin"

local map = vim.keymap.set
local opts = { silent = true }
local actions = require "telescope.actions"

tele.setup {
  defaults = {
    mappings = {
      ["n"] = {
        ["<esc><esc>"] = actions.close,
      },
      ["i"] = {
        ["<esc><esc>"] = actions.close,
      },
    },
  },
  pickers = {
    lsp_code_actions = {
      theme = "cursor",
    },
    find_files = {
      hidden = "true",
    },
  },
  extensions = {},
}

tele.load_extension "file_browser"

map("n", "<leader>ff", builtin.find_files, opts)
map("n", "<leader>fg", builtin.live_grep, opts)
map("n", "<leader>fb", builtin.buffers, opts)
map("n", "<leader>fe", tele.extensions.file_browser.file_browser, opts)
