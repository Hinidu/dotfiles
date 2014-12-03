" NeoBundle and plugins setup {{{

set nocompatible               " Be iMproved

" Use space as leader key.
" NOTE: This should be set before any mapping with <leader>.
" In other case those mappings will use default <leader>.
let mapleader=" "

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
NeoBundle 'tpope/vim-sensible'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Valloric/ListToggle'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'matze/vim-move'
NeoBundle 'godlygeek/tabular'
NeoBundle 'dag/vim2hs'
NeoBundle 'eagletmt/ghcmod-vim'
" NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'MarcWeber/vim-addon-local-vimrc'
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-easytags'

if has('python')
    NeoBundle 'SirVer/ultisnips'
    NeoBundle 'honza/vim-snippets'
    " NeoBundle 'Valloric/YouCompleteMe', { 'build' : {
    "         \ 'unix' : '~/.vim/bundle/YouCompleteMe/install.sh --clang-completer',
    "         \ }}
endif

if has('lua')
    NeoBundle 'Shougo/neocomplete.vim'
endif

if has('ruby')
    NeoBundle 'junkblocker/patchreview-vim'
    NeoBundle 'codegram/vim-codereview'
endif

NeoBundleLazy 'matchit.zip', { 'autoload' : {
        \ 'mappings' : ['%', 'g%']
        \ }}
let bundle = neobundle#get('matchit.zip')
function! bundle.hooks.on_post_source(bundle)
    silent! execute 'doautocmd Filetype' &filetype
endfunction

if isdirectory(expand('~/sources/vim/acvim'))
    NeoBundle '~/sources/vim/acvim', { 'type' : 'nosync' }
endif
if isdirectory(expand('~/sources/vim/potion'))
    NeoBundle '~/sources/vim/potion', { 'type' : 'nosync' }
endif

" }}}

" Installation check.
NeoBundleCheck


" Enable solarized {{{
set background=dark
colorscheme solarized
" }}}


if has('python')
    " UltiSnips {{{
    let g:UltiSnipsEditSplit = 'vertical'
    let g:UltiSnipsExpandTrigger = '<c-j>'
    " }}}


    " YouCompleteMe {{{
    " let g:ycm_confirm_extra_conf = 0
    " let g:ycm_allow_changing_updatetime = 0
    " let g:ycm_complete_in_comments = 1
    " let g:ycm_seed_identifiers_with_syntax = 1
    " nnoremap <localleader>gt :YcmCompleter GoToDefinitionElseDeclaration<CR>
    " let g:ycm_filetype_whitelist = { 'c': 1, 'cpp': 1, 'cs': 1, 'python': 1 }
    " }}}
endif


function! NeoCompleteSafeDisable()
    if exists(':NeoCompleteDisable')
        NeoCompleteDisable
    endif
endfunction

autocmd FileType c :call NeoCompleteSafeDisable()
autocmd FileType cpp :call NeoCompleteSafeDisable()
autocmd FileType cs :call NeoCompleteSafeDisable()
autocmd FileType python :call NeoCompleteSafeDisable()


" syntastic  {{{
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_tex_checkers = ['lacheck']
" To quickly update UI with errors/warnings reported by syntastic
set updatetime=500
" }}}

" move
let g:move_key_modifier = 'C'

" Tagbar
nnoremap <leader>tb :TagbarToggle<CR>

" Tabular {{{
if exists(":Tabularize")
    nmap <leader>a=       :Tabularize haskell_bindings<CR>
    vmap <leader>a=       :Tabularize haskell_bindings<CR>
    nmap <leader>a<Bar>   :Tabularize /<Bar><CR>
    vmap <leader>a<Bar>   :Tabularize /<Bar><CR>
    nmap <leader>a<space> :Tabularize / /l0<CR>
    vmap <leader>a<space> :Tabularize / /l0<CR>
    nmap <leader>ai       :Tabularize haskell_imports<CR>
    vmap <leader>ai       :Tabularize haskell_imports<CR>
    nmap <leader>ac       :Tabularize haskell_comments<CR>
    vmap <leader>ac       :Tabularize haskell_comments<CR>
    nmap <leader>a:       :Tabularize haskell_types<CR>
    vmap <leader>a:       :Tabularize haskell_types<CR>
endif
" }}}

" vim2hs
let g:haskell_conceal_enumerations = 0

" ghcmod
nnoremap <leader>tt :GhcModType<CR>
nnoremap <leader>ti :GhcModTypeInsert<CR>
nnoremap <leader>tc :GhcModTypeClear<CR>

if has('lua')
    " neocomplete.vim
    let g:neocomplete#enable_at_startup = 1
endif

let g:local_vimrc = {'names': ['.lvimrc'], 'hash_fun': 'LVRHashOfFile'}

" easytags
let g:easytags_auto_highlight = 0
let g:easytags_async = 1
let g:easytags_by_filetype = '~/.vim/tags'

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

" Default formatoptions
set formatoptions=tcroq
" Automatic formatting of paragraphs
set formatoptions+=a
" When formatting test, recognize numbered lists
set formatoptions+=n
" Remove a comment leader when joining lines
set formatoptions+=j
" Don't break a line after a one-letter word
set formatoptions+=1
" A line that ends in a non-white character ends a paragraph
set formatoptions+=w

" Round indent to multiple of 'shiftwidth'
set shiftround

" Ignore case in search when pattern has no uppercase letters
set smartcase

" Show line numbers relative to current line
set relativenumber
" Show number of current line instead of 0
set number
" Highlight line under the cursor
set cursorline

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

" Use special characters to mark tabs and trailing spaces
set list

" Allow to use mouse in all modes
set mouse=a

" Always show status line
set laststatus=2

" Highlight 81's column
set colorcolumn=81

" Search by :find, gf, etc. in current directory recursively
set path+=**

" Settings }}}


" Mappings {{{

" Always use very magic patterns
nnoremap / /\v

" Use ii as <esc> in insert mode to fast return to normal mode
" inoremap <M-i> <esc>
" inoremap <esc> <nop>

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
inoremap <c-u> <esc>:call PreserveState("normal viwUi")<cr>
nnoremap <leader><c-u> v

" Remove trailing spaces in file
nnoremap <leader>$ :call PreserveState("%s/\\s\\+$//e")<cr>
" Reindent all lines in file
nnoremap <leader>= :call PreserveState("normal gg=G")<cr>

" Toggle spell checking
nnoremap <leader>sp :set spell!<cr>

" Mappings }}}


" FileType-specific settings {{{

augroup filetype_haskell
    autocmd!
    " Backspace remove only one space in beginning of line in haskell sources
    autocmd Filetype haskell setlocal softtabstop=0
augroup end

augroup filetype_vim
    autocmd!
    " Fold all markers the first time open the file
    autocmd Filetype vim setlocal foldmethod=marker foldlevelstart=0
augroup end

augroup filetype_tex
    autocmd!
    autocmd BufRead,BufNewFile *.tex set filetype=tex
    autocmd FileType tex setlocal spell spelllang=ru,en textwidth=80
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
