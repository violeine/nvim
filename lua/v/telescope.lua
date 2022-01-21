local tele = require "telescope"
local builtin = require "telescope.builtin"

local map = vim.keymap.set
local opts = { silent = true }
local fb_actions = tele.extensions.file_browser.actions
local actions = require "telescope.actions"
local theme = require "telescope.themes"

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
  },
  extensions = {
    file_browser = {
      mappings = {
        ["i"] = {
          ["<C-r>"] = fb_actions.rename,
          ["<C-n>"] = fb_actions.create,
          ["<C-x>"] = fb_actions.move,
          ["<C-y>"] = fb_actions.copy,
          ["<C-d>"] = fb_actions.remove,
          ["<C-w>"] = fb_actions.goto_cwd,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      },
    },
  },
}

tele.load_extension "file_browser"

map("n", "<leader>ff", builtin.find_files, opts)
map("n", "<leader>fg", builtin.live_grep, opts)
map("n", "<leader>fb", builtin.buffers, opts)
map("n", "<leader>fe", tele.extensions.file_browser.file_browser, opts)
