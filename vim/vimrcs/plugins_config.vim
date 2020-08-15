""""""""""""""""""""""""""""""
" => Install using Vim-plug
""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview'
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'michaeljsmith/vim-indent-object'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/goyo.vim' " Distraction free writing
Plug 'amix/vim-zenroom2'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter' | Plug 'jasoncodes/ctrlp-modified.vim' | Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'hzchirs/vim-material'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'nvie/vim-flake8'
Plug 'kien/ctrlp.vim' | Plug 'JazzCore/ctrlp-cmatcher', {'do': './install.sh' }
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'vim-utils/vim-man'
Plug 'xolox/vim-notes' | Plug 'xolox/vim-misc' | Plug 'toddfoster/ctrlp-notes'

Plug 'skywind3000/asyncrun.vim'

Plug 'kkoomen/vim-doge'
Plug 'ycm-core/YouCompleteMe', {'do': './install.py --clang-completer --clangd-completer'}  
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'jeaye/color_coded', {'do': 'rm -f CMakeCache.txt && cmake . && make -j4 && make install'}
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ilyachur/cmake4vim' | Plug 'tpope/vim-dispatch'
Plug 'suy/vim-qmake'
Plug 'peterhoeg/vim-qml'

Plug 'ludovicchabant/vim-gutentags' | Plug 'skywind3000/gutentags_plus'

Plug 'rhysd/vim-clang-format' | Plug 'Shougo/vimproc.vim', {'do' : 'make'}

Plug 'preservim/nerdtree'
Plug 'thaerkh/vim-workspace'

" Plugin 'vim-syntastic/syntastic'
" Plugin 'xolox/vim-misc'
" Plugin 'xolox/vim-easytags'
" Plugin 'majutsushi/tagbar'
" Plugin 'vim-scripts/a.vim' 
" Plugin 'Raimondi/delimitMate' 
" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
" Plugin 'nathanaelkane/vim-indent-guides'

call plug#end()

""""""""""""""""""""""""""""""
" => Gutentags
""""""""""""""""""""""""""""""
let g:gutentags_define_advanced_commands = 1
" remove auto maps
let g:gutentags_plus_nomap = 1

" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']
"let g:gutentags_modules = ['ctags']

" config project root markers.
let g:gutentags_project_root = ['.git', '.root']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ '--c++-kinds=+p',
      \ '--extra=+q',
      \ '--language-force=C++'
      \ ]

if executable('rg')
  let g:gutentags_file_list_command = 'rg --files'
endif

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

""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
let g:yankstack_yank_keys = ['y', 'd']

nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-n> <Plug>yankstack_substitute_newer_paste


""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_by_filename = 1
let g:ctrlp_extensions = ['notes']

let g:ctrlp_map = '<C-f>'
map <leader>lf :CtrlP<cr>
map <leader>lr :CtrlPMRU<CR>
map <leader>lb :CtrlPBuffer<cr>
map <leader>ls :CtrlPTag<cr>
map <leader>ln :CtrlPNotes<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = {
  \ 'dir':  'build\|node_modules\|^\.DS_Store\|\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

let g:ctrlp_use_caching=1
let g:ctrlp_cache_dir = expand('~/.cache/ctrlp')
" For really fast searchin
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
"let g:ctrlp_lazy_update = 1


""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let NERDTreeQuitOnOpen=1
" Auto close vim if NERDTree is only open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinSize=35
map <leader>t :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-s>'
let g:multi_cursor_select_all_word_key = '<A-s>'
let g:multi_cursor_start_key           = 'g<C-s>'
let g:multi_cursor_select_all_key      = 'g<A-s>'
let g:multi_cursor_next_key            = '<C-s>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'


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
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
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
nnoremap <silent> <leader>z :Goyo<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ale (syntax checker and linter)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
\   'javascript': ['jshint'],
\   'python': ['flake8'],
\   'go': ['go', 'golint', 'errcheck']
\}

nmap <silent> <leader>a <Plug>(ale_next_wrap)

" Disabling highlighting
let g:ale_set_highlights = 0

" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-clang-format
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:clang_format#detect_style_file = 1
"let g:clang_format#auto_format_on_insert_leave = 1
let g:clang_format#style_options = {
 \ "BasedOnStyle": "LLVM",
 \ "IndentWidth":  4
 \ }

autocmd FileType c,cpp nnoremap <buffer><Leader>cl :<C-u>ClangFormat<CR>
autocmd FileType c,cpp vnoremap <buffer><Leader>cl :ClangFormat<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=0
let g:gitgutter_highlight_lines = 1
let g:gitgutter_map_keys = 0

highlight! link GitGutterAdd SignColumn
highlight! link GitGutterChange SignColumn
highlight! link GitGutterDelete SignColumn

