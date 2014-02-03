
"----- LaTeX Mode Options
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Configuring latex compilation command line to support (shortcut: \ll)
:let g:Tex_CompileRule_dvi = 'latex -src-specials -interaction=nonstopmode $*'
" set the compilation target in the vim command line with:
" :TCTarget dvi
" Configuring DVI viewer (shortcup: \lv)
let g:Tex_ViewRule_dvi = 'evince'

" use either \gq or gqlp (mnenomic: gq LaTeX paragraph)
map \gq ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>gq//-1<CR>
omap lp ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>//-1<CR>.<CR>

" ListLaTeXSymbols binding
imap <F9> <Esc>:silent !lss &<cr>a

" Enable text wrapping
set tw=80

" Customize folding
" set b:Tex_FoldedEnvironments=",frame"

