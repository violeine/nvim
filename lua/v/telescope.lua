local tele = require("telescope.builtin")

local map = vim.keymap.set
local opts={silent=true}

map("n", "<leader>ff", tele.find_files, opts)
map("n", "<leader>fg", tele.live_grep, opts)
map("n", "<leader>fb", tele.buffers, opts)

