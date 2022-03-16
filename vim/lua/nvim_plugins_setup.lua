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
        backend = { "telescope", "fzf", "builtin" },

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

        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

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
    capabilities.offsetEncoding = { "utf-16" }
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      }
    }

    local null_ls = require("null-ls")
    require("null-ls").setup({
        root_dir = lspconfig.util.root_pattern({'compile_commands.json', '.vimspector.json', '.git/'}),
        sources = {
            null_ls.builtins.formatting.yapf,
            null_ls.builtins.formatting.isort,
            null_ls.builtins.formatting.cmake_format,
            null_ls.builtins.formatting.lua_format,
            null_ls.builtins.formatting.prettier.with({
                extra_filetypes = {'toml'}
            }),
            null_ls.builtins.diagnostics.checkmake,
            null_ls.builtins.diagnostics.pylint,
            null_ls.builtins.code_actions.refactoring.with({
                extra_filetypes = {'cpp'}
            })
        },
    })

    local servers = {
      sumneko_lua = {
        settings = {
          Lua = {
            diagnostics = {globals = {'vim', 'packer_plugins'}},
          },
        },
      },
      clangd = {
   --   cmd = {require"lspinstall/util".extract_config("clangd").default_config.cmd[1], "--background-index", "--suggest-missing-includes", "--cross-file-rename", "--completion-style=bundled", "--all-scopes-completion"},
        root_dir = lspconfig.util.root_pattern({'.git/', '.vimspector.json'}),
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
        local config = servers[server.name] or {root_dir = lspconfig.util.root_pattern({'.git/', 'Makefile', '.'})}
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
        extensions = {
            fzf = {
              fuzzy = true,                    -- false will only do exact matching
              override_generic_sorter = true,  -- override the generic sorter
              override_file_sorter = true,     -- override the file sorter
            },
        }
    })
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('ctags_outline')
    require('telescope').load_extension('vimspector')

    require("bqf").setup({
        auto_enable=true,
        auto_resize_height = true,
    })
end

function M.enable_distant()
    require('distant').setup({
        ['*'] = require('distant.settings').chip_default()
    })
end

function M.enable_legendary()
    require('legendary').setup({
        include_builtin = false,
        commands = {
            {":ToArgList", ":lua require('utils').to_arglist()", description="Transform to arguments list"},
            {":DogeGenerate", description="Generate documentation"},
            {":JsonPath", description="Print json path"},
            {":LspInstall", description="Install LSP server"},
            {":LspInfo", description="Get information about LSP server"},
            {":FindSelected", ":call VisualSelection('gv', '')", description="Find selected text"},
            {":ConditionalBreakpoint", ":call vimspector#ToggleAdvancedBreakpoint()", description="Add conditional breakpoint"}
        }
    })
end

function M.setup_plugins()
    pcall(M.enable_lsp)
    pcall(M.enable_treesitter)
    pcall(M.enable_colorizer)
    pcall(M.enable_refactoring)
    pcall(M.enable_telescope)
    pcall(M.enable_legendary)
end

return M
