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
            TODO = { icon = " ", color = "#2563EB", alt = { "todo" }},
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "#2563EB", alt = { "INFO" } },
        },
        highlight = {
            before="",
            keyword="bg",
            after="fg",
            comments_only = true,
            pattern = [[.*<(KEYWORDS):\s*]],
        },
        search = {
            pattern = [[\b(KEYWORDS):\b]],
        },
    }

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
      ensure_installed = {"cpp", "python", "lua", "dockerfile", "gitignore", "gitcommit", "markdown_inline", "yaml"},
      sync_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      autotag = { -- using nvim-ts-autotag
        enable = true,
        filetypes = { "html" , "xml", "sdf" },
      },
      nt_cpp_tools = { -- using nvim-treesitter-cpp-tools
        enable = true,
        preview = {
          quit = 'q',
          accept = '<cr>'
        },
      }
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

        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false

        if client.config.flags then
            client.config.flags.allow_incremental_sync = true
        end

        require("clangd_extensions.inlay_hints").setup_autocmd()
        require("clangd_extensions.inlay_hints").set_inlay_hints()
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
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
            null_ls.builtins.code_actions.refactoring.with({
                extra_filetypes = {'cpp'}
            }),
            null_ls.builtins.formatting.clang_format,
            null_ls.builtins.formatting.xmllint
        },
    })

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {globals = {'vim', 'packer_plugins'}},
          },
        },
      },
      clangd = {
        cmd = {"clangd", "--inlay-hints", "--background-index", "--completion-style=bundled", "--all-scopes-completion"},
        root_dir = lspconfig.util.root_pattern({'compile_commands.json', '.git/', '.vimspector.json'}),
        init_options = {
          clangdFileStatus = true
        },
        capabilities = {
            offsetEncoding = { "utf-16" }
        }
      },
      pyright = {
        root_dir = lspconfig.util.root_pattern({'.git/', '.vimspector.json'}),
      },
      sourcery = {
        init_options = {
            token = "user_6fR1R0UkRe58HtFmOG47KzGJinhzNkTLMqJANQbNKmmnpENm3UuuDPmaxYc",
        }
      }
    }

    require("mason").setup()
    require("mason-lspconfig").setup{ensure_installed = { "lua_ls", "clangd", "pyright", "jsonls"}}
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            underline = true,
            signs = true,
            update_in_insert = false
        })
    require("mason-lspconfig").setup_handlers {
        function (server_name)
        local coq = require'coq'
        local config = servers[server_name] or {root_dir = lspconfig.util.root_pattern({'.git/', 'Makefile', '.'})}
        config.on_attach = on_attach
        config.capabilities = capabilities

        require("lspconfig")[server_name].setup(coq.lsp_ensure_capabilities(config))
        end,
    }

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

function M.enable_cmake()
    local Path = require('plenary.path')

    require('cmake').setup({
      parameters_file = '.vim.cmake.json',
      build_dir = tostring(Path:new('{cwd}', 'cmake-build-{build_type}')),
      configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=ON' },
      build_args = {'-j8'},
      quickfix_height = 10,
      quickfix_only_on_error = false
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
        include_legendary_cmds = false,
        autocmds = {},
        commands = {
            {":ToArgList", ":lua require('utils').to_arglist()", description="Transform to arguments list"},
            {":DogeGenerate", description="Generate documentation"},
            {":JsonPath", description="Print json path"},
            {":LspInstall", description="Install LSP server"},
            {":LspInfo", description="Get information about LSP server"},
            {":FindSelected", ":call VisualSelection('gv', '')", description="Find selected text"},
            {":ConditionalBreakpoint", ":call vimspector#ToggleAdvancedBreakpoint()", description="Add conditional breakpoint"},
            {":MarkdownPreviewToggle", description="Toggle preview of markdown file"},
            {":TSCppDefineClassFunc", description="Add definition of class methods"},
            {":TSCppMakeConcreteClass", description="Create cpp concrete class implementation"},
            {":TSCppRuleOf3", description="Add cpp methods for Rule of 3"},
            {":TSCppRuleOf5", description="Add cpp methods for Rule of 5"},
        }
    })
end

function M.enable_auto_change_color()
    local auto_dark_mode = require('auto-dark-mode')

    auto_dark_mode.setup({
        set_dark_mode = function()
            vim.api.nvim_set_option('background', 'dark')
            vim.cmd('colorscheme palenight')
            vim.cmd('highlight! DiagnosticUnderlineError guisp=#db4b4b gui=undercurl,bold')
            vim.cmd('highlight! DiagnosticUnderlineWarn guisp=#e0af68 gui=undercurl,bold')
            vim.cmd('highlight! DiagnosticUnderlineInfo guisp=#0db9d7 gui=undercurl,bold')
            vim.cmd('highlight! DiagnosticUnderlineHint guisp=#10B981 gui=undercurl,bold')
            --  TODO: make valid colors for git diff
        end,
        set_light_mode = function()
            vim.api.nvim_set_option('background', 'light')
            vim.cmd('colorscheme vim-material')
            vim.cmd('highlight! DiagnosticUnderlineError guisp=#db4b4b gui=undercurl,bold')
            vim.cmd('highlight! DiagnosticUnderlineWarn guisp=#e0af68 gui=undercurl,bold')
            vim.cmd('highlight! DiagnosticUnderlineInfo guisp=#0db9d7 gui=undercurl,bold')
            vim.cmd('highlight! DiagnosticUnderlineHint guisp=#10B981 gui=undercurl,bold')
        end,
    })
    auto_dark_mode.init()
end

function M.setup_plugins()
    pcall(M.enable_lsp)
    pcall(M.enable_treesitter)
    pcall(M.enable_colorizer)
    if vim.fn.has('macunix') then
        pcall(M.enable_auto_change_color)
    end
    pcall(M.enable_refactoring)
    pcall(M.enable_telescope)
    pcall(M.enable_cmake)
    pcall(M.enable_legendary)
end

return M
