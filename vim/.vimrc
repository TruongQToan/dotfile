set nocompatible
" Set this to make suggestions in command-line mode navigable
set wildmenu
set wildmode=longest:full,full
" Line number and relative line number
set nu rnu
" Turn on syntax hightlight
syntax on
syntax enable

" Smarter search options
set ignorecase
set smartcase
set incsearch
set hlsearch

set cmdheight=2
set cmdwinheight=2

set ruler

" Softtabs,  spaces
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround  " Use multiple of shiftwidth when indenting
set smarttab

" Matching bracket
set showmatch
set matchtime=1

" Spell checking
set spell spelllang=en_us

" Where the splits should occur
set splitbelow
set splitright

" Set list chars
set listchars=tab:‣\ ,eol:¬

set encoding=utf-8

" Set maximum size
set lines=999 columns=9999

let mapleader =" "
let maplocalleader = " "

" Enable plugin if has("autocmd")
if has("autocmd")
    autocmd! BufWritePost .vimrc source $MYVIMRC
endif

filetype plugin indent on

" Set how many lines of command history VIM has to remember
set history=500

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'junegunn/goyo.vim' " Distraction-free writing in Vim
Plug 'scrooloose/nerdtree' " The famous NerdTree
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'prettier/vim-prettier'        " Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'         " Vim unimpaired
Plug 'Valloric/YouCompleteMe'
Plug 'Raimondi/delimitMate'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'AndrewRadev/splitjoin.vim'

Plug 'tomtom/tcomment_vim'          " Universal Comment
Plug 'godlygeek/tabular'            " Tabular
Plug 'vim-syntastic/syntastic'      " check syntax on each save
Plug 'bitc/vim-bad-whitespace'      " bad whitespace

" End plugin section
call plug#end()

" Distraction free mode
nnoremap <silent> yz :Goyo<cr>
let g:goyo_width = 80
let g:goyo_height = 100

" Switch j,k with gj, gk
nnoremap k gk
nnoremap j gj
nnoremap <leader>b :ls<CR>:buffer<Space>

" Insert the directory name of the current buffer in Insert mode
inoremap <F2> <C-R>=expand('%:p:h')<CR>

" Delete the current line and enter the Insert mode
nnoremap -c ddO

" Delete the current line
nnoremap -d dd

" Edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
augroup nerdtree
    autocmd!
    autocmd FileType nerdtree setlocal relativenumber
augroup END

let g:go_fmt_command = "goimports"
augroup vimgo
    autocmd!
    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    autocmd FileType go nmap <leader>t  <Plug>(go-test)
    autocmd FileType go map <C-n> :cnext<CR>
    autocmd FileType go map <C-m> :cprevious<CR>
    autocmd FileType go nnoremap <leader>a :cclose<CR>
    autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
    autocmd FileType go nmap <Leader>i <Plug>(go-info)
    let g:go_auto_type_info = 1
    let g:go_auto_sameids = 1
augroup END

set t_Co=256   " This is may or may not needed.

set background=dark
let g:PaperColor_Theme_Options = {
            \   'theme': {
            \     'default.dark': {
            \       'transparent_background': 1
            \     }
            \   }
            \ }
colorscheme PaperColor

if has('gui_running')
    set background=dark
    let g:PaperColor_Theme_Options = {
                \   'theme': {
                \     'default.dark': {
                \       'transparent_background': 0
                \     }
                \   }
                \ }
    colorscheme PaperColor
    set linespace=2
    set guifont=Hack\ Regular:h13
    " Set the screen
    set guioptions-=r         " remove the right-hand scroll bar
endif

" change NerdTree default arrow
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Turn on/off NERDTree
noremap <silent> <leader>e :NERDTreeToggle<CR>
" NERDTree find
noremap <silent> <leader>f :NERDTreeFind<CR>

" Fast saving
nnoremap <leader>` :q!<cr>
nnoremap <leader>w :w!<cr>
nnoremap <leader>x :x<cr>
nnoremap <leader>q :q<cr>
nnoremap <c-s> :update<cr>
vnoremap <c-s> <esc>:update<cr>gv
inoremap <c-s> <esc>:update<cr>a

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <leader>l :set invhlsearch<CR>

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Motion mapping, 
onoremap in( :<c-u>normal! f(vi(<cr>

" <c-u> is to delete the command in command line mode
" for example, if we type vin(, the current mode is visual mode, so when we
" type ':', the command line becomes :'<,'>
xnoremap in( :<c-u>normal! f(vi(<cr>

" Close auto-complete window when finished
let g:ycm_autoclose_preview_window_after_completion=1

" Shortcut for goto definition
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a`<esc>`<i`<esc>

" Configure ack to use ripgrep
if executable('rg')
    let g:ackprg = 'rg --vimgrep --no-heading'

    " CtrlP configurations
    let g:ctrlp_user_command = 'rg --files %s'
    let g:ctrlp_use_caching = 0
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn)$',
        \ 'file': '\v\.(exe|so|dll)$',
        \ 'link': 'some_bad_symbolic_links',
        \ }
endif

" Configure ack shortcuts
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

nmap <F8> :TagbarToggle<CR>

" Enable running rust format when saving buffer
let g:rustfmt_autosave = 1

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

