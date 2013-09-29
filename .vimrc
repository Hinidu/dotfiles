" NeoBundle and plugins setup {{{

set nocompatible               " Be iMproved

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
NeoBundle 'Shougo/vimproc', { 'build' : {
        \ 'unix' : 'make -f make_unix.mak',
        \ }}

" My Bundles here: {{{

" Original repos on github
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'Valloric/YouCompleteMe', { 'build' : {
        \ 'unix' : '~/.vim/bundle/YouCompleteMe/install.sh --clang-completer --system-libclang --omnisharp-completer',
        \ }}
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Valloric/ListToggle'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'http://hg.code.sf.net/p/pyclewn/pyclewn', {
            \   'type' : 'hg',
            \   'build' : {
            \       'unix' : 'env EDITOR=vim vimdir=$HOME/.vim/bundle/pyclewn python setup.py install --force --home=$HOME',
            \   },
            \ }

NeoBundleLazy 'matchit.zip', { 'autoload' : {
        \ 'mappings' : ['%', 'g%']
        \ }}
let bundle = neobundle#get('matchit.zip')
function! bundle.hooks.on_post_source(bundle)
    silent! execute 'doautocmd Filetype' &filetype
endfunction

NeoBundle '~/sources/vim/acvim', { 'type' : 'nosync' }
NeoBundle '~/sources/vim/potion', { 'type' : 'nosync' }

" }}}

filetype plugin indent on     " Required!

" Installation check.
NeoBundleCheck


" Enable solarized {{{
syntax enable
set background=dark
colorscheme solarized
" }}}


" UltiSnips {{{
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<c-j>'
" }}}


" YouCompleteMe {{{
let g:ycm_confirm_extra_conf = 0
let g:ycm_allow_changing_updatetime = 0
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
nnoremap <localleader>gt :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}


" syntastic  {{{
let g:syntastic_aggregate_errors = 1
let g:syntastic_c_checker = ['ycm']
let g:syntastic_cpp_checker = ['ycm']
let g:syntastic_always_populate_loc_list = 1
" To avoid flickering of vim
let g:syntastic_full_redraws = 0
" To quickly update UI with errors/warnings reported by syntastic
set updatetime=500
" }}}


" Tagbar
nnoremap <leader>tt :TagbarToggle<CR>

" NeoBundle and plugins setup }}}


" Settings {{{

" Tab width is 4 columns
set tabstop=4
" Backspace remove up to 4 spaces in beginning of line in insert mode
set softtabstop=4
" < and > commands remove/add 4 spaces to the end of line
set shiftwidth=4
" Replace tab with tabstop spaces when press <tab> in insert mode
set expandtab

" Round indent to multiple of 'shiftwidth'
set shiftround

" Ignore case in search when pattern has no uppercase letters
set smartcase
" Highlight the next match while I'm still typing out search pattern
set incsearch

" Show line numbers relative to current line
set relativenumber
" Show number of current line instead of 0
set number
" Highlight line under the cursor
set cursorline

" Show possible matches for command-line completion
set wildmenu

" Allow to switch to russian keymap with Ctrl-^ in insert mode
" This change would affect insert mode and search
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

" Do not make all windows equal sizes after splitting or closing window
set noequalalways

" Use system clipboard for all yank, delete, change and put operations
set clipboard=unnamedplus
" Add selection in visual mode to clipboard
set clipboard+=autoselectplus
" Do not use system clipboard in terminal
set clipboard+=exclude:cons\|linux

" Use nice unicode characters to mark tabs and end of line
set listchars+=tab:▸\ ,eol:¬

" Allow to use mouse in all modes
set mouse=a

" Always show status line
set laststatus=2

" Settings }}}


" Mappings {{{

" Use space as leader key
let mapleader=" "

" Always use very magic patterns
nnoremap / /\v

" Use ii as <esc> in insert mode to fast return to normal mode
inoremap ii <esc>
inoremap <esc> <nop>

" Stop highlighting items from the last search with <leader>hl
nnoremap <leader>hl :nohlsearch<cr>

" Open ~/.vimrc in a split window
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" Source ~/.vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>

" Fast movements between quickfix list entries
nnoremap <leader>n :cnext<cr>
nnoremap <leader>p :cprevious<cr>

" Uppercase current word with <leader>Ctrl-U
inoremap <leader><c-u> <esc>:call PreserveState("normal viwUi")<cr>
nnoremap <leader><c-u> v

" Remove trailing spaces in file
nnoremap <leader>$ :call PreserveState("%s/\\s\\+$//e")<cr>
" Reindent all lines in file
nnoremap <leader>= :call PreserveState("normal gg=G")<cr>

" Mappings }}}


" FileType-specific settings {{{

augroup filetype_vim
    autocmd!
    " Fold all markers the first time open the file
    autocmd Filetype vim setlocal foldmethod=marker foldlevelstart=0
augroup end

" FileType-specific settings }}}


" Functions {{{

" Function that preserve current state and run some command
function! PreserveState(command)
    " Preparation: save last search and cursor position.
    let _s = @/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history and cursor position
    let @/ = _s
    call cursor(l, c)
endfunction

" Functions }}}
