"""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python map <buffer> F :set foldmethod=indent<cr>

""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <C-t> $log();<esc>hi
au FileType javascript imap <C-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return 
au FileType javascript inoremap <buffer> $f // --- PH<esc>FP2xi

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


""""""""""""""""""""""""""""""
" => CoffeeScript section
"""""""""""""""""""""""""""""""
function! CoffeeScriptFold()
    setl foldmethod=indent
    setl foldlevelstart=1
endfunction
au FileType coffee call CoffeeScriptFold()

au FileType gitcommit call setpos('.', [0, 1, 1, 0])


""""""""""""""""""""""""""""""
" => Shell section
""""""""""""""""""""""""""""""
if exists('$TMUX') 
    if has('nvim')
        set termguicolors
    else
        set term=screen-256color 
    endif
endif


""""""""""""""""""""""""""""""
" => Twig section
""""""""""""""""""""""""""""""
autocmd BufRead *.twig set syntax=html filetype=html


""""""""""""""""""""""""""""""
" => Markdown
""""""""""""""""""""""""""""""
let vim_markdown_folding_disabled = 1


""""""""""""""""""""""""""""""
" => Qt
""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.qml set filetype=qml
au BufNewFile,BufRead *.qrc set filetype=xml


""""""""""""""""""""""""""""""
" => C++
""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.txx set filetype=cpp


""""""""""""""""""""""""""""""
" => Modelica
""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.mo  set filetype=modelica
au BufRead,BufNewFile *.mop set filetype=modelica

au BufRead,BufNewFile *.vf_json set filetype=json


""""""""""""""""""""""""""""""
" => Others
""""""""""""""""""""""""""""""
au BufRead,BufNewFile Jenkinsfile  set filetype=groovy
au BufRead,BufNewFile CMakeConfig.txt set filetype=cmake

""""""""""""""""""""""""""""""
" => Ros
""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.sdf set filetype=xml
au BufRead,BufNewFile *.world set filetype=xml
au BufRead,BufNewFile *.launch set filetype=xml
