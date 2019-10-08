
call plug#begin('~/dotfiles/nvim/plugged')

Plug 'vim-scripts/molokai'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plug 'vim-scripts/ShowTrailingWhitespace'
" Plug 'vim-scripts/DeleteTrailingWhitespace'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Plug 'vim-scripts/tComment'

" Plug 'easymotion/vim-easymotion'

" Plug 'cazador481/fakeclip.neovim'

" Plug 'msanders/snipmate.vim'
" Plug 'xolox/vim-misc.git'
" Plug 'xolox/vim-session'
" Plug 'https://github.com/Lokaltog/vim-powerline'
" Plug 'Lokaltog/powerline-fonts'
" Plug 'edkolev/tmuxline.vim'
" Plug 'majutsushi/tagbar'
" Plug 'dkprice/vim-easygrep'
" Plug 'derkling/cscope.vim'
" Plug 'DoxygenToolkit.vim'
" Plug 'scrooloose/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'
" Plug 'scrooloose/syntastic'
" Plug 'tpope/vim-fugitive'
" Plug 'jreybert/vimagit'
" Plug 'airblade/vim-gitgutter'
" Plug 'mattn/webapi-vim'
" Plug 'mattn/gist-vim'
" Plug 'vim-scripts/indentpython.vim'
" Plug 'tmhedberg/SimpylFold.git'
" Plug 'derkling/vim-makesetup'
" Plug 'powerman/vim-plugin-viewdoc'
" Plug 'vim-latex/vim-latex.github.com.git'
" Plug 'davidoc/taskpaper.vim'
" Plug 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}

" MORE_UP_HERE

" " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'
"
" " Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
" " Group dependencies, vim-snippets depends on ultisnips
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
" " On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
" " Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
" " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
"
" " Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
" " Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
" " Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" Add plugins to &runtimepath
call plug#end()



" Colors and GUI {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plug: vim-scripts/molokai {{{
" Molokai
" Molokai is a Vim port of the monokai theme for TextMate originally created
" by Wimer Hazenberg.
colorscheme molokai
"}}}

" Plug air-line/air-line {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:airline_theme='molokai'
let g:airline_theme='wombat'
let g:airline_left_sep=''
let g:airline_right_sep=''
" }}}

" Other Color Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set background=dark
set laststatus=2
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors
"}}}

" }}}

" " Line numbering {{{
" """"""""""""""""""""""""""
"
" " Default layout and coloring
" :set numberwidth=5	" change the width of the 'gutter' column used for numbering
" :set cpoptions+=n	" use the number column for the text of wrapped lines
" :highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
"
" " State machine to switch between:
" " nonumbers, absolute numbers and relative numbers
" :set number
" :set norelativenumber
" :let b:lnmode=3
" function! NumberToggle()
"     if(b:lnmode==3)
"         set nonumber
" 	set norelativenumber
" 	let b:lnmode=1
" 	" echo "Line numbering mode: no numbers"
" 	return
"     endif
"     if(b:lnmode == 1)
"         set number
" 	set norelativenumber
" 	let b:lnmode=2
" 	" echo "Line numbering mode: absolute numbers"
" 	return
"     endif
"     if(b:lnmode == 2)
"         set number
" 	set relativenumber
" 	let b:lnmode=3
" 	" echo "Line numbering mode: relative numbers"
" 	return
"     endif
" endfunc
" nnoremap <C-n> :call NumberToggle()<CR>
"
" " Set detfaults line numbers status
" function! SetRelative()
" 	set number
" 	set relativenumber
" 	let b:lnmode=3
" 	echo "Line numbering mode: relative numbers"
" endfunc
" function! SetAbsolute()
" 	set number
" 	set norelativenumber
" 	let b:lnmode=2
" 	echo "Line numbering mode: absolute numbers"
" endfunc
" :autocmd BufLeave * call SetAbsolute()
" :autocmd BufEnter * call SetRelative()
" :autocmd InsertEnter * call SetAbsolute()
" :autocmd InsertLeave * call SetRelative()
"
" "}}}
"
" " Trailing whitespaces {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" " Plug: vim-scripts/Shorthand {{{2
" " http://www.vim.org/scripts/script.php?script_id=3966
" highlight ShowTrailingWhitespace ctermbg=Blue guibg=Blue
" nnoremap <silent> <Leader>tw
" 	\ :<C-u>call ShowTrailingWhitespace#Toggle(0) <Bar>
" 	\ echo (ShowTrailingWhitespace#IsSet()
" 		\ ? 'Show trailing whitespace'
" 		\ : 'Not showing trailing whitespace'
" 	\ )<CR>
" " }}}
"
" " Plug: vim-scripts/DeleteTrailingWhitespace {{{2
" " http://www.vim.org/scripts/script.php?script_id=3967
" let g:DeleteTrailingWhitespace = 0
" let g:DeleteTrailingWhitespace_Action = 'ask'
" let g:DeleteTrailingWhitespace_ChoiceAffectsHighlighting = 1
" nnoremap <Leader>dw :<C-u>%DeleteTrailingWhitespace<CR>
" vnoremap <Leader>dw :DeleteTrailingWhitespace<CR>
" " }}}
"
" " }}}
"
" " Plug: vim-scripts/tComment {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nnoremap // :TComment<CR>
" vnoremap // :TComment<CR>
" " }}}
"
" " Plug: easymotion/vim-easymotion {{{
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
" let g:EasyMotion_smartcase = 1   " Case insensitivity
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
" map <Leader>l <Plug>(easymotion-lineforward)
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)
" map <Leader>h <Plug>(easymotion-linebackward)
" " "}}}

" Plug: junegunn/fzf {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~25%' }

" " In Neovim, you can set up fzf window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }

" This will split only under the current window.
let g:fzf_layout = { 'window': '10 split | enew'}

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Open file in current buffer
nnoremap <silent> <Leader>zx :call fzf#run({
\				'down': '40%',
\				'sink': 'e'
\				})<CR>
" Open file in horizontal split
nnoremap <silent> <Leader>s :call fzf#run({
\				'down': '40%',
\				'sink': 'botright split'
\				})<CR>
" Open file in vertical split
nnoremap <silent> <Leader>v :call fzf#run({
\				'right': winwidth('.') / 2,
\				'sink': 'vertical botright split'
\				})<CR>

" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


" " Normal, Visual and Operator-pending mappings
" " nmap <leader><tab> <plug>(fzf-maps-n)
" " xmap <leader><tab> <plug>(fzf-maps-x)
" " omap <leader><tab> <plug>(fzf-maps-o)
" "
" " Normal mode mappings
" nmap <leader>zx <plug>(fzf-complete-file)
" nmap <leader>zd <plug>(fzf-complete-path)
" 
" " Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-j> <plug>(fzf-complete-file-ag)
" imap <c-x><c-l> <plug>(fzf-complete-line)
" 
" " Advanced customization using autoload functions
" inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" }}}

" " Command-T {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " let g:CommandTMatchWindowAtTop=1 " show window at top
" " set the PmenuSel color to be visible with black background
" highlight PmenuSel ctermfg=black ctermbg=white
" " Setup mappings for CommandT
" nnoremap <silent> <leader>zx :CommandT<CR>
" nnoremap <silent> <leader>zb :CommandTBuffer<CR>
" nnoremap <silent> <leader>zm :CommandTMRU<CR>
" nnoremap <silent> <leader>zt :CommandTTag<CR>
" " }}}


" " Plug: cazador481/fakeclip.neovim {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:vim_fakeclip_tmux_plus=1





" GIT Mappings
nnoremap <Leader>gs o<Esc>0DiSigned-off-by: Patrick Bellasi <patrick.bellasi@arm.com><CR><Esc>kO

" Abbreviations, completed after <space>
" NOTE: use CTRL+V after the abbrevation to avoid to triggher the completion
:ab soff Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
:ab email patrick.bellasi@arm.com





























" " SnipMate {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:snips_author = 'Patrick Bellasi'
" ino  <C-j> <C-r>=TriggerSnippet()<cr>
" "}}}



" " Sessions Management {{{
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Other interesting plugins from xolox:
" " http://www.vim.org/scripts/script.php?script_id=4597
" " }}}


" " TMuxLine {{{
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:airline#extensions#tmuxline#snapshot_file = '~/dotfiles/tmux/tmux-statusline-colors.conf'
" let g:tmuxline_separators = {
"     \ 'left' : '',
"     \ 'left_alt': '>',
"     \ 'right' : '',
"     \ 'right_alt' : '<',
"     \ 'space' : ' '}
" " }}}


" " CTags SideBar {{{
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:airline#extensions#tagbar#enabled = 1
" " }}}


" " EasyGrep - Fast and Easy Find and Replace Across Multiple Files {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Default mappings:
" "   <Leader>vv  - Grep for the word under the cursor, match all occurences,
" "   <Leader>vV  - Grep for the word under the cursor, match whole word, like
" "   <Leader>va  - Like vv, but add to existing list
" "   <Leader>vA  - Like vV, but add to existing list
" "   <Leader>vr  - Perform a global search search on the word under the cursor
" "                 and prompt for a pattern with which to replace it.
" "   <Leader>vo  - Select the files to search in and set grep options
" noremap <leader>go <esc>:GrepOption<cr>
" nnoremap go :GrepOption<cr>
" " }}}


