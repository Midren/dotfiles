set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua <<EOF
function enable_colorizer()
    require'colorizer'.setup()
end

function enable_refactoring()
    local refactor = require("refactoring")
    refactor.setup()
    vim.api.nvim_set_keymap("v", "<Leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
    vim.api.nvim_set_keymap("v", "<Leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
    vim.api.nvim_set_keymap("v", "<Leader>rt", [[ <Esc><Cmd>lua M.refactors()<CR>]], {noremap = true, silent = true, expr = false})
end

function enable_treesitter()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = {"cpp", "python", "comment", "dockerfile", "html", "yaml"},
      highlight = {
        enable = true,
      },
    }
end

function enable_lsp()
    local lspconfig = require('lspconfig')

    local on_attach = function(client, bufnr)
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
        
        --[[
        require "lsp_signature".on_attach({
          bind=true,
          handler_opts ={
            border="single",
          },
          hint_enable=false,
          hint_prefix=""
        })
        ]]

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

    languages = {
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
        root_dir = lspconfig.util.root_pattern({'.git/', '.'}),
        filetypes = vim.tbl_keys(languages),
        settings = {languages = languages, log_level = 1, log_file = '~/efm.log'},
      },
      lua = {
        settings = {
          Lua = {
            diagnostics = {globals = {'vim', 'packer_plugins'}},
            completion = {keywordSnippet = 'Both'},
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            workspace = {library = vim.list_extend({[vim.fn.expand('$VIMRUNTIME/lua')] = true}, {})},
          },
        },
      },
      clangd = {
        cmd = {require"lspinstall/util".extract_config("clangd").default_config.cmd[1], "--background-index", "--suggest-missing-includes", "--cross-file-rename", "--completion-style=bundled", "--all-scopes-completion"},
        root_dir = lspconfig.util.root_pattern({'.git/', '.'}),
        init_options = {
          clangdFileStatus = true
        },
      }
    }

    local function setup_servers()
      require'lspinstall'.setup()
      local coq = require'coq'
      local installed_servers = require'lspinstall'.installed_servers()
      for _, server in pairs(installed_servers) do
        local config = servers[server] or {root_dir = lspconfig.util.root_pattern({'.git/', '.'})}
        config.on_attach = on_attach
        config.capabilities = capabilities
        lspconfig[server].setup(coq.lsp_ensure_capabilities(config))
      end
    end

    setup_servers()

    require'lspinstall'.post_install_hook = function ()
      setup_servers() -- reload installed servers
      vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
    end

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

    -- LSP Enable diagnostics
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            underline = true,
            signs = true,
            update_in_insert = false
        })

    --[[
    require'compe'.setup {
        enabled = true;
        autocomplete = true;
        debug = false;
        min_length = 3;
        preselect = 'enable';
        throttle_time = 80;
        source_timeout = 200;
        incomplete_delay = 400;
        allow_prefix_unmatch = false;
        max_abbr_width = 1000;
        max_kind_width = 1000;
        max_menu_width = 1000000;
        documentation = true;


        source = {
            path = true;
            buffer = true;
            calc = true;
            vsnip = true;
            nvim_lsp = true;
            nvim_lua = true;
            spell = false;
            tags = true;
            snippets_nvim = true;
            treesitter = false;
            ultisnips = true;
      };
    }
    ]]

    vim.fn.sign_define("LspDiagnosticsSignError",
        {text = "✖", texthl = "LspDiagnosticsDefaultError"})
    vim.fn.sign_define("LspDiagnosticsSignWarning",
        {text = "", texthl = "LspDiagnosticsDefaultWarning"})
    vim.fn.sign_define("LspDiagnosticsSignInformation",
        {text = "ℹ", texthl = "LspDiagnosticsDefaultWarning"})
    vim.fn.sign_define("LspDiagnosticsSignHint",
        {text = "ℹ", texthl = "LspDiagnosticsDefaultWarning"})
end

pcall(enable_lsp)
pcall(enable_treesitter)
pcall(enable_colorizer)
pcall(enable_refactoring)

EOF
