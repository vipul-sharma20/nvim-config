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
        config = function()
            require("plugins.lsp-config")
        end,
    }
    use {"glepnir/lspsaga.nvim"}
    use {"kabouzeid/nvim-lspinstall"}

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

    -- Tabline
    use {
        "kdheepak/tabline.nvim",
        config = function()
            require("plugins.tabline-config")
        end,
    }

    -- Lua
    use {
        "folke/which-key.nvim",
        config = function()
            require("plugins.which-key-config")
        end,
	}

    -- Copilot
    use {"github/copilot.vim"}

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("plugins.treesitter-config")
        end
    }

    -- Colorschemes
    use {
        "rebelot/kanagawa.nvim",
        config = function()
            require("plugins.kanagawa")
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
        "hrsh7th/nvim-compe",
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
        "lukas-reineke/indent-blankline.nvim",
        ft = {"python", "go", "lua", "yaml"},
        config = function()
            require("plugins.indent-blankline-config")
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
        ft = "markdown",
    }

    use {
        "KadoBOT/nvim-spotify", 
        requires = "nvim-telescope/telescope.nvim",
        config = function()
            local spotify = require"nvim-spotify"

            spotify.setup {
                -- default opts
                status = {
                    update_interval = 10000, -- the interval (ms) to check for what"s currently playing
                    format = "%s %t by %a" -- spotify-tui --format argument
                }
            }
        end,
        run = "make"
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

    use {
        "puremourning/vimspector"
    }

    use {
        "tools-life/taskwiki"
    }

    -- Light colorscheme
    use "rafamadriz/neon"

    use {
        "lukas-reineke/lsp-format.nvim",
        config = function()
            require("plugins.lsp-format")
        end,
    }

    -- Light colorscheme
    use "NLKNguyen/papercolor-theme"

    -- CellularAutomaton
    use "Eandrju/cellular-automaton.nvim"

    use "tpope/vim-surround"

    -- Image viewer
    use {
        "edluffy/hologram.nvim",
        config = function()
            require('hologram').setup{
            auto_display = true -- WIP automatic markdown image display, may be prone to breaking
        }
        end,

    }

    -- Notification manager
    use "rcarriga/nvim-notify"

    use({
        "jackMort/ChatGPT.nvim",
        config = function()
            require("plugins.chatgpt")
        end,
        requires = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim"
        }
    })

end)