map <silent> ]h <Plug>(GitGutterNextHunk)
map <silent> [h <Plug>(GitGutterPrevHunk)
map <silent> <leader>hs <Plug>(GitGutterStageHunk)
map <silent> <leader>hu <Plug>(GitGutterUndoHunk)
map <silent> <leader>hp <Plug>(GitGutterPreviewHunk)
omap <silent> ih <Plug>(GitGutterTextObjectInnerPending)
omap <silent> ah <Plug>(GitGutterTextObjectOuterPending)
xmap <silent> ih <Plug>(GitGutterTextObjectInnerVisual)
xmap <silent> ah <Plug>(GitGutterTextObjectOuterVisual)
nnoremap <silent> <leader>d :GitGutterToggle<cr>
" Usually you don't need to have list of all hunks, but better list of modified files
"nnoremap <silent> <leader>hl :GitGutterQuickFix<cr>:copen<cr>:cd `git rev-parse --show-toplevel`<cr>
" Even better with Fuzzy Finding )
nnoremap <silent> <leader>hl :CtrlPModified<cr>

map <silent> <leader>gs :Gstatus<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-material
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:material_style='palenight'
set background=light
try
   colorscheme vim-material
   highlight! link SignColumn Conceal

   autocmd FileType cpp call s:cpp_highlight_settings()
   function! s:cpp_highlight_settings()
       highlight! Variable guifg=foreground
       highlight! link cppStructure javascriptFuncKeyword
       highlight! link cStructure javascriptFuncKeyword
       highlight! link Member javascriptMethod
       highlight! link Type jsFuncBraces
       highlight! link cppExceptions cppModifier
       highlight! link cppModifier cppStorageClass
       highlight! link cStorageClass cppStorageClass
       highlight! link cppStorageClass jsClassDefinition
       highlight! link Namespace Identifier
       highlight! link ClassDecl Identifier
    endfunction

   "hi Type guifg=purple
   "highlight! link Member javascriptIdentifierName 
   "highlight! link Variable javascriptIdentifierName 
   "highlight! link Namespace javascriptIdentifierName 
   "hi EnumConstant
   "highlight! link StructDecl Function
   "highlight! link UnionDecl Function
   "highlight! link ClassDecl Function
   "highlight! link EnumDecl Function
catch
endtry


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => scrooloose/nerdcommenter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDCreateDefaultMappings = 0
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lervag/vimtex
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ilyachur/cmake4vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cmake_compile_commands=1
let g:asyncrun_open = 8

nmap <silent> <leader>cb :CMakeBuild<cr>
nmap <silent> <leader>cc :CMakeClean<cr>
nmap <silent> <leader>ct :CtrlPCMakeTarget<cr>
function! RunProgram()
    if !exists('g:cmake_build_target')
        echom "Please select target first"
        return
    endif
    let s:exec_path = findfile(g:cmake_build_target, cmake4vim#DetectBuildDir())
    if strlen(s:exec_path)
        execute 'AsyncRun ' . s:exec_path
    else
        echom "Target in not runnable"
    endif
endfunction
nmap <silent> <leader>cr :call RunProgram()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vhdirk/vim-cmake
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ycm-core/YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup MyYCMCustom
    let g:ycm_filetype_whitelist= { 'c': 1, 
                                  \ 'cpp': 1,
                                  \ 'python': 1
                                  \ }
    let g:ycm_add_preview_to_completeopt = 1
    let g:ycm_key_invoke_completion = '<C-Space>'
    let g:ycm_key_list_select_completion = ['<TAB>', '<Enter>']
    let g:ycm_semantic_triggers =  {
      \   'c,cpp,objc,python': [ 're!\w{4}', '_'  ],
      \ }
    set completeopt+=popup
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_python_binary_path = '/bin/python3'
    let g:ycm_clangd_binary_path= 'clangd'
    let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf/ycm_extra_conf.py'

    let g:ycm_key_list_select_completion=[]
    let g:ycm_key_list_previous_completion=[]
    "let g:ycm_echo_current_diagnostic=0

    let g:UltiSnipsEditSplit='horizontal'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<S-tab>'


  autocmd!
  autocmd FileType c,cpp,python let b:ycm_hover = {
    \ 'command': 'GetDoc',
    \ 'syntax': &filetype
    \ }
    let g:ycm_auto_hover=''
    nmap <leader>dt <plug>(YCMHover)
augroup END

nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <silent> <leader>rr :YcmCompleter RefactorRename 

nnoremap <silent> <leader>ft :YcmCompleter FixIt<CR>

set updatetime=250

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => xolox/vim-notes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.txt'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => kkoomen/vim-doge
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:doge_enable_mappings=0
let g:doge_doc_standard_cpp='doxygen_qt'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => thaerkh/vim-workspace
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:workspace_session_directory = $HOME . '/.vim/temp_dirs/sessions/'
let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0
