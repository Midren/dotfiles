""""""""""""""""""""""""""""""
" => Install using Vim-plug
""""""""""""""""""""""""""""""
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

"""""""""""""""""""""""""""""
" => Lookie
"""""""""""""""""""""""""""""
Plug 'hzchirs/vim-material'
Plug 'itchyny/lightline.vim'
Plug 'ChristianChiarulli/nvcode-color-schemes.vim'
if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'rcarriga/nvim-notify'
    Plug 'cormacrelf/dark-notify'
    Plug 'stevearc/dressing.nvim' " better chooser
    Plug 'folke/todo-comments.nvim' " highlight TODO comments
endif

""""""""""""""""""""""""""""""
" => Development
""""""""""""""""""""""""""""""
" ==> Completition
if has('nvim')
    Plug 'neovim/nvim-lspconfig'
    Plug 'onsails/lspkind-nvim'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq', 'do': 'python3 -m coq deps'}
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
else
    Plug 'ycm-core/YouCompleteMe', {'do': './install.py --clang-completer --clangd-completer'} | Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
endif
Plug 'derekwyatt/vim-protodef', { 'for': ['c', 'cpp'] }
Plug 'pchynoweth/vim-gencode-cpp', { 'for': ['c', 'cpp'] } | Plug 'pchynoweth/a.vim', { 'for': ['c', 'cpp']}

" ==> Navigating
if has('nvim')
    Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps --nvim'}
else
    Plug 'lambdalisue/fern.vim'
    Plug 'lambdalisue/fern-renderer-nerdfont.vim' | Plug 'lambdalisue/nerdfont.vim' | Plug 'lambdalisue/glyph-palette.vim'
endif
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } | Plug 'junegunn/fzf.vim' " Fzf for cmake4vim
Plug 'ludovicchabant/vim-gutentags' | Plug 'skywind3000/gutentags_plus'
Plug 'mileszs/ack.vim' | Plug 'jesseleite/vim-agriculture'
Plug 'vim-utils/vim-husk' " bash mappings for cli
Plug 'christoomey/vim-tmux-navigator'

" ==> Linting
if has('nvim')
    Plug 'jose-elias-alvarez/null-ls.nvim'
endif

" ==> Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'oguzbilgic/vim-gdiff'

" ==> Misc
Plug 'tpope/vim-dispatch'
Plug 'ilyachur/cmake4vim',                    " Cmake support
      \{ 'for': ['c', 'cpp']}
