" dein and plugins setup {{{

if &compatible
  set nocompatible               " Be iMproved
endif

" Use space as leader key.
" NOTE: This should be set before any mapping with <leader>.
" In other case those mappings will use default <leader>.
let mapleader = ' '

if has('nvim') && has('win32')
  let g:python_host_prog='C:\\Python27\\python.exe'
  let g:python3_host_prog='C:\\Python34\\python.exe'
endif

set runtimepath+=~/.vim/bundle/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/bundle/')
  call dein#begin('~/.vim/bundle/')

  call dein#add('Shougo/dein.vim')

  " Original repos on github
  if has('nvim')
    call dein#add('iCyMind/NeoSolarized')
  else
    call dein#add('altercation/vim-colors-solarized')
  endif
  if !has('nvim')
    call dein#add('tpope/vim-sensible')
  endif
  call dein#add('w0rp/ale')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('majutsushi/tagbar')
  call dein#add('bling/vim-airline')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-eunuch')
  call dein#add('matze/vim-move')
  call dein#add('godlygeek/tabular')
  call dein#add('dag/vim2hs')
  call dein#add('eagletmt/ghcmod-vim')
  " call dein#add('eagletmt/neco-ghc')
  " call dein#add('tpope/vim-dispatch')
  call dein#add('exu/pgsql.vim')
  call dein#add('saltstack/salt-vim')
  call dein#add('vim-erlang/vim-erlang-runtime')
  call dein#add('vim-erlang/vim-erlang-compiler')
  call dein#add('vim-erlang/vim-erlang-omnicomplete')
  call dein#add('vim-erlang/vim-erlang-tags')
  call dein#add('ElmCast/elm-vim')
  call dein#add('elixir-lang/vim-elixir')
  call dein#add('slashmili/alchemist.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('hashivim/vim-terraform')
  call dein#add('juliosueiras/vim-terraform-completion')

  " vim-scripts repos on github
  call dein#add('vim-scripts/matchit.zip')

  if has('python3')
    call dein#add('Shougo/denite.nvim')
  endif

  if has('python') || has('python3')
    call dein#add('SirVer/ultisnips')
    call dein#add('honza/vim-snippets')
    call dein#add('davidhalter/jedi-vim')
  endif

  if has('python3') && has('nvim')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/neco-syntax')
    call dein#add('Shougo/neco-vim')
  endif

  if has('lua')
    call dein#add('Shougo/neocomplete.vim')
  endif

  if has('ruby')
    call dein#add('junkblocker/patchreview-vim')
    call dein#add('codegram/vim-codereview')
  endif

  " NeoBundleLazy 'matchit.zip', { 'autoload' : {
  "     \ 'mappings' : ['%', 'g%']
  "     \ }}
  " let bundle = neobundle#get('matchit.zip')
  " function! bundle.hooks.on_post_source(bundle)
  "   silent! execute 'doautocmd Filetype' &filetype
  " endfunction

  call dein#end()
  call dein#save_state()

  if dein#check_install()
    call dein#install()
  endif

  call dein#remote_plugins()
endif


" Enable solarized {{{
set background=dark
if has('nvim')
  colorscheme NeoSolarized
else
  colorscheme solarized
endif
" }}}


" {{{ denite
if has('python3')
  call denite#custom#var('file_rec', 'command', ['rg', '--files', ''])

  call denite#custom#var('grep', 'command', ['rg'])
  let rg_opts = ['--vimgrep', '--no-heading', '--smart-case']
  call denite#custom#var('grep', 'default_opts', rg_opts)
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])

  " Open Denite buffer in normal mode
  call denite#custom#option('default', 'mode', 'normal')

  nnoremap <leader>dr :<C-u>Denite -resume<CR>
  nnoremap <leader>df :<C-u>Denite file_rec<CR>
  nnoremap <leader>db :<C-u>Denite buffer<CR>

  nnoremap <leader>ff :<C-u>Denite grep<CR>
  nnoremap <leader>fw :<C-u>DeniteCursorWord grep<CR>
endif
" }}} denite

" {{{ fugitive
if dein#is_sourced('vim-fugitive')
  nnoremap <leader>gs :<C-u>Gstatus<CR>
  nnoremap <leader>gd :<C-u>Gdiff<CR>
  nnoremap <leader>gc :<C-u>Gcommit --verbose<CR>
  nnoremap <leader>gpl :<C-u>Gpull --ff-only<CR>
  nnoremap <leader>gps :<C-u>Gpush<CR>
endif
" }}} fugitive


if has('python') || has('python3')
  " UltiSnips {{{
  let g:UltiSnipsEditSplit = 'vertical'
  let g:UltiSnipsExpandTrigger = '<c-j>'
  " }}}

  " Jedi {{{
  autocmd FileType python setlocal omnifunc=jedi#completions
  let g:jedi#completions_enabled = 0
  let g:jedi#auto_vim_configuration = 0

  let g:jedi#goto_command = "<leader>gg"
  let g:jedi#goto_assignments_command = "<leader>ga"
  let g:jedi#goto_definitions_command = "<leader>gt"
  let g:jedi#documentation_command = "<leader>dc"
  let g:jedi#usages_command = "<leader>fu"
  let g:jedi#rename_command = "<leader>rn"

  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
  " }}}
endif


" syntastic  {{{
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_tex_checkers = ['lacheck']
" Trying to avoid screen glitches
let g:syntastic_full_redraws = 0
" To quickly update UI with errors/warnings reported by syntastic
set updatetime=500
" }}}


" ale  {{{
let g:ale_python_mypy_options = '--check-untyped-defs --ignore-missing-imports'
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

if dein#is_sourced('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1

  let g:deoplete#omni_patterns = {}
  let g:deoplete#omni_patterns.elixir = [
    \'[^. \t]\.\w*',
    \'^\s*alias\s*\w*',
    \'^\s*import\s*\w*',
    \'^\s*require\s*\w*',
    \'^\s*use\s*\w*',
    \'^defmodule\s*\w*',
    \]
endif

if dein#is_sourced('alchemist.vim')
  let g:alchemist#elixir_erlang_src = '/home/hinidu/sources'
endif

if has('lua')
  " neocomplete.vim {{{
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1

  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  " inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction

  " Smart <TAB> completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ neocomplete#start_manual_complete()
  function! s:check_back_space()
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'

  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.erlang = '\<[[:digit:][:alnum:]_-]\+:[[:digit:][:alnum:]_-]*'
  " }}}
endif

let g:local_vimrc = {'names': ['.lvimrc'], 'hash_fun': 'LVRHashOfFile'}

let g:sql_type_default = 'pgsql'

" dein and plugins setup }}}


" Settings {{{

filetype plugin on
syntax on

" Tab width is 4 columns
set tabstop=2
" Backspace remove up to 4 spaces in beginning of line in insert mode
set softtabstop=2
" < and > commands remove/add 4 spaces to the end of line
set shiftwidth=2
" Replace tab with tabstop spaces when press <tab> in insert mode
set expandtab

" Default formatoptions
" set formatoptions=tcroq
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
" set clipboard+=autoselectplus
" Do not use system clipboard in terminal
if !has('win32') && !has('nvim')
  set clipboard+=exclude:cons\|linux
endif

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

set encoding=utf-8

if has('nvim')
  set inccommand=nosplit
endif

set diffopt=filler,vertical

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
