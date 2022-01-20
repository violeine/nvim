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
	numberwidth = 2,
	--Responsive
	updatetime = 200,
	lazyredraw = true,
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
	colorcolumn = {80},
  --completion
  completeopt = {"menuone", "noselect"}
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append "c"

cmd [[set wildignore+="**/node_modules/**, **/.git/**"]]

vim.opt.path:append ".,**"

cmd [[filetype plugin indent on]] --enable filetype plugin and indent
cmd [[set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·]]
cmd [[
  augroup options
  autocmd!
  autocmd  BufWinEnter * set formatoptions-=cro
  autocmd VimResized * tabdo wincmd =
  autocmd BufWritePre * %s/\s\+$//e
  augroup end
]]
