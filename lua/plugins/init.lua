-- require("packer")
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
                                  install_path})
    print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({
                border = 'single'
            })
        end
    }
})

-- Install your plugins here
packer.startup(function(use)
    -- My plugins here
    use 'wbthomason/packer.nvim' -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

    use({
        'williamboman/mason.nvim',
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                },
                ensure_installed = {"jdtls"}
            })
        end
    })
    use({'williamboman/mason-lspconfig.nvim'})

    -- Autocompletion framework
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lua")
    use("cmp-nvim-lsp-signature-help")
    use("L3MON4D3/LuaSnip")

    use({
        -- cmp LSP completion
        "hrsh7th/cmp-nvim-lsp",
        -- cmp Snippet completion
        "hrsh7th/cmp-vsnip",
        -- cmp Path completion
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/vim-vsnip",
        after = {"hrsh7th/nvim-cmp"},
        requires = {"hrsh7th/nvim-cmp"}
    })
    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    })
    use({
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-ui-select.nvim'}}
    })
    use({'nvim-telescope/telescope-ui-select.nvim'})
    use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        before = {'nvim-telescope/telescope.nvim'}
    })

    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'anott03/nvim-lspinstall'
    use({
        'simrat39/rust-tools.nvim',
        requires = {'neovim/nvim-lspconfig', 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter'},
    })
    use ({"mfussenegger/nvim-jdtls"})
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use({
        'jay-babu/mason-nvim-dap.nvim',
        requires = {'mason.nvim'},
        cmd = {'DapInstall', 'DapUninstall'}
    })

    use({
        'nvim-neo-tree/neo-tree.nvim',
        requires = {'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim'}
    })

    use 'github/copilot.vim'
    use 'catppuccin/nvim'
    use ({
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        }
    })
    use ({
        "akinsho/toggleterm.nvim",
    })

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)

