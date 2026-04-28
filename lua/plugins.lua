if not vim.pack then
    local version = vim.fn.matchstr(vim.fn.execute("version"), [[NVIM v\zs[^\n ]*]])
    if version == "" then
        version = "unknown"
    end
    error(
        string.format(
            "This config uses Neovim's built-in vim.pack plugin manager, but vim.pack is not available in NVIM %s. Upgrade Neovim to a build that includes vim.pack.",
            version
        )
    )
end

local function gh(repo, opts)
    local spec = vim.tbl_extend("force", { src = "https://github.com/" .. repo }, opts or {})
    return spec
end

local function safe_require(module)
    local ok, err = pcall(require, module)
    if not ok then
        vim.notify(("Failed to load %s: %s"):format(module, err), vim.log.levels.ERROR)
    end
end

local function notify_pack_hook(name, command, result)
    if result.code ~= 0 then
        vim.schedule(function()
            vim.notify(
                ("Post-install hook failed for %s: %s\n%s"):format(name, command, result.stderr or ""),
                vim.log.levels.ERROR
            )
        end)
    end
end

if vim.fn.exists("##PackChanged") == 1 then
    vim.api.nvim_create_autocmd("PackChanged", {
        group = vim.api.nvim_create_augroup("builtin_pack_hooks", { clear = true }),
        callback = function(event)
            local data = event.data or {}
            local spec = data.spec or {}
            local name = spec.name
            local kind = data.kind

            if kind ~= "install" and kind ~= "update" then
                return
            end

            if name == "fzf" then
                vim.schedule(function()
                    if not data.active then
                        pcall(vim.cmd.packadd, "fzf")
                    end
                    if vim.fn.exists("*fzf#install") == 1 then
                        vim.fn["fzf#install"]()
                    end
                end)
            elseif name == "markdown-preview.nvim" then
                local app_dir = data.path and (data.path .. "/app")
                if app_dir and vim.fn.isdirectory(app_dir) == 1 then
                    vim.system({ "npm", "install" }, { cwd = app_dir }, function(result)
                        notify_pack_hook(name, "npm install", result)
                    end)
                end
            elseif name == "nvim-treesitter" then
                vim.schedule(function()
                    if not data.active then
                        pcall(vim.cmd.packadd, "nvim-treesitter")
                    end
                    pcall(vim.cmd, "TSUpdate")
                end)
            end
        end,
    })
end

-- Vimwiki reads g:vimwiki_list while its plugin files load, so this must run
-- before vim.pack loads vimwiki.
safe_require("plugins.vimwiki-config")

vim.pack.add({
    -- LSP
    gh("neovim/nvim-lspconfig"),
    gh("nvim-treesitter/nvim-treesitter", { version = "master" }),
    gh("nvim-tree/nvim-web-devicons"),

    -- Telescope
    gh("nvim-lua/popup.nvim"),
    gh("nvim-lua/plenary.nvim"),
    gh("nvim-telescope/telescope.nvim"),
    gh("nvim-telescope/telescope-project.nvim"),

    -- UI
    gh("nvim-lualine/lualine.nvim"),
    gh("folke/which-key.nvim", { version = "v2.0.0" }),
    gh("folke/trouble.nvim"),
    gh("rcarriga/nvim-notify"),
    gh("folke/zen-mode.nvim"),
    gh("rebelot/kanagawa.nvim"),
    gh("catppuccin/nvim", { name = "catppuccin" }),
    gh("rafamadriz/neon"),
    gh("NLKNguyen/papercolor-theme"),
    gh("kepano/flexoki-neovim"),

    -- Git
    gh("lewis6991/gitsigns.nvim", { version = "release" }),
    gh("kdheepak/lazygit.nvim"),

    -- Completion
    gh("hrsh7th/nvim-cmp"),
    gh("hrsh7th/cmp-buffer"),
    gh("hrsh7th/cmp-path"),
    gh("hrsh7th/cmp-cmdline"),
    gh("hrsh7th/cmp-nvim-lsp"),

    -- Editing
    gh("vimwiki/vimwiki"),
    gh("windwp/nvim-autopairs"),
    gh("kevinhwang91/nvim-bqf"),
    gh("junegunn/fzf"),
    gh("junegunn/fzf.vim"),
    gh("iamcco/markdown-preview.nvim"),
    gh("luukvbaal/stabilize.nvim"),
    gh("liuchengxu/vista.vim"),
    gh("mfussenegger/nvim-dap"),
    gh("Eandrju/cellular-automaton.nvim"),
    gh("tpope/vim-surround"),
    gh("MunifTanjim/nui.nvim"),
    gh("linux-cultist/venv-selector.nvim"),
    gh("hat0uma/csvview.nvim"),
    gh("LukasPietzschmann/telescope-tabs"),
    gh("nvim-tree/nvim-tree.lua"),
    gh("nvim-mini/mini.nvim"),
    gh("epwalsh/obsidian.nvim"),

    -- AI/dev workflow
    gh("folke/snacks.nvim"),
    gh("coder/claudecode.nvim"),
    { src = "/Users/vipul/projects/nevern.nvim", name = "nevern.nvim" },
    { src = "/Users/vipul/projects/tasks.nvim", name = "tasks.nvim" },
}, {
    confirm = false,
    load = true,
})

safe_require("plugins.catppuccin")
safe_require("plugins.kanagawa")
pcall(vim.cmd.colorscheme, "catppuccin-mocha")

safe_require("plugins.lsp-config")
safe_require("plugins.telescope-config")
safe_require("plugins.lualine-config")
safe_require("plugins.treesitter-config")
safe_require("plugins.gitsigns-config")
safe_require("plugins.nvim-compe-config")
safe_require("plugins.nvim-autopairs-config")
safe_require("plugins.dap-config")
safe_require("plugins.zen-mode")
safe_require("plugins.telescope-tabs")
safe_require("plugins.nvim-tree")

pcall(function()
    require("snacks").setup({
        input = { enabled = true },
    })
end)
safe_require("plugins.claudecode")

pcall(function()
    require("mini.cursorword").setup({
        delay = 300,
    })
end)

pcall(function()
    require("tasks").setup({
        sections = {
            { name = "Pee 0 (Overdue)", query = "not done\ndue before today\nsort by due" },
            { name = "Pee 1 (Due Today)", query = "not done\ndue today\nsort by due" },
            { name = "All Pending", query = "not done\n(due after today) OR (no due date)" },
            { name = "Recently Closed", query = "done\ncompleted in last 7 days\nsort by due", collapsed = true },
        },
    })
end)

safe_require("plugins.which-key-config")
