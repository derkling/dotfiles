

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Intenting
set noexpandtab                         " use tabse, not spaces
set tabstop=8                           " tabstops of 8
set shiftwidth=8                        " indents of 8
set textwidth=78                        " screen in 80 columns wide, wrap at 78
set autoindent                          " turn on auto indenting
set smarttab                            " make <tab> and <backspace> smarter
set backspace=eol,start,indent          " allow backspacing over indent, eol, & start

nmap <C-J> vip=                         " forces (re)indentation of a block of code


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlighting
syn keyword cType uint ubyte ulong uint64_t uint32_t uint16_t uint8_t boolean_t int64_t int32_t int16_t int8_t u_int64_t u_int32_t u_int16_t u_int8_t
syn keyword cOperator likely unlikely
syn match ErrorLeadSpace /^ \+/         " highlight any leading spaces
syn match ErrorTailSpace / \+$/         " highlight any trailing spaces
syn match Error80        /\%>80v.\+/    " highlight anything past 80 in red

set formatoptions=tcqlron
set cinoptions=:0,l1,t0,g0


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Code Folding
set foldmethod=indent


"" GUI coloring
"highlight Pmenu ctermbg=green gui=bold
"highlight Pmenu ctermfg=black gui=bold


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compilation: save and make, clean-up
map gm <esc>:wa<cr><esc>:make<cr><cr><cr><cr><esc>:cw<cr>
map gc <esc>:make clean<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" QuickFix window: open (on errors), next error, previous error
map fw <esc>:cw<cr>
map fn <esc>:cn<cr>
map fp <esc>:cp<cr>

