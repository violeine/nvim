local opts = { silent = true }
local expr_opts = {silent = true, expr = true}

local map=vim.keymap.set

vim.g.mapleader = " "

vim.g.maplocalleader = ","

-- turn off hlsearch until nextsearch
map("n", "<ESC><ESC>", ":nohlsearch<CR>",opts)

-- jump
map("n", "'", "`", opts) -- closer, better/jump to exact mark
map("n", "`", "'", opts)

-- better j/k with wrap
map("n", "k", function() return vim.v.count == 0 and "gk" or "k" end, expr_opts)
map("n", "j", function () return vim.v.count == 0 and "gj" or "j" end, expr_opts)

-- tabs switch to pair with vim unimpaired
map("n", "]w", "gt", opts)
map("n", "[w", "gT", opts)

map("n", "Q", "gq", opts) -- ez format

vim.cmd [[
  augroup keymap
  autocmd!
  autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
  autocmd CmdwinEnter * nnoremap <buffer> <esc><esc> :close<cr> 
]] --quit thing easily

--Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)





