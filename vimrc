set nocompatible " not vi compatible

"------------------
" Syntax and indent
"------------------
syntax on " turn on syntax highlighting
set showmatch " show matching braces when text indicator is over them

" highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

filetype plugin indent on " enable file type detection
set autoindent

"------------------
" Colors
"------------------
" " vim can autodetect this based on $TERM (e.g. 'xterm-256color')
" " but it can be set to force 256 colors
" set t_Co=256
" if has('gui_running')
"     colorscheme solarized
"     let g:lightline = {'colorscheme': 'solarized'}
" elseif &t_Co < 256
"     colorscheme default
"     set nocursorline " looks bad in this mode
" else
"     set background=dark
"     let g:solarized_termcolors=256 " instead of 16 color with mapping in terminal
"     colorscheme solarized
"     " customized colors
"     highlight SignColumn ctermbg=234
"     highlight StatusLine cterm=bold ctermfg=245 ctermbg=235
"     highlight StatusLineNC cterm=bold ctermfg=245 ctermbg=235
"     let g:lightline = {'colorscheme': 'dark'}
"     highlight SpellBad cterm=underline
"     " patches
"     highlight CursorLineNr cterm=NONE
" endif

set background=dark
" let g:solarized_termcolors=256 " instead of 16 color with mapping in terminal
colorscheme iceberg

"---------------------
" Basic editing config
"---------------------
" set shortmess+=I " disable startup message
set nu " number lines
set rnu " relative line numbering
set incsearch " incremental search (as string is being typed)
set hls " highlight search
set listchars=tab:>>,nbsp:~ " set list to see tabs and non-breakable spaces
set lbr " line break
" set scrolloff=5 " show lines above and below cursor (when possible)
set noshowmode " hide mode
set laststatus=2
set backspace=indent,eol,start " allow backspacing over everything
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slow O inserts
set lazyredraw " skip redrawing screen in some cases
" set autochdir " automatically set current directory to directory of last opened file
set hidden " allow auto-hiding of edited buffers
set history=50 " lines of history
set nojoinspaces " suppress inserting two spaces between sentences
" use 4 spaces instead of tabs during formatting
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" smart case-sensitive search
set ignorecase
set smartcase
" tab completion for files/bufferss
set wildmode=longest,list
set wildmenu
set mouse+=a " enable mouse mode (scrolling, selection, etc)
" if &term =~ '^screen'
"     " tmux knows the extended mouse mode
"     set ttymouse=xterm2
" endif
set nofoldenable " disable folding by default

set ruler " show the cursor position all the time
"--------------------
" Misc configurations
"--------------------

" unbind keys
map <C-a> <Nop>
map <C-x> <Nop>
nmap Q <Nop>

" disable audible bell
set noerrorbells visualbell t_vb=

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" " movement relative to display lines
" nnoremap <silent> <Leader>d :call ToggleMovementByDisplayLines()<CR>
" function SetMovementByDisplayLines()
"     noremap <buffer> <silent> <expr> k v:count ? 'k' : 'gk'
"     noremap <buffer> <silent> <expr> j v:count ? 'j' : 'gj'
"     noremap <buffer> <silent> 0 g0
"     noremap <buffer> <silent> $ g$
" endfunction
" function ToggleMovementByDisplayLines()
"     if !exists('b:movement_by_display_lines')
"         let b:movement_by_display_lines = 0
"     endif
"     if b:movement_by_display_lines
"         let b:movement_by_display_lines = 0
"         silent! nunmap <buffer> k
"         silent! nunmap <buffer> j
"         silent! nunmap <buffer> 0
"         silent! nunmap <buffer> $
"     else
"         let b:movement_by_display_lines = 1
"         call SetMovementByDisplayLines()
"     endif
" endfunction

" toggle relative numbering
nnoremap <C-n> :set rnu!<CR>

" " save read-only files
" command -nargs=0 Sudow w !sudo tee % >/dev/null

" 将 jj 映射为 Esc
inoremap jj <Esc>
"---------------------
" Plugin configuration
"---------------------
" vim-plug section
" use vim-plug to add plugins
call plug#begin('~/.vim/plugged')

" https://vimawesome.com/plugin/vim-auto-save
Plug '907th/vim-auto-save'

" Fuzzy file finding
Plug 'ctrlpvim/ctrlp.vim'

" markdown syntax 
Plug 'godlygeek/tabular' "必要插件，安装在vim-markdown前面
Plug 'plasticboy/vim-markdown'

