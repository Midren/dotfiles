local M={}
function M.enable_colorizer()
    require'colorizer'.setup()

    require("todo-comments").setup {
        keywords = {
            FIX = {
              icon = " ", -- icon used for the sign, and in search results
              color = "error", -- can be a hex color, or a named color (see below)
              alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
              -- signs = false, -- configure signs for some keywords individually
            },
            TODO = { icon = " ", color = "hint", alt = { 'warning'} },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
        pattern = [[\b(KEYWORDS)\b]],
    }

--  require("lsp-colors").setup({
--      Error = "#db4b4b",
--      Warning = "#e0af68",
--      Information = "#0db9d7",
--      Hint = "#10B981"
--  })


    vim.notify = require("notify")
    require("notify").setup({
      -- Animation style (see below for details)
      stages = "fade_in_slide_out",

      -- Default timeout for notifications
      timeout = 3000,

      -- For stages that change opacity this is treated as the highlight behind the window
      -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
      background_colour = "Normal",

      -- Icons for the different levels
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    })

    require('dressing').setup({
      input = {},
      select = {
        -- Priority list of preferred vim.select implementations
        backend = { "fzf", "builtin" },

        fzf = {
          window = {
            width = 0.5,
            height = 0.4,
          },
        },
      },
    })
end

function M.enable_refactoring()
    local refactoring = require("refactoring")
    refactoring.setup({
        -- prompt for return type
        prompt_func_return_type = {
            go = true,
            cpp = true,
            c = true,
            java = true,
        },
        -- prompt for function parameters
        prompt_func_param_type = {
            go = true,
            cpp = true,
            c = true,
            java = true,
        },
    })

    local function ui_map()
        vim.ui.select(refactoring.get_refactors(), {
            prompt = "refactoring",
        }, function(refactor)
            refactoring.refactor(refactor)
        end)
    end

    _G.Refactor_remaps = {
        ui_map = ui_map,
    }

    vim.api.nvim_set_keymap("v", "<Leader>ref", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
    vim.api.nvim_set_keymap("v", "<Leader>rev", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
    vim.api.nvim_set_keymap("n", "<Leader>riv", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
    vim.api.nvim_set_keymap("n", "<Leader>pl", "<cmd>lua require('refactoring').debug.printf({below = true})<CR>", {noremap = true, silent = true, expr = false})
    vim.api.nvim_set_keymap("n", "<Leader>pv", "<cmd>lua require('refactoring').debug.print_var({below = true})<CR>", {noremap = true, silent = true, expr = false})
    vim.api.nvim_set_keymap("v", "<leader>rf", "<esc><cmd>lua Refactor_remaps.ui_map()<CR>", { silent = true , expr = false})
    vim.api.nvim_set_keymap("n", "<leader>rf", "<esc><cmd>lua Refactor_remaps.ui_map()<CR>", { silent = true , expr = false})
end

function M.enable_treesitter()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = {"cpp", "python", "comment", "dockerfile", "html", "yaml"},
      highlight = {
        enable = true,
      },
    }
end

function M.enable_lsp()
    local lspconfig = require('lspconfig')

    require "lsp_signature".setup({
        hi_parameter = "LspSignatureActiveParameter",
        floating_window=false,
        hint_enable = false,
        always_trigger = false,
        toggle_key = "<c-s>"
    })

    local on_attach = function(client, bufnr)
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        if client.config.flags then
            client.config.flags.allow_incremental_sync = true
        end
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.insertReplaceSupport = false
    capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
    capabilities.textDocument.completion.completionItem.deprecatedSupport = true
    capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      }
    }

    local eslint = {
      lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
      lintIgnoreExitCode = true,
      lintStdin = true,
      lintFormats = {'%f:%l:%c: %m'},
      formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
      formatStdin = true,
    }

    local prettier = {formatCommand = 'prettier --stdin-filepath ${INPUT}', formatStdin = true}

    local luaformatter = {formatCommand = 'lua-format -i', formatStdin = true}

    local pylint = {
      lintCommand = 'pylint --output-format text --rcfile=~/.config/pylint/pylint.conf --extension-pkg-allow-list=math --score no --msg-template {path}:{line}:{column}:{C}:{msg} ${INPUT}',
      lintStdin = true,
      lintFormats = {'%f:%l:%c:%t:%m'},
      lintOffsetColumns = 1,
      lintCategoryMap = {I = 'H', R = 'I', C = 'I', W = 'W', E = 'E', F = 'E'}
    }

    local yapf = {formatCommand = 'yapf --quiet', formatStdin = true}

    local checkmake = {
      lintCommand = 'checkmake --format "w{{.LineNumber}}:{{.Rule}}:{{.Violation}}" ${INPUT}',
      lintFormats = {"%t%l:%m"}
    }

    local languages = {
      make = {checkmake},
      python = {pylint, yapf},
      css = {prettier},
      html = {prettier},
      javascript = {prettier, eslint},
      javascriptreact = {prettier, eslint},
      json = {prettier},
      lua = {luaformatter},
      markdown = {prettier},
      scss = {prettier},
      typescript = {prettier, eslint},
      typescriptreact = {prettier, eslint},
      yaml = {prettier},
    }

    local servers = {
      efm = {
        init_options = {documentFormatting = true, codeAction = true},
        root_dir = lspconfig.util.root_pattern({'.git/', '.vimspector.json', '.'}),
        filetypes = vim.tbl_keys(languages),
        settings = {languages = languages, log_level = 1, log_file = '~/efm.log'},
      },
      sumneko_lua = {
        settings = {
          Lua = {
            diagnostics = {globals = {'vim', 'packer_plugins'}},
          },
        },
      },
      clangd = {
   --   cmd = {require"lspinstall/util".extract_config("clangd").default_config.cmd[1], "--background-index", "--suggest-missing-includes", "--cross-file-rename", "--completion-style=bundled", "--all-scopes-completion"},
        root_dir = lspconfig.util.root_pattern({'.git/', '.vimspector.json', 'CMakeLists.txt'}),
        init_options = {
          clangdFileStatus = true
        },
      },
      pyright = {
        root_dir = lspconfig.util.root_pattern({'.git/', '.vimspector.json'}),
      }
    }

    -- Add automatic lsp installation
    local lsp_installer = require("nvim-lsp-installer")
    lsp_installer.on_server_ready(function(server)
        -- LSP Enable diagnostics
        vim.lsp.handlers["textDocument/publishDiagnostics"] =
            vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = false,
                underline = true,
                signs = true,
                update_in_insert = false
            })
        local coq = require'coq'
        local config = servers[server.name] or {root_dir = lspconfig.util.root_pattern({'.git/', '.'})}
        config.on_attach = on_attach
        config.capabilities = capabilities
        lspconfig[server.name].setup(coq.lsp_ensure_capabilities(config))
        server:setup(config)
    end)

    require('lspsaga').init_lsp_saga({
      use_saga_diagnostic_sign = false,
      code_action_keys = {
          quit='<C-c>', exec='<CR>'
      },
      code_action_prompt = {
        enable = true,
        sign = false,
        virtual_text = true,
      },
    })

    require('lspkind').init({})

    require('calltree').setup({
        layout_size = 60,
    })

end

function M.project_files()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

function M.enable_telescope()
    local actions = require("telescope.actions")
    require"telescope".setup({
        defaults = {
            sorting_strategy = "ascending",
            layout_config = { height = 0.5,  prompt_position = "top" },
            mappings = {
                i = {
                    ["<esc>"] = actions.close,
                    ["<c-j>"] = actions.move_selection_next,
                    ["<c-k>"] = actions.move_selection_previous,
                },
            },
        },
        pickers = {
            find_files = {
                hidden = true
            }
        },
    })
end

function M.setup_plugins()
    pcall(M.enable_lsp)
    pcall(M.enable_treesitter)
    pcall(M.enable_colorizer)
    pcall(M.enable_refactoring)
    pcall(M.enable_telescope)
end

return M