Plug 'scrooloose/nerdcommenter'
Plug 'kkoomen/vim-doge',                    " Doxygen documentation
      \{ 'do': { -> doge#install() }, 'for': ['c', 'cpp', 'python'] } 
Plug 'vim-scripts/modelica'
Plug 'ekalinin/Dockerfile.vim'
Plug 'thaerkh/vim-workspace'                " Intersession open buffers saving
Plug 'goerz/jupytext.vim',                  " Open jupyter notebooks as markdown
      \{ 'do': 'pip3 install jupytext'}
Plug 'metakirby5/codi.vim',                 " realtime interpreter
      \{ 'for': ['python', 'cpp']} 
Plug 'weirongxu/plantuml-previewer.vim' | Plug 'tyru/open-browser.vim'
Plug 'AndrewRadev/sideways.vim'             " argument objects
Plug 'alepez/vim-gtest',                    " Google Test support
      \{'for': ['c', 'cpp']}
Plug 'tmsvg/pear-tree'                      " pairs completition
Plug 'Midren/splitjoin.vim'
Plug 'tpope/vim-surround'
Plug 'moll/vim-bbye'
Plug 'romainl/vim-qf'
Plug 'elbeardmorez/vim-loclist-follow'
Plug 'psliwka/vim-smoothie'
Plug 'puremourning/vimspector', { 'for': ['python', 'cpp', 'cmake'], 'do': './install_gadget.py --enable-cpp --enable-python'}
Plug 'Shougo/echodoc.vim'
Plug 'vim-test/vim-test', { 'for': ['python']}
"Plug 'sagi-z/vimspectorpy', { 'for': ['python'], 'do': { -> vimspectorpy#update() } } " Adds vimspectorpy strategy for vim-test
Plug 'rcarriga/vim-ultest', { 'for': ['python'], 'do': ':UpdateRemotePlugins' } | Plug 'roxma/nvim-yarp' | Plug 'roxma/vim-hug-neovim-rpc'
Plug 'mogelbrod/vim-jsonpath' " show path inside json
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
Plug 'CarloDePieri/pytest-vim-compiler'
Plug 'ldelossa/calltree.nvim' " show calling functions
Plug 'ArthurSonzogni/Diagon' " ASCII diagrams
Plug 'tpope/vim-speeddating' " increment dates using <C-a> & <C-x>
Plug 'kevinhwang91/nvim-bqf' " better quick-fix

"""""""""""""""""""""""""""""
" => Writing
"""""""""""""""""""""""""""""
Plug 'lervag/vimtex',                       " latex
      \{'for': ['tex']}
Plug 'plasticboy/vim-markdown', {'for': ['markdown']}
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/goyo.vim' | Plug 'amix/vim-zenroom2' | Plug 'junegunn/limelight.vim'

"""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""
Plug 'skywind3000/asyncrun.vim'
Plug 'markonm/traces.vim' " Highlighting default ex substitute
Plug 'tpope/vim-repeat'
Plug 'markstory/vim-zoomwin' " Maximize splits


"""""""""""""""""""""""""""""
" => Temp
"""""""""""""""""""""""""""""
Plug 'tell-k/vim-autopep8'
Plug 'dstein64/nvim-scrollview'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/refactoring.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

""""""""""""""""""""""""""""""
" => Gutentags
""""""""""""""""""""""""""""""
let g:gutentags_define_advanced_commands = 1
" remove auto maps
let g:gutentags_plus_nomap = 1

" enable gtags module
let g:gutentags_modules = ['ctags']

" config project root markers.
let g:gutentags_project_root = ['.git', '.root', '.color_coded']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ '--c++-kinds=+p',
      \ '--extra=+q',
      \ '--languages=C++,Python,C,vim',
      \ '--python-kinds=-iv'
      \ ]

let g:fzf_tags_command = 'ctags -R --tag-relative=yes --fields=+ailmnS --c++-kinds=+p --extra=+q --languages=C++,Python,C,vim'

if executable('rg')
  let g:gutentags_file_list_command = 'rg --files'
endif

let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']

let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ '.*build.*',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

""""""""""""""""""""""""""""""
" => junegunn/fzf
""""""""""""""""""""""""""""""
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.4 } }
let $FZF_DEFAULT_COMMAND='rg -l "" --sort path --hidden --glob "!**/.git/**"'
let $FZF_DEFAULT_OPTS="--reverse --tiebreak=length,end,index"
let g:fzf_history_dir = '~/.local/share/fzf-history'

autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

let g:fzf_colors =
              \ { 'fg':      ['fg', 'Normal'],
              \ 'bg':      ['bg', 'Normal'],
              \ 'hl':      ['fg', 'Comment'],
              \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
              \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
              \ 'hl+':     ['fg', 'Statement'],
              \ 'info':    ['fg', 'PreProc'],
              \ 'border':  ['fg', 'Ignore'],
              \ 'prompt':  ['fg', 'Conditional'],
              \ 'pointer': ['fg', 'Exception'],
              \ 'marker':  ['fg', 'Keyword'],
              \ 'spinner': ['fg', 'Label'],
              \ 'header':  ['fg', 'Comment'] }

augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

""""""""""""""""""""""""""""""
" => nvim-telescope/telescope.nvim 
""""""""""""""""""""""""""""""
nnoremap <silent> <C-f> <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>lf :lua require"nvim_plugins_setup".project_files()<cr>
nnoremap <silent> <leader>lb <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>ls <cmd>Telescope tags<cr>
nnoremap <silent> <leader>lr <cmd>Telescope oldfiles<cr>
nnoremap <silent> <leader>ll :BTags<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => mileszs/ack.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the the_silver_searcher if possible (much faster than Ack)
if executable('rg')
  let g:ackprg = 'rg --vimgrep --smart-case'
endif

" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position
"
vnoremap <silent> <leader>fd :call VisualSelection('gv', '')<CR>
nmap              <leader>fd :Ack!

""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lambdalisue/fern.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fern#disable_default_mappings = 1
let g:fern#disable_drawer_smart_quit = 0
let g:fern#renderer = "nerdfont"

function! s:init_fern() abort
  nmap <buffer><expr> <Plug>(fern-my-open-or-expand)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-action-open)",
      \   "\<Plug>(fern-action-expand:stay)",
      \   "\<Plug>(fern-action-collapse)",
      \ )
  nmap <buffer> <cr>  <Plug>(fern-my-open-or-expand)
  nmap <buffer> l  <Plug>(fern-my-open-or-expand)

  nmap <buffer> o <Plug>(fern-action-open:edit)
  nmap <buffer> i <Plug>(fern-action-open:bottom)
  nmap <buffer> s <Plug>(fern-action-open:right)
  nmap <buffer> N <Plug>(fern-action-new-path)
  nmap <buffer> m <Plug>(fern-action-move)

  nmap <buffer> h <Plug>(fern-action-leave)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
  nmap <buffer> cd <Plug>(fern-action-cd:cursor)

  nmap <buffer> I <Plug>(fern-action-hide-toggle)
  nmap <buffer> dd <Plug>(fern-action-trash)
  nmap <buffer> zh <Plug>(fern-action-hidden:toggle)
  nmap <buffer> t <Plug>(fern-action-mark:toggle)j
  nmap <buffer> <Space> <Plug>(fern-action-mark:toggle)j

  nmap <buffer> q :<C-u>quit<CR>
endfunction

function s:is_fern_open() abort
    try
      return fern#internal#window#find( { w -> fern#internal#drawer#is_drawer(bufname(winbufnr(w))) }, )
    catch /^Vim\%((\a\+)\)\=:E117/
      return v:false
    endtry
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
  autocmd FileType fern call glyph_palette#apply()
  autocmd QuitPre * if (winnr('$') == 2 && s:is_fern_open()) | FernDo close | endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ms-jpq/chadtree 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:chadtree_settings = { 'keymap.primary': ['<cr>','l'],
                          \ 'keymap.new': ['N'], 
                          \ 'keymap.copy': ['p'], 
                          \ 'keymap.cut': ['m'], 
                          \ 'keymap.delete': ['DD'],
                          \ 'keymap.trash': ['dD'],
                          \ 'keymap.toggle_hidden': ['zh'],
                          \ 'keymap.select': ['t', "<space>"],
                          \ 'keymap.open_sys': ['o'],
                          \ 'keymap.change_focus_up': ['U', "C"] }

if has('nvim')
    map <silent> <leader>nt :CHADopen<cr>
    map <silent> <leader>nf :CHADopen<cr>
else
    map <silent> <leader>nt :Fern . -stay -reveal= -drawer -toggle -width=50<cr>
    map <silent> <leader>nf :Fern . -stay -reveal=% -drawer -toggle -width=50<cr>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimroom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2

function! s:goyo_enter()
    Limelight
endfunction

function! s:goyo_leave()
    Limelight!
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

nnoremap <silent> <leader>z :Goyo<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=0
let g:gitgutter_highlight_lines = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 1

function! s:in_last_hunk_line(lnum) abort
  " Hunks are sorted in the order they appear in the buffer.
  for hunk in gitgutter#hunk#hunks(bufnr(''))
    " if in a hunk on first line of buffer
    if a:lnum == 1 && hunk[2] == 0
      return 1
    endif

    " if in a hunk generally
    if a:lnum >= hunk[2] && a:lnum == hunk[2] + (hunk[3] == 0 ? 1 : hunk[3]) - 1
      return 1
    endif

    " if hunk starts after the given line
    if a:lnum < hunk[2]
      return 0
    endif
  endfor

  return 0
endfunction

"autocmd CursorMoved * if s:in_last_hunk_line(line(".")) | GitGutterPreviewHunk | else | pclose | endif

highlight! link GitGutterAdd SignColumn
highlight! link GitGutterChange SignColumn
highlight! link GitGutterDelete SignColumn

nmap <silent> ]h :GitGutterNextHunk<cr>:GitGutterPreviewHunk<cr>
nmap <silent> [h :GitGutterPrevHunk<cr>:GitGutterPreviewHunk<cr>
nmap <silent> <leader>hs <Plug>(GitGutterStageHunk)
nmap <silent> <leader>hu <Plug>(GitGutterUndoHunk)
nmap <silent> <leader>hp <Plug>(GitGutterPreviewHunk)
omap <silent> ih <Plug>(GitGutterTextObjectInnerPending)
omap <silent> ah <Plug>(GitGutterTextObjectOuterPending)
xmap <silent> ih <Plug>(GitGutterTextObjectInnerVisual)
xmap <silent> ah <Plug>(GitGutterTextObjectOuterVisual)
nnoremap <silent> <leader>df :GitGutterToggle<cr>
" Usually you don't need to have list of all hunks, but better list of modified files
"nnoremap <silent> <leader>hl :GitGutterQuickFix<cr>:copen<cr>:cd `git rev-parse --show-toplevel`<cr>
" Even better with Fuzzy Finding )
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gc :Telescope git_branches<CR>
nnoremap <silent> <leader>gs :Git<cr>:resize 12<cr>

nmap <leader>gf :diffget //2<cr>
nmap <leader>gj :diffget //3<cr>
nmap <leader>gm :Gvdiffsplit!<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-material
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    colorscheme vim-material
    set background=light
catch /^Vim\%((\a\+)\)\=:E185/
    " ignore
endtry


function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map <silent> gm :call SynStack()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => scrooloose/nerdcommenter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDCreateDefaultMappings = 0
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1
let g:NERDDefaultNesting = 1
nmap <C-_>   <Plug>NERDCommenterToggle j
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv
nmap <C-/>   <Plug>NERDCommenterToggle j
vmap <C-/>   <Plug>NERDCommenterToggle<CR>gv

" Delete comment character when joining commented lines
autocmd FileType * set formatoptions+=j


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lervag/vimtex
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

autocmd FileType tex nnoremap <silent> <leader>cb :VimtexCompile<cr>
autocmd FileType tex nnoremap <silent> <leader>cc :VimtexClean<cr>
autocmd FileType tex nnoremap <silent> <leader>cr :VimtexView<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ilyachur/cmake4vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cmake_compile_commands=1
let g:cmake_compile_commands_link='.'
let g:cmake_reload_after_save=0
let g:make_arguments='-j8'
let g:cmake_vimspector_support=1
let g:asyncrun_open = 8
"let g:cmake_project_generator='Ninja'
let g:cmake_build_executor='dispatch'
let g:cmake_usr_args={"CMAKE_CXX_FLAGS": "'-Wno-deprecated-copy -Wno-deprecated-declarations -Wno-format'"}

autocmd FileType c,cpp,cmake nnoremap <buffer> <silent> <leader>cb :CMakeBuild<cr>
autocmd FileType c,cpp,cmake nnoremap <buffer> <silent> <leader>cc :CMakeClean<cr>
autocmd FileType c,cpp,cmake nnoremap <buffer> <silent> <leader>ct :call fzf#run(fzf#wrap({
                    \ 'source': cmake4vim#GetAllTargets(),
                    \ 'options': '+m -n 1 --prompt CMakeTarget\>\ ',
                    \ 'sink':    function('cmake4vim#SelectTarget')}))<cr>
autocmd FileType c,cpp,cmake nnoremap <silent> <leader>cr :CMakeRun<cr>

let PYTHONUNBUFFERED=1
"autocmd FileType python nnoremap <silent> <leader>cr :sp term://python3 '%'<cr>:resize 10<cr>
autocmd FileType python nnoremap <silent> <buffer> <leader>cr :Dispatch python3 -u "%"<cr>
autocmd FileType python nnoremap <silent> <buffer> <leader>cs :AbortDispatch<cr>

autocmd FileType sh nnoremap <silent> <buffer> <leader>cr :Dispatch bash -u "%"<cr>
autocmd FileType sh nnoremap <silent> <buffer> <leader>cs :AbortDispatch<cr>

let g:cmake_build_type = 'Debug'
let g:cmake_vimspector_default_configuration = {
            \  "adapter": "CodeLLDB",
            \  "breakpoints": {
            \    "exception": {
            \      "cpp_catch": "N",
            \      "cpp_throw": "Y",
            \      }
            \    },
            \  "configuration": {
            \    "type": "lldb",
            \    "request": "launch",
            \    "stopAtEntry": "False",
            \    "cwd": "${workspaceRoot}",
            \    "args": [],
            \  }
            \  }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ycm-core/YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup MyYCMCustom
    let g:ycm_add_preview_to_completeopt = 1
    let g:ycm_key_invoke_completion = '<C-Space>'
    let g:ycm_key_list_stop_completion = ['<C-y>', '<Esc>']
    let g:ycm_always_populate_location_list = 1
    let g:ycm_open_loclist_on_ycm_diags = 1
    let g:ycm_allow_changing_updatetime = 0

    let g:ycm_semantic_triggers =  {
      \   'c,cpp': [ 're!\w{3}', '_', '.', '->', '::' ],
      \   'python': [ 're!\w{3}', '.'  ],
      \   'VimspectorPrompt': [ '.', '->', ':', '<' ]
      \ }
    if !has('nvim')
      set completeopt+=popup
    else
      set completeopt+=preview
    endif
    highlight YcmWarningSign ctermfg=Red guifg=Red
    highlight YcmErrorsign ctermfg=Red guifg=Red

    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_clangd_args = ['-cross-file-rename']
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf/ycm_extra_conf.py'
    let g:ycm_confirm_extra_conf = 0

    let g:ycm_key_list_select_completion = []
    let g:ycm_key_list_previous_completion = []
    let g:ycm_key_detailed_diagnostics = ''
    let g:ycm_error_symbol = '✖'
    let g:ycm_warning_symbol = '⚠'

    let g:UltiSnipsExpandTrigger = "<nop>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
    let g:ulti_expand_or_jump_res = 0

    function ExpandSnippetOrReturn()
        let snippet = UltiSnips#ExpandSnippetOrJump()
        if g:ulti_expand_or_jump_res > 0
            return snippet
        else
            return "\<C-y>"
        endif
    endfunction
    
    if !has('nvim')
        inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrReturn()<CR>" : "\<CR>"
    endif

    let g:UltiSnipsSnippetsDir        = $HOME.'/.vim/UltiSnips/'
    let g:UltiSnipsSnippetDirectories = ["UltiSnips"]

    autocmd!
    autocmd FileType c,cpp,python let b:ycm_hover = {
      \ 'command': 'GetDoc',
      \ 'syntax': &filetype
      \ }
    let g:ycm_auto_hover=''
augroup END

if !has('nvim')
    nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
    nnoremap <silent> <leader>fr :YcmCompleter GoToReferences<CR>
    nnoremap <silent> <leader>rr :YcmCompleter RefactorRename 
    nnoremap <silent> <leader>ft :YcmCompleter FixIt<CR>
    nmap <silent> <leader>dt <plug>(YCMHover)

    autocmd FileType c,cpp nnoremap <silent> <C-LeftMouse> <LeftMouse>:YcmCompleter GoTo<CR>
    autocmd FileType c,cpp nnoremap <silent> <C-]> :YcmCompleter GoTo<CR>
else
    nnoremap <silent> [e :lua vim.lsp.diagnostic.goto_prev()<CR>
    nnoremap <silent> ]e :lua vim.lsp.diagnostic.goto_next()<CR>
    nnoremap <silent> <leader>ce :lua vim.diagnostic.open_float()<CR>
    nnoremap <silent> <leader>ft :lua vim.lsp.buf.code_action()<CR>
    vnoremap <silent> <leader>ft :lua vim.lsp.buf.range_code_action<CR>
    nnoremap <silent> <leader>dt :lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <leader>rr :lua vim.lsp.buf.rename()<CR>

    nnoremap <silent> <leader>gd :Telescope lsp_definitions<CR>
    nnoremap <silent> <leader>gi :Telescope lsp_implementations<CR>
    nnoremap <silent> <leader>fr :Telescope lsp_references<CR>
    nnoremap <silent> <leader>fc :lua vim.lsp.buf.incoming_calls()<CR>
    nnoremap <silent> <leader>cf :lua vim.lsp.buf.formatting()<CR>
    vnoremap <silent> <leader>cf :lua vim.lsp.buf.range_formatting()<CR>
    "nnoremap <silent> <leader>ct :lua vim.lsp.buf.type_definition()<CR>
    "vim.api.nvim_set_keymap('n', '<c-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    nnoremap <silent> <c-s> :lua vim.lsp.buf.signature_help()<CR>
endif
set updatetime=250

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => kkoomen/vim-doge
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:doge_enable_mappings=0
let g:doge_doc_standard_cpp='doxygen_qt'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => thaerkh/vim-workspace
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:workspace_session_directory = $HOME . '/.vim/temp_dirs/sessions/'
let g:workspace_persist_undo_history = 0
let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0
let g:workspace_autosave_ignore = ['gitcommit', 'qf', 'nerdtree', 'tagbar']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => derekwyatt/vim-protodef
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:protodefprotogetter='~/.vim/plugged/vim-protodef/pullproto.pl'
let g:disable_protodef_sorting=1
let g:disable_protodef_mapping=1

nmap <silent> <leader>gp :set paste<cr>i<c-r>=protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({})<cr><esc>='[:set nopaste<cr>
" Add functions to generate prototypes
"nmap <buffer> <silent> <leader>gn :set paste<cr>i<c-r>=protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({'includeNS' : 0})<cr><esc>='[:set nopaste<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => pchynoweth/a.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quick switch between header and source file
nnoremap <silent> <leader>bs :A<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => AndrewRadev/sideways.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><c-h> :SidewaysLeft<cr>
nnoremap <leader><c-l> :SidewaysRight<cr>

omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => alepez/vim-gtest
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup GTest
	autocmd FileType cpp nnoremap <silent> <leader>tt :GTestRun<CR>
	autocmd FileType cpp nnoremap <silent> <leader>tu :GTestRunUnderCursor<CR>
	autocmd FileType cpp nnoremap          <leader>tc :GTestCase<space>
	autocmd FileType cpp nnoremap <silent> <leader>td :GTestToggleEnabled<CR>
	autocmd FileType cpp nnoremap <silent> ]t         :GTestNext<CR>
	autocmd FileType cpp nnoremap <silent> [t         :GTestPrev<CR>
	autocmd FileType cpp nnoremap <silent> <leader>tf :FZFGTest<CR>
	autocmd FileType cpp nnoremap          <leader>ti :GTestNewTest<CR>i
    let g:gtest#print_time = 1
    let g:gtest#test_filename_suffix = "test"
    let g:gtest#gtest_command = "/home/rmilishc/build-GreenPAKDesigner-Desktop_Qt_5_12_3_GCC_64bit-Debug/deploy/bin/gtest_gpd6_unittests"
    let g:gtest#highlight_failing_tests = 1
augroup END

nnoremap ]r :%bd<CR>:cnext<CR>:Gvdiffsplit master<CR>
nnoremap [r :%bd<CR>:cprevious<CR>:Gvdiffsplit master<CR>
nnoremap ]R :%bd<CR>:clast<CR>:Gvdiffsplit master<CR>
nnoremap [R :%bd<CR>:cfirst<CR>:Gvdiffsplit master<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tmsvg/pear-tree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'},
            \ }
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_map_special_keys = 0
imap <BS> <Plug>(PearTreeBackspace)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tenfyzhong/vim-gencode-cpp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cpp_gencode_function_attach_statement = [ '' ]
nnoremap <leader>ad :GenDefinition<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => moll/vim-bbye
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Close the current buffer
map <leader>bd :Bdelete<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo :Bdelete<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => romainl/vim-qf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <leader>q <Plug>(qf_qf_toggle)
"nnoremap <leader>e <Plug>(qf_loc_toggle)
nnoremap <silent> <leader>q :<C-u> call qf#toggle#ToggleQfWindow(0)<cr>
nnoremap <silent> <leader>e :<C-u> call qf#toggle#ToggleLocWindow(0)<cr>
nnoremap <silent> ]q :cn<cr>
nnoremap <silent> [q :cp<cr>
if !has('nvim')
    nnoremap <silent> ]e :lnext<cr>
    nnoremap <silent> [e :lprev<cr>
endif

autocmd FileType qf nnoremap <buffer> <silent> <C-H> <Plug>(qf_older)
autocmd FileType qf nnoremap <buffer> <silent> <C-L> <Plug>(qf_newer)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => elbeardmorez/vim-loclist-follow
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:loclist_follow = 0
let g:loclist_follow_target = 'next'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>puremourning/vimspector 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimspector_enable_mappings = 'HUMAN'

nnoremap <silent> <leader>ve :vsplit<CR><C-W>l:e .vimspector.json<CR>
nmap <silent> <leader>dl :call vimspector#Launch()<CR>
nmap <silent> <leader>dr :call vimspector#Reset( { 'interactive': v:false } )<CR>
nmap <silent> <leader>dh :call vimspector#RunToCursor()<CR>
nmap <silent> <leader>dw :VimspectorWatch
nmap <silent> <leader>do :VimspectorShowOutput
nmap <silent> <leader>de <Plug>VimspectorBalloonEval
xmap <silent> <leader>de <Plug>VimspectorBalloonEval
nmap <silent> <leader>db :call vimspector#ToggleBreakpoint()<cr>
nmap <silent> <leader>dtc <Plug>VimspectorToggleConditionalBreakpoint()
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]

let g:vimspector_sign_priority = {
    \    'vimspectorBP':         30,
    \    'vimspectorBPCond':     20,
    \    'vimspectorBPLog':      20,
    \    'vimspectorBPDisabled': 10,
    \    'vimspectorPC':         999,
    \ }

" Custom mappings while debugging {{{
let s:mapped = {}

function! s:OnJumpToFrame() abort
  if has_key( s:mapped, string( bufnr() ) )
    return
  endif

  nmap <silent> <buffer> <leader>j <Plug>VimspectorStepOver
  nmap <silent> <buffer> <leader>l <Plug>VimspectorStepInto
  nmap <silent> <buffer> <leader>h <Plug>VimspectorStepOut
  nmap <silent> <buffer> <leader>dc :call vimspector#Continue()<cr>
  nmap <silent> <buffer> <leader>df :call vimspector#RunToCursor()<cr>

endfunction

function! s:OnDebugEnd() abort

  let original_buf = bufnr()
  let hidden = &hidden

  try
    set hidden
    for bufnr in keys( s:mapped )
      try
        execute 'noautocmd buffer' bufnr
        nunmap <silent> <buffer> <leader>j
        nunmap <silent> <buffer> <leader>l
        nunmap <silent> <buffer> <leader>h
        nunmap <silent> <buffer> <leader>dc
        nunmap <silent> <buffer> <leader>df

      endtry
    endfor
  finally
    execute 'noautocmd buffer' original_buf
    let &hidden = hidden
  endtry

  let s:mapped = {}
endfunction

augroup TestCustomMappings
  au!
  autocmd User VimspectorJumpedToFrame call s:OnJumpToFrame()
  autocmd User VimspectorDebugEnded call s:OnDebugEnd()
augroup END

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => markstory/vim-zoomwin 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>bm :ZoomToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Shougo/echodoc.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
    let g:echodoc#enable_at_startup = 1
    let g:echodoc#type = 'virtual'
    let g:echodoc#events = ['CompleteDone']
    "let g:echodoc#events = ['CursorMoved', 'CompleteDone']
else
    let g:echodoc#enable_at_startup = 0
    let g:echodoc#type = 'popup'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-test/vim-test
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:test#preserve_screen = 1
let test#strategy = {
  \ 'nearest': 'asyncrun_background',
  \ 'file':    'dispatch',
  \ 'suite':   'dispatch',
\}
let test#python#pytest#executable = 'python3 -m pytest'
let test#python#pytest#options = '--vim-quickfix'
"let test#python#runner = 'vimspectorpy'
autocmd FileType python nnoremap <silent> <leader>ta :TestSuite<CR>
autocmd FileType python nnoremap <silent> <leader>tl :TestNearest<CR>
autocmd FileType python nnoremap <silent> <leader>tf :TestFile<CR>
autocmd FileType python nnoremap <silent> <leader>tu :Ultest<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => weirongxu/plantuml-previewer.vim 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
    \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
    \  1,
    \  0
    \)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>jpalardy/vim-slime 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_python_ipython = 1
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}
let g:slime_no_mappings = 1
let g:slime_dont_ask_default = 1
nnoremap <silent> <Leader>rs :SlimeSend1 ipython --matplotlib<CR>
nnoremap <silent> <Leader>rc :IPythonCellExecuteCell<CR>
nnoremap <silent> <Leader>rq :SlimeSend1 exit<CR>
autocmd FileType python vmap <silent> <leader>cr <Plug>SlimeRegionSend 
autocmd FileType python nnoremap <silent> <Leader>cr :IPythonCellRun<CR>



let g:terminator_clear_default_mappings = 1
let g:terminator_split_fraction = 0.2
let g:terminator_split_location = 'botright'
"autocmd FileType python nnoremap <silent> <leader>co :TerminatorOpenTerminal<CR>
"autocmd FileType python nnoremap <silent> <leader>cr :TerminatorRunFileInOutputBuffer<CR>
"autocmd FileType python vnoremap <silent> <leader>cr :TerminatorSendSelectionToTerminal<CR>
"autocmd FileType python nnoremap <silent> <leader>cs :TerminatorStopRun <CR>

let g:terminator_runfile_map = {
            \ "javascript": "node",
            \ "python": "python3 -u",
            \ "go": "go run",
            \ "lua": "lua",
            \ "bash": "bash",
            \ "zsh": "zsh",
            \ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ms-jpq/coq_nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coq_settings = { 'auto_start': 'shut-up',
                     \ 'keymap.recommended': v:false, 
                     \ 'keymap.jump_to_mark': '<leader><tab>', 
                     \ 'clients.tree_sitter.enabled': v:false,
                     \ 'clients.tabnine.enabled': v:true,
                     \ 'clients.tags.enabled': v:false,
                     \ 'match.max_results': 10,
                     \ 'display.ghost_text.enabled': v:false}

inoremap <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
inoremap <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
"inoremap <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
inoremap <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nvim-lua/completion-nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd BufEnter * lua require'completion'.on_attach()
let g:completion_matching_strategy_list = ['exact', 'fuzzy']
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_matching_smart_case = 1
let g:completion_trigger_keyword_length = 1
let g:completion_timer_cycle = 100
let g:completion_enable_auto_paren = 0
let g:completion_enable_auto_hover = 0
let g:completion_enable_auto_signature = 0
let g:completion_sorting = "none"
"let g:completion_enable_auto_popup = 0
set completeopt=menuone,noinsert,noselect
set shortmess+=c
" Enable path completion
let g:completion_chain_complete_list = {
            \ 'default' : {
            \   'default': [
            \       {'complete_items': ['lsp', 'snippet', 'path']},
            \       {'mode': '<c-p>'},
            \       {'mode': '<c-n>'}],
            \   'comment': ['path'],
            \   'string' : [
            \       {'complete_items': ['path']}]
            \ } 
            \}

augroup CompletionTriggerCharacter
    autocmd!
    autocmd BufEnter * let g:completion_trigger_character = ['.', '/']
    autocmd Filetype python let g:completion_trigger_character = ['.', '/']
    autocmd Filetype cpp let g:completion_trigger_character = ['.', '/', '::', '->',]
    autocmd Filetype VimspectorPrompt let g:completion_trigger_character = ['.', '/', '::', '->',]
augroup end

highlight! DiagnosticDefaultError guifg=#db4b4b
highlight! DiagnosticDefaultWarn guifg=#e0af68
highlight! DiagnosticDefaultInfo guifg=#0db9d7
highlight! DiagnosticDefaultHint guifg=#10B981
highlight! DiagnosticUnderlineError guisp=#db4b4b gui=undercurl,bold
highlight! DiagnosticUnderlineWarn guisp=#e0af68 gui=undercurl,bold
highlight! DiagnosticUnderlineInfo guisp=#0db9d7 gui=undercurl,bold
highlight! DiagnosticUnderlineHint guisp=#10B981 gui=undercurl,bold

hi! link DiagnosticFloatingError DiagnosticDefaultError
hi! link DiagnosticFloatingWarn DiagnosticDefaultWarn
hi! link DiagnosticFloatingInfo DiagnosticDefaultInfo
hi! link DiagnosticFloatingHint DiagnosticDefaultHint
hi! link DiagnosticSignError DiagnosticDefaultError
hi! link DiagnosticSignWarn DiagnosticDefaultWarn
hi! link DiagnosticSignInfo DiagnosticDefaultInfo
hi! link DiagnosticSignHint DiagnosticDefaultHint

sign define DiagnosticSignError text=✖ texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text=⚠ texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text=⚠ texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text=⚠ texthl=DiagnosticSignHint linehl= numhl=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => mogelbrod/vim-jsonpath 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jsonpath_register = '*'
let g:jsonpath_delimeter = '.'
au FileType json nnoremap <buffer> <silent> <leader>pp :call jsonpath#echo()<CR>

au FileType Calltree nnoremap <buffer> <silent> <CR> :CTExpand<CR>
au FileType Calltree nnoremap <buffer> <silent> <S-CR> :CTJump<CR>
au FileType Calltree nnoremap <buffer> <silent> <leader>q :CTClose<CR>