" useful bindings 
Plug 'tpope/vim-unimpaired'

" customize status line
Plug 'itchyny/lightline.vim'

call plug#end()

" vim-auto-save: enabled
let g:auto_save = 1
" do not display notification message
" let g:auto_save_silent = 1


" " nerdtree
" nnoremap <Leader>n :NERDTreeToggle<CR>
" nnoremap <Leader>f :NERDTreeFind<CR>
" 
" " buffergator
" let g:buffergator_suppress_keymaps = 1
" nnoremap <Leader>b :BuffergatorToggle<CR>
" 
" " gundo
" nnoremap <Leader>u :GundoToggle<CR>
" if has('python3')
"     let g:gundo_prefer_python3 = 1
" endif
" 

" ctrlp
nnoremap ; :CtrlPBuffer<CR> 
" use ';' to invoke find buffer mode (search in all buffers)
let g:ctrlp_switch_buffer = 0 " disable switch buffer feature
" let g:ctrlp_show_hidden = 1
" Make CtrlP and grep using ripgrep(rg)
if executable('rg')
  set grepprg=rg\ --color=never\ --vimgrep
  set grepformat=%f:%l:%c:%m
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob "!*.class"'
  let g:ctrlp_user_caching = 0
endif

" What to ignore while searching files, speeds up CtrlP
set wildignore+=*/.git/*,*.swp,
" 
" " ag / ack.vim
" command -nargs=+ Gag Gcd | Ack! <args>
" nnoremap K :Gag "\b<C-R><C-W>\b"<CR>:cw<CR>
" if executable('ag')
"     let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
"     let g:ackprg = 'ag --vimgrep'
" endif
" 
" " syntastic
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_mode_map = {
"     \ 'mode': 'passive',
"     \ 'active_filetypes': [],
"     \ 'passive_filetypes': []
" \}
" nnoremap <Leader>s :SyntasticCheck<CR>
" nnoremap <Leader>r :SyntasticReset<CR>
" nnoremap <Leader>i :SyntasticInfo<CR>
" nnoremap <Leader>m :SyntasticToggleMode<CR>
" 
" " easymotion
" map <Space> <Plug>(easymotion-prefix)
" 
" " incsearch
" map / <Plug>(incsearch-forward)
" map ? <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)
" 
" " incsearch-easymotion
" map z/ <Plug>(incsearch-easymotion-/)
" map z? <Plug>(incsearch-easymotion-?)
" map zg/ <Plug>(incsearch-easymotion-stay)
" 
" " argwrap
" nnoremap <Leader>w :ArgWrap<CR>
" 
" noremap <Leader>x :OverCommandLine<CR>

" markdown
let g:markdown_fenced_languages = [
    \ 'bash=sh',
    \ 'c',
    \ 'javascript',
    \ 'java',
    \ 'json',
    \ 'python',
    \ 'ruby',
    \ 'yaml',
    \ 'go',
    \ 'racket',
\]
let g:markdown_syntax_conceal = 0
let g:markdown_folding = 1
" 
" " fugitive
" set tags^=.git/tags;~

" markdown specific -- hard wrapping
autocmd FileType markdown setlocal fo+=Mm tw=72
" use gw or gq to format 
" [hard-wrapping](http://vimcasts.org/episodes/hard-wrapping-text/)
" [autocm](https://learnvimscriptthehardway.stevelosh.com/chapters/12.html)
" see :help fo-table
"
" to turn off automatic (soft) wrapping and highlight `Overlength`
" see [text-width](http://blog.ezyang.com/2010/03/vim-textwidth/)

" paste
" use F2 key to toggle paste mode so as indention is not corrupt
nnoremap <F2> :set invpaste paste?<CR>
" normal mode
set pastetoggle=<F2>
" insertion mode
set showmode

"---------------------
" Local customizations
"---------------------

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

"---------------------
" Note System
"---------------------
let enable_note_system = 0
if enable_note_system
    " Go to index of notes and set working directory to my notes
    nnoremap <leader>ni :e $NOTES_DIR/index.md<CR>:cd $NOTES_DIR<CR>

    " Generate ctags silently
    nnoremap <leader>tt :silent !universal-ctags -R . <CR>:redraw!<CR>
    " Binding for searching tags ("search tag")
    nnoremap <leader>st :CtrlPTag<CR>
    " star: help vim find tags
    set tags+=./tags;,tags
endif
