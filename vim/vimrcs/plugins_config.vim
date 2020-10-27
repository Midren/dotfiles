""""""""""""""""""""""""""""""
" => Install using Vim-plug
""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')

"""""""""""""""""""""""""""""
" => Lookie
"""""""""""""""""""""""""""""
Plug 'hzchirs/vim-material'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

""""""""""""""""""""""""""""""
" => Development
""""""""""""""""""""""""""""""
" ==> Completition
Plug 'ycm-core/YouCompleteMe', {'do': './install.py --clang-completer --clangd-completer'} | Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips' | Plug 'dimatura/ultisnip-snippets'
Plug 'derekwyatt/vim-fswitch'
Plug 'derekwyatt/vim-protodef', { 'for': ['c', 'cpp', 'objc'] }

" ==> Navigating
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } | Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'ludovicchabant/vim-gutentags' | Plug 'skywind3000/gutentags_plus'
Plug 'mileszs/ack.vim' | Plug 'jesseleite/vim-agriculture'
Plug 'chaoren/vim-wordmotion'                

" ==> Linting
Plug 'dense-analysis/ale'
Plug 'rhysd/vim-clang-format' | Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" ==> Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'oguzbilgic/vim-gdiff'

" ==> Misc
Plug 'ilyachur/cmake4vim' | Plug 'tpope/vim-dispatch'
Plug 'scrooloose/nerdcommenter'
Plug 'kkoomen/vim-doge',                    " Doxygen documentation
    \{ 'do': { -> doge#install() } } 
Plug 'sheerun/vim-polyglot'                 " Syntax highlightning
Plug 'jeaye/color_coded',                   " Semantic syntax highlightling
     \{'do': 'rm -f CMakeCache.txt && cmake . && make -j4 && make install'}
Plug 'thaerkh/vim-workspace'                " Intersession open buffers saving
Plug 'maxbrunsfeld/vim-yankstack'           " Easier management of clipboard
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'weirongxu/plantuml-previewer.vim' | Plug 'tyru/open-browser.vim'
Plug 'hrsh7th/vim-eft'

"""""""""""""""""""""""""""""
" => Writing
"""""""""""""""""""""""""""""
Plug 'lervag/vimtex'
Plug 'plasticboy/vim-markdown'
Plug 'aserebryakov/vim-todo-lists'
Plug 'junegunn/goyo.vim' | Plug 'amix/vim-zenroom2' | Plug 'junegunn/limelight.vim'
"""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""
Plug 'skywind3000/asyncrun.vim'
Plug 'markonm/traces.vim' " Highlighting default ex substitute
Plug 'tpope/vim-repeat'

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

let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ '--c++-kinds=+p',
      \ '--extra=+q',
      \ '--languages=C++,Python,C,vim'
      \ ]

if executable('ag')
  let g:gutentags_file_list_command = 'ag -g ""'
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
" => junegunn/fzf
""""""""""""""""""""""""""""""
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.4 } }
let $FZF_DEFAULT_COMMAND='ag -g ""'
let $FZF_DEFAULT_OPTS="--reverse --bind ctrl-a:select-all"
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

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

nnoremap <leader>lf :Files<cr>
nnoremap <leader>lg :GFiles?<cr>
nnoremap <leader>lr :History<CR>
nnoremap <leader>lb :Buffers<cr>
nnoremap <leader>ll :BTags<cr>
nnoremap <leader>ls :Tags<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => mileszs/ack.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the the_silver_searcher if possible (much faster than Ack)
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position
map <leader>fd :Ag<cr>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

nnoremap ]q :cn<cr>
nnoremap [q :cp<cr>

" Make sure that enter is never overriden in the quickfix window
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" When using `dd` in the quickfix list, remove the item from the quickfix list.
" https://stackoverflow.com/questions/42905008/quickfix-list-how-to-add-and-remove-entries

function! RemoveQuickfixItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1
endfunction

autocmd FileType qf map <buffer> dd :call RemoveQuickfixItem()<cr>


""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
" Auto close vim if NERDTree is only open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinSize=35
map <leader>nt :NERDTreeToggle<cr>
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
let g:clang_format#auto_formatexpr = 0
let g:clang_format#style_options = {
 \ "BasedOnStyle": "LLVM",
 \ "IndentWidth":  4
 \ }

autocmd FileType c,cpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp vnoremap <buffer><Leader>cf :ClangFormat<CR>


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

autocmd CursorMoved * if s:in_last_hunk_line(line(".")) | GitGutterPreviewHunk | else | pclose | endif

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
nnoremap <silent> <leader>df :GitGutterToggle<cr>
" Usually you don't need to have list of all hunks, but better list of modified files
"nnoremap <silent> <leader>hl :GitGutterQuickFix<cr>:copen<cr>:cd `git rev-parse --show-toplevel`<cr>
" Even better with Fuzzy Finding )
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gc :GBranches<CR>
nnoremap <silent> <leader>gs :Gstatus<cr>:resize 12<cr>

nmap <leader>gf :diffget //2<cr>
nmap <leader>gj :diffget //3<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-material
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:material_style='palenight'
set background=light
try
   colorscheme vim-material
   highlight! link SignColumn Conceal

   autocmd FileType c,cpp call s:cpp_highlight_settings()
   function! s:cpp_highlight_settings()
       highlight! link cBlock cppBlock
       highlight! link cppBlock Type
       highlight! link cppExceptions cppModifier
       highlight! link cppModifier cppStorageClass
       highlight! link cStorageClass cppStorageClass
       highlight! link cppStorageClass javascriptClassSuperName
       highlight! link FunctionDecl javascriptFuncKeyword
       highlight! link CXXMethod javascriptMethod
       highlight! link Variable Normal
       highlight! link EnumConstant Member
       highlight! link Member javascriptProperty
       highlight! link Namespace ClassDecl
       highlight! link StructDecl ClassDecl
       highlight! link UnionDecl ClassDecl
       highlight! link EnumDecl ClassDecl
       highlight! link ClassDecl javascriptClassName
       highlight! link cStructure cppStructure
       highlight! link cppStructure javascriptOperator
       highlight! link NamespaceRef Type
       highlight! link TypeRef javascriptVariable
       highlight! link cParen javascriptBraces
       highlight! link cppType Type
    endfunction
catch
endtry

function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map gm :call SynStack()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => scrooloose/nerdcommenter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDCreateDefaultMappings = 0
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ilyachur/cmake4vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cmake_compile_commands=1
let g:asyncrun_open = 8

nnoremap <silent> <leader>cb :CMakeBuild<cr>
nnoremap <silent> <leader>cc :CMakeClean<cr>
nnoremap <silent> <leader>ct :FZFCMakeSelectTarget<cr>
function! RunProgram()
    if !exists('g:cmake_build_target')
        echom "Please select target first"
        return
    endif
    let s:exec_path = findfile(g:cmake_build_target, utils#cmake#getBuildDir())
    if strlen(s:exec_path)
        execute 'AsyncRun ' . s:exec_path
    else
        echom "Target in not runnable"
    endif
endfunction
nnoremap <silent> <leader>cr :call RunProgram()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ycm-core/YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup MyYCMCustom
    let g:ycm_add_preview_to_completeopt = 1
    let g:ycm_key_invoke_completion = '<C-Space>'
    let g:ycm_key_list_stop_completion = ['<C-y>', '<Esc>']

    let g:ycm_semantic_triggers =  {
      \   'c,cpp': [ 're!\w{3}', '_', '.', '->', '::' ],
      \   'python': [ 're!\w{3}', '_'  ],
      \ }
    set completeopt+=popup
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_python_binary_path = '/usr/bin/python3'
    let g:ycm_clangd_binary_path= 'clangd'
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf/ycm_extra_conf.py'
    let g:ycm_confirm_extra_conf = 0

    let g:ycm_key_list_select_completion = []
    let g:ycm_key_list_previous_completion = []
    let g:ycm_key_detailed_diagnostics = ''
    "let g:ycm_echo_current_diagnostic=0
    
    " Enable tabbing through list of results
    function! g:UltiSnips_Complete()
        call UltiSnips#ExpandSnippet()
        if g:ulti_expand_res == 0
            if pumvisible()
                return "\<C-n>"
            else
                call UltiSnips#JumpForwards()
                if g:ulti_jump_forwards_res == 0
                   return "\<tab>"
                endif
            endif
        endif
        return ""
    endfunction

    let g:UltiSnipsExpandTrigger = "<nop>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
    let g:ulti_expand_or_jump_res = 0
    function ExpandSnippetOrCarriageReturn()
        let snippet = UltiSnips#ExpandSnippet()
        if g:ulti_expand_res > 0
            return snippet
        else
            return pumvisible() ? "\<C-y>" : "\<CR>"
        endif
    endfunction

    inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

    autocmd!
    autocmd FileType c,cpp let b:ycm_hover = {
      \ 'command': 'GetDoc',
      \ 'syntax': &filetype
      \ }
    let g:ycm_auto_hover=''
augroup END

nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <C-LeftMouse> <LeftMouse>:YcmCompleter GoTo<CR>
nnoremap <silent> <leader>fr :YcmCompleter GoToReferences<CR>
nnoremap <silent> <leader>rr :YcmCompleter RefactorRename 
nnoremap <silent> <leader>ft :YcmCompleter FixIt<CR>
nmap <silent> <leader>dt <plug>(YCMHover)

set updatetime=250

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => xolox/vim-notes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.md'
autocmd FileType notes iabbrev <buffer> ЕЩВЩ TODO
autocmd FileType notes iabbrev <buffer> ВЩТУ DONE
autocmd FileType notes iabbrev <buffer> ЧЧЧ XXX

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
" => derekwyatt/vim-fswitch
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quick switch between header and source file
nnoremap <silent> <F4> :FSHere<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => chaoren/vim-wordmotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:wordmotion_disable_default_mappings=1
nmap W          <Plug>WordMotion_w
nmap E          <Plug>WordMotion_e
nmap B          <Plug>WordMotion_b
omap aW         <Plug>WordMotion_aw
omap iW         <Plug>WordMotion_iw

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => hrsh7th/vim-eft
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ; <Plug>(eft-repeat)
xmap ; <Plug>(eft-repeat)

nmap f <Plug>(eft-f)
xmap f <Plug>(eft-f)
omap f <Plug>(eft-f)
nmap F <Plug>(eft-F)
xmap F <Plug>(eft-F)
omap F <Plug>(eft-F)

nmap t <Plug>(eft-t)
xmap t <Plug>(eft-t)
omap t <Plug>(eft-t)
nmap T <Plug>(eft-T)
xmap T <Plug>(eft-T)
omap T <Plug>(eft-T)
