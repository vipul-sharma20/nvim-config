-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

end

function _G.get_pylsp_path()
  -- First check for virtualenv in current directory
  local venv_paths = {
    vim.fn.getcwd() .. "/.env/bin/pylsp",
    vim.fn.getcwd() .. "/venv/bin/pylsp",
    vim.fn.getcwd() .. "/.venv/bin/pylsp"
  }
  
  for _, path in ipairs(venv_paths) do
    if vim.fn.executable(path) == 1 then
      return path
    end
  end
  
  -- Fall back to system pylsp
  return "pylsp"
end

-- Python LSP configuration
vim.lsp.config.pylsp = {
  cmd = { get_pylsp_path() },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
  on_attach = on_attach,
  settings = {
    pylsp = {
      plugins = {
        -- formatter options
        black = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        -- pylint = { enabled = false, executable = "pylint" },
        -- pyflakes = { enabled = false },
        -- pycodestyle = { enabled = true, maxLineLength = 150},

        -- type checker
        pylsp_mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },

        -- import sorting
        pyls_isort = { enabled = true },

        ruff = {
          enabled = true,  -- Enable the plugin
          formatEnabled = true,  -- Enable formatting using ruffs formatter
          -- executable = "<path-to-ruff-bin>",  -- Custom path to ruff
          -- config = "<path_to_custom_ruff_toml>",  -- Custom config for ruff to use
          extendSelect = { "I" },  -- Rules that are additionally used by ruff
          extendIgnore = { "C90" },  -- Rules that are additionally ignored by ruff
          format = { "I" },  -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
          severities = { ["D212"] = "I" },  -- Optional table of rules where a custom severity is desired
          unsafeFixes = false,  -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action

          -- Rules that are ignored when a pyproject.toml or ruff.toml is present:
          lineLength = 88,  -- Line length to pass to ruff checking and formatting
          exclude = { "__about__.py" },  -- Files to be excluded by ruff checking
          select = { "F", "PLE", "W" },  -- Rules to be enabled by ruff (F=pyflakes, PLE=pylint errors, W=warnings)
          ignore = { "D210" },  -- Rules to be ignored by ruff
          perFileIgnores = { ["__init__.py"] = "CPY001" },  -- Rules that should be ignored for specific files
          preview = false,  -- Whether to enable the preview style linting and formatting.
          targetVersion = "py310",  -- The minimum python version to target (applies for both linting and formatting).
        }
      }
    }
  }
}

-- Go LSP configuration
vim.lsp.config.gopls = {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.work', 'go.mod', '.git' },
  on_attach = on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

-- Enable the LSP servers
vim.lsp.enable('pylsp')
vim.lsp.enable('gopls')



vim.api.nvim_create_user_command(
    'Format',
    function(opts)
        vim.lsp.buf.format({ range = { opts.line1, 0, opts.line2, 0 } })
    end,
    { range = '%' }
)

-- vim.diagnostic.config({ virtual_text = true})

vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		prefix = "●",
		format = function(diagnostic)
			return string.format("%s", diagnostic.message)
		end,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "single",
		format = function(diagnostic)
			return string.format(
				"%s (%s) [%s]",
				diagnostic.message,
				diagnostic.source,
				diagnostic.code or diagnostic.user_data.lsp.code
			)
		end,
	},
})

