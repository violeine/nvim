local cmd = vim.cmd

local options = {
  -- sanity
  fileencoding = "utf-8",
  clipboard = "unnamedplus",
  mouse = "a",
  swapfile = false,
  --UI
  number = true,
  relativenumber = true,
  laststatus = 2,
  backup = false,
  signcolumn = "yes",
  scrolloff = 5,
  cursorline = true,
  showmode = false,
  termguicolors = true,
  numberwidth = 2,
  --Responsive
  updatetime = 200,
  lazyredraw = true,
  timeoutlen = 300,
  ttimeout = true, --terminal
  ttimeoutlen = 10, --terminal
  -- search
  wildignorecase = true,
  ignorecase = true, -- ignore case when search
  smartcase = true, -- only search case
  incsearch = true,
  hlsearch = true,
  -- popup menu
  pumblend = 20,
  pumheight = 10,
  -- split
  splitbelow = true,
  splitright = true,
  -- indent :h tabstop option 2
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  -- wrap text
  linebreak = true,
  colorcolumn = { 80 },
  --completion
  completeopt = { "menuone", "noselect" },
  fillchars = {
    vert = "▕", -- alternatives │
    fold = " ",
    eob = " ", -- suppress ~ at EndOfBuffer
    diff = "╱", -- alternatives = ⣿ ░ ─
    msgsep = "‾",
    foldopen = "▾",
    foldsep = "│",
    foldclose = "▸",
  },
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append "c"

cmd [[set wildignore+="**/node_modules/**, **/.git/**"]]

cmd [[set path+=".,**]]

cmd [[filetype plugin indent on]] --enable filetype plugin and indent
cmd [[set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·]]
cmd [[
  augroup options
  autocmd!
  autocmd  BufWinEnter * set formatoptions-=cro
  autocmd VimResized * tabdo wincmd =
  autocmd BufWritePre * %s/\s\+$//e
  autocmd  BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
  augroup end
]]