" " QuickFix window management {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" noremap <leader>fo <esc>:copen<cr>
" noremap <leader>fc <esc>:cclose<cr>
" noremap <leader>fn <esc>:cnext<cr>
" noremap <leader>fp <esc>:cprevious<cr>
" nnoremap fo :copen<cr>
" nnoremap fc :cclose<cr>
" nnoremap fn :cnext<cr>
" nnoremap fp :cprevious<cr>
"  " }}}


" " CScope {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " }}}


" " Doxygen {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map <LocalLeader>d :Dox<CR>
" map <LocalLeader>d :Dox<CR>
" " }}}


" " NERDTree {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " https://github.com/jistr/vim-nerdtree-tabs/blob/master/README.md
" noremap <silent> <F12> :NERDTreeToggle<CR>
" noremap! <silent> <F12> <ESC>:NERDTreeToggle<CR>
" let g:NERDTreeDirArrows=0 " use ASCII chars
" " }}}


" " Syntax and errors highlighter {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " External language specific syntax checkers are required, look at:
" " syntax_checkers/<filetype>/*.vim
" let g:syntastic_c_compiler_options=' -std=gnu89 -Wno-variadic-macros'
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" " let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]
" let g:airline#extensions#whitespace#checks = []
" let g:airline#extensions#syntastic#enabled = 1
" let g:airline#extensions#tabline#buffer_idx_mode = 1
" " }}}


" " GIT Fugitive {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " }}}


" " Magit {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " }}}


" " Show GIT diff in the 'gutter' (sign column) {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nnoremap <Leader>tg  :GitGutterToggle<CR>
" nnoremap <Leader>tgh :GitGutterLineHighlightsToggle<CR>
" nnoremap <Leader>dgs :GitGutterStageHunk<CR>
" nnoremap <Leader>dgr :GitGutterRevertHunk<CR>
" let g:airline#extensions#hunks#enabled = 1
" " }}}


" " Github GIST {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:gist_detect_filetype = 1
" let g:gist_open_browser_after_post = 1
" let g:gist_browser_command = 'chromium-browser %URL%'
" let g:gist_post_private = 1
" " }}}


" " Python Code folding {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:SimpylFold_docstring_preview = 1
" let g:SimpylFold_fold_docstring = 0
" " }}}


" " MakeSetup {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd QuickFixCmdPost [^l]* nested cwindow
" autocmd QuickFixCmdPost    l* nested lwindow
" " }}}


" " Documentation viewer {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:viewdoc_open='new'
" let g:viewdoc_only=1
" " }}}


" " LaTeX {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd BufEnter *.tex,*.bib source ~/dotfiles/vim/plugins/latex.vim
" " }}}


" " TaskPaper {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd BufEnter *.taskpaper set filetype=taskpaper
" let g:task_paper_date_format = "%Y-%m-%d %H:%M:%S%z"
" let g:task_paper_archive_project = "Completed"
" let g:task_paper_styles = {
" 	\ 'waiton': 'ctermfg=Yellow guifg=Yellow',
" 	\ 'next': 'ctermbg=Red guibg=Red',
" 	\ }
" " Add function to setup custom commands
" function! s:taskpaper_setup()
" " URGENT: update task 'urgent' level
" nnoremap <buffer> <silent> <Leader>tu
" 	\ :<C-u>call taskpaper#toggle_tag('urgent')<CR>
" " WAITON toggle the 'waiton' TAG
" nnoremap <buffer> <silent> <Leader>tw
" 	\ :<C-u>call taskpaper#toggle_tag('waiton', '')<CR>
" endfunction
" " Load custom commands for all taskpaper files
" augroup vimrc-taskpaper
" autocmd!
" autocmd FileType taskpaper call s:taskpaper_setup()
" augroup END
" " }}}


" " Global Configuration {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " This MUST be the last entry BEFORE the following custom configuration
" filetype plugin indent plugin on
" " }}}


" " Confiugrations which cause vim to behave a lot differently from regular Vi {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set nocompatible	" vim defaults, not vi!
" set showcmd		" Show (partial) command in status line.
" set showmatch		" Show matching brackets.
" set ignorecase		" Do case insensitive matching
" set smartcase		" Do smart case matching
" set autowrite		" Automatically save before commands like :next and :make
" set hidden		" Hide buffers when they are abandoned
" set ttymouse=xterm2     " Enable mouse usage on screen terminal emulator
" set mouse=a		" Enable mouse usage (all modes) in terminals
" set nobackup		" Disable creation of backup (*.ext~) files
" set laststatus=2	" Always show the statusline
" set encoding=utf-8	" Necessary to show Unicode glyphs
" " }}}


" " Set GVim configuration {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if has("gui_running")
" 	if has("gui_gtk2")
" 		set guifont=Monospace\ 8 " Set 8pt font
" 		set lines=75 columns=180 " Maximize window
" 	endif
" endif
" " }}}


" " Jump to the last position when reopening a file {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"     \| exe "normal! g'\"" | endif
" " }}}


" " Incremental search with results highlight {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set incsearch
" set hlsearch
" " Ctrl-L clears the highlight from the last search
" noremap  <C-l> :nohlsearch<CR><C-l>
" noremap! <C-l> <ESC>:nohlsearch<CR><C-l>
" " }}}


" " Smart backspace {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set backspace=start,indent,eol
" " }}}


" " Better TAB completion for files (like the shell) {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if has("wildmenu")
"     set wildmenu
"     set wildmode=longest,list
"     " Ignore stuff (for TAB autocompletion)
"     set wildignore+=*.a,*.o
"     set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
"     set wildignore+=.DS_Store,.git,.hg,.svn
"     set wildignore+=*~,*.swp,*.tmp
" endif
" " }}}


" " TAB and Shift-TAB in command mode cycle buffers {{{
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "nmap <Tab>   :bn<CR>
" "nmap <S-Tab> :bp<CR>
" " }}}


" " Resize vsplit panes on VIM window resize events {{{
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd VimResized * exe "normal! \<c-w>="
" " Easier split navigation
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>
" " More natural split opening
" set splitbelow
" set splitright
" " }}}


" Function KEYs Mapping {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" " F2 - Toggle auto-indenting for code paste {{{2
" """""""""""""""""""""""""""""""""""""""""""
" " pressing F2 in normal mode will invert the 'paste' option
" nnoremap <F2> :set invpaste paste?<CR>
" " press F2 when in insert mode, to toggle 'paste' on and off
" set pastetoggle=<F2>
" " enables displaying whether 'paste' is turned on in insert mode
" set showmode
"
"
" " F3 - Toggle text wrapping {{{2
" """"""""""""""""""""""""""""""""
" noremap <F3> :set nowrap!<CR>


" " F5 - Remove thrailing whitespaces {{{2
" """"""""""""""""""""""""""""""""""""""""
" noremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
"
"
" " F6 - Highlight all instances of word under cursor, when idle. {{{2
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function! AutoHighlightToggle()
"   let @/ = ''
"   if exists('#auto_highlight')
"     au! auto_highlight
"     augroup! auto_highlight
"     setl updatetime=4000
"     echo 'Highlight current word: off'
"     return 0
"   else
"     augroup auto_highlight
"       au!
"       au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
"     augroup end
"     setl updatetime=500
"     echo 'Highlight current word: ON'
"     return 1
"   endif
" endfunction
" nnoremap <F6> :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
"
"
" " F7 - Spell Checking with multi-language support {{{2
" """"""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:myLang=0
" let g:myLangList=["nospell","en_us","en_gb","it"]
" function! ToggleSpell()
" 	let g:myLang=g:myLang+1
" 	if g:myLang>=len(g:myLangList) | let g:myLang=0 | endif
" 	if g:myLang==0
" 		setlocal nospell
" 	else
" 		execute "setlocal spell spelllang=".get(g:myLangList, g:myLang)
" 	endif
" 	echo "spell checking language:" g:myLangList[g:myLang]
" endfunction
" nnoremap <silent> <F7> :call ToggleSpell()<CR>
"
"
" " F8 - Toggle CTags bar {{{2
" """"""""""""""""""""""""""""
" nnoremap <F8> :TagbarToggle<CR>


"}}}


" " Filetype Specific Configurations {{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" " Makefiles {{{2
" """"""""""""""""
" autocmd FileType make setlocal noexpandtab
"
" " C/C++ {{{2
" """"""""""""
" autocmd BufRead *.c,*.h,*.cc,*.hh,*.cpp,*.hpp,*.S source ~/dotfiles/vim/plugins/c.vim
" autocmd BufRead *.c,*.h,*.cc,*.hh,*.cpp,*.hpp,*.S normal zR
" autocmd BufNewFile,BufRead *.dox set filetype=cpp.doxygen
"
" " Python {{{2
" """""""""""""
" " Use PEP8 indentation rules
" autocmd BufNewFile,BufRead *.py set
"     \ tabstop=4
"     \ softtabstop=4
"     \ shiftwidth=4
"     \ textwidth=79
"     \ expandtab
"     \ autoindent
"     \ fileformat=unix
" autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
" autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

" vim: set foldmethod=marker :
