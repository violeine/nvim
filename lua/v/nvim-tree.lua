require("nvim-tree").setup {
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "right",
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {},
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes",
  },
}

local map = vim.keymap.set
local opts = { silent = true }

map("n", "<C-n>", "<cmd> NvimTreeToggle<CR>", opts)
