-- autocompile packer stuff
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)

    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim"}

    -- LSP
    use {
        "neovim/nvim-lspconfig",
        requires = {
            "nvim-treesitter/nvim-treesitter", -- optional
            "nvim-tree/nvim-web-devicons"     -- optional
        },
        config = function()
            require("plugins.lsp-config")
        end,
    }
    use {"glepnir/lspsaga.nvim"}

    -- Telescope
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {
	    "nvim-telescope/telescope.nvim",
        requires = { {"nvim-lua/plenary.nvim"} },
        config = function()
            require("plugins.telescope-config")
        end,
	}
    -- Use project for telescope
    use {
        "nvim-telescope/telescope-project.nvim",
        -- event = "BufRead",
        -- after = "telescope.nvim",
    }

    -- Statusline
    use {
        "nvim-lualine/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
        config = function()
            require("plugins.lualine-config")
        end,
    }

    -- Lua
    use {
        "folke/which-key.nvim",
        tag = 'v2.0.0',
        config = function()
            require("plugins.which-key-config")
        end,
	}

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("plugins.treesitter-config")
        end
    }

    -- Git
    use {
        "lewis6991/gitsigns.nvim",
        requires = {
          "nvim-lua/plenary.nvim"
        },
        tag = "release", -- To use the latest release
        config = function()
            require("plugins.gitsigns-config")
        end,
    }

    -- Git blame
    use {
        "f-person/git-blame.nvim",
        disable = true
    }

    -- Lazy git
    use "kdheepak/lazygit.nvim"

    -- Autocomplete
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp"
        },
        config = function()
            require("plugins.nvim-compe-config")
        end,
    }

    -- Vimwiki
    use {
        "vimwiki/vimwiki",
        config = function()
            require("plugins.vimwiki-config")
        end
    }

    -- Dev
    use {
        "windwp/nvim-autopairs",
        config = function()
            require("plugins.nvim-autopairs-config")
        end,
    }

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons"
    }

    use {"kevinhwang91/nvim-bqf", ft = "qf"}
    use {"junegunn/fzf", run = function()
            vim.fn["fzf#install"]()
        end
    }

    -- Markdown preview
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        ft = {"markdown", "vimwiki"},
    }

    -- To be deprecated after https://github.com/neovim/neovim/pull/19243 release
    -- To stabilize splits location
    use {"luukvbaal/stabilize.nvim"}

    -- View and search LSP symbols
    use {"liuchengxu/vista.vim"}

    use {
        "mfussenegger/nvim-dap",
        config = function()
            require("plugins.dap-config")
        end,
    }

    -- Light colorscheme
    use "rafamadriz/neon"

    -- Light colorscheme
    use "NLKNguyen/papercolor-theme"

    -- CellularAutomaton
    use "Eandrju/cellular-automaton.nvim"

    use "tpope/vim-surround"

    -- Notification manager
    use "rcarriga/nvim-notify"

    use "MunifTanjim/nui.nvim"
    use {
      "folke/zen-mode.nvim",
      config = function()
            require("plugins.zen-mode")
      end
    }

    use "linux-cultist/venv-selector.nvim"

    -- Colorschemes
    use {
        "rebelot/kanagawa.nvim",
        config = function()
            require("plugins.kanagawa")
        end
    }

    use {
        "catppuccin/nvim",
        config = function()
            require("plugins.catppuccin")
        end
    }

    use {"hat0uma/csvview.nvim"}
    use {"junegunn/fzf.vim"}
    use {
        "coder/claudecode.nvim",
         requires = { "folke/snacks.nvim" },
         config = function()
             require("plugins.claudecode")
        end
    }
    use {
        'LukasPietzschmann/telescope-tabs',
        requires = { 'nvim-telescope/telescope.nvim' },
        config = function()
            require("plugins.telescope-tabs")
        end
    }

    use {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require("plugins.nvim-tree")
        end
    }
    use {
        'nvim-mini/mini.nvim',
        config = function()
            require('mini.cursorword').setup({
                delay=300
            })
        end
    }
end)
