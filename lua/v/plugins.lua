local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({"git",
  "clone",
  "--depth",
  "1",
  "https://github.com/wbthomason/packer.nvim",
  install_path})
end

-- Auto reload when added things to this file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

return require("packer").startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used in lots of plugins
  use "nvim-lua/popup.nvim" --Popup API

  -- Editing
  use {
    "tpope/vim-surround",
    "windwp/nvim-autopairs", -- auto pairs
    {
      "mattn/emmet-vim",
      config = function ()
        vim.g.user_emmet_leader_key="<C-s>"
      end
    },
    "windwp/nvim-ts-autotag",
   {
    "numToStr/Comment.nvim",
    config = function ()
      require('v.comment')
    end
  },
  "JoosepAlviste/nvim-ts-context-commentstring"
  }
  -- scheme
  use {
    "rose-pine/neovim",
    as = "rose-pine",
    config = function()
        vim.cmd "colorscheme rose-pine"
    end
  }
  -- UX enhance
  use {
    "tpope/vim-unimpaired",
  }
  -- completion and snippet
  use {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    --snippet
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    "williamboman/nvim-lsp-installer",
    "b0o/SchemaStore.nvim", --JSON schema for jsonls
    {"jose-elias-alvarez/null-ls.nvim",
      config = function() require "v.lsp.null-ls" end
    } --linting and formatting
  }

  -- Telescope
  use {
    {
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/plenary.nvim"
  },
  "nvim-telescope/telescope-file-browser.nvim"
  }

  -- Treesitter
  use {
    { "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    },
    "nvim-treesitter/playground"
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function ()
        require "v.gitsigns"
      end
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)

