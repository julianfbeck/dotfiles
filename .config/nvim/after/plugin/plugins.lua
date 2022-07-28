-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- run :PackerCompile
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
use 'wbthomason/packer.nvim'
use {'catppuccin/nvim', as = 'catppuccin'}

--Treesitter
use {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate'
}
--Markdown preview
use 'ellisonleao/glow.nvim'

--Language packs
use 'sheerun/vim-polyglot'

--Nvim motions
use 'phaazon/hop.nvim'

use 'terryma/vim-multiple-cursors'
--LSP autocomplete
use 'hrsh7th/nvim-cmp'
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-buffer'
use 'hrsh7th/cmp-path'
use 'L3MON4D3/LuaSnip'
use 'saadparwaiz1/cmp_luasnip'
use 'neovim/nvim-lspconfig'
use 'williamboman/nvim-lsp-installer'
use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
use {'onsails/lspkind.nvim'}
use {"github/copilot.vim"}

--File browsing
use 'nvim-telescope/telescope-file-browser.nvim'

--Buffer navigation
use 'nvim-lualine/lualine.nvim'

--Haskell
use 'neovimhaskell/haskell-vim'
use 'alx741/vim-hindent'

--debugging
use 'mfussenegger/nvim-dap'
use 'leoluz/nvim-dap-go'
use 'rcarriga/nvim-dap-ui'
use 'theHamsta/nvim-dap-virtual-text'
use 'nvim-telescope/telescope-dap.nvim'

--Grammar checking because I can't english
use 'rhysd/vim-grammarous'

--Telescope Requirements
use 'nvim-lua/popup.nvim'
use 'nvim-lua/plenary.nvim'
use 'nvim-telescope/telescope.nvim'

--Telescope
use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

--git diff
use 'sindrets/diffview.nvim'

--magit
use 'TimUntersberger/neogit'

--comments
use 'folke/todo-comments.nvim'
use {
  'numToStr/Comment.nvim',
  config = function()
      require('Comment').setup()
  end
}
-- vim surround
use 'tpope/vim-surround'

use 'windwp/nvim-autopairs'
--devicons
use 'kyazdani42/nvim-web-devicons'

-- harpoon 
use 'ThePrimeagen/harpoon'
--fullstack dev
use 'pangloss/vim-javascript' --JS support
use 'leafgarland/typescript-vim' --TS support
use 'maxmellon/vim-jsx-pretty' --JS and JSX syntax
use 'jparise/vim-graphql' --GraphQL syntax
use 'mattn/emmet-vim'


-- devOps tools
use 'https://github.com/rottencandy/vimkubectl'
end)

