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

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein/')
  call dein#begin('~/.cache/dein/')

  call dein#add('Shougo/dein.vim')

  " Original repos on github
  if has('nvim')
    call dein#add('iCyMind/NeoSolarized')
    " call dein#add('nvim-lua/plenary.nvim')
    " call dein#add('mhanberg/elixir.nvim')
  else
    call dein#add('altercation/vim-colors-solarized')
  endif
  if !has('nvim')
    call dein#add('tpope/vim-sensible')
  endif
  call dein#add('w0rp/ale')
  call dein#add('jsfaint/gen_tags.vim')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('majutsushi/tagbar')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-eunuch')
  call dein#add('matze/vim-move')
  call dein#add('godlygeek/tabular')
  call dein#add('dag/vim2hs')
  " call dein#add('eagletmt/ghcmod-vim')
  call dein#add('vim-erlang/vim-erlang-runtime')
  call dein#add('vim-erlang/vim-erlang-compiler')
  call dein#add('vim-erlang/vim-erlang-omnicomplete')
  call dein#add('vim-erlang/vim-erlang-tags')
  call dein#add('ElmCast/elm-vim')
  call dein#add('elixir-lang/vim-elixir')
  call dein#add('slashmili/alchemist.vim', {'rev': 'main'})
  call dein#add('mhinz/vim-mix-format')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('hashivim/vim-terraform')
  call dein#add('juliosueiras/vim-terraform-completion')
  call dein#add('LnL7/vim-nix')
  call dein#add('vifm/vifm.vim')

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

  if has('ruby')
    call dein#add('junkblocker/patchreview-vim')
    call dein#add('codegram/vim-codereview')
  endif

  call dein#end()
  call dein#save_state()

  if dein#check_install()
    call dein#install()
  endif

  call dein#remote_plugins()
endif


" Enable solarized {{{
set background=light
if has('nvim')
  colorscheme NeoSolarized
else
  colorscheme solarized
endif
" }}}


" gen_tags {{{
" let g:loaded_gentags#gtags = 1
" let g:gen_tags#ctags_auto_gen = 1
" let g:gen_tags#use_cache_dir = 0
" }}}


" {{{ denite
if has('python3')
  autocmd FileType denite call s:denite_my_settings()
  function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
    \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
    \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
    \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
    \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
    \ denite#do_map('toggle_select').'j'
  endfunction

  autocmd FileType denite-filter call s:denite_filter_my_settings()
  function! s:denite_filter_my_settings() abort
    imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
  endfunction

  call denite#custom#var('file/rec', 'command', ['rg', '--files', ''])

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
  nnoremap <leader>df :<C-u>Denite file/rec<CR>
  nnoremap <leader>db :<C-u>Denite buffer<CR>

  nnoremap <leader>ff :<C-u>Denite grep<CR>
  nnoremap <leader>fw :<C-u>DeniteCursorWord grep<CR>
endif
" }}} denite

" {{{ fugitive
if dein#is_sourced('vim-fugitive')
  nnoremap <leader>gs :<C-u>Git<CR>
  nnoremap <leader>gd :<C-u>Gdiff<CR>
  nnoremap <leader>gcm :<C-u>Git commit --verbose<CR>
  nnoremap <leader>gca :<C-u>Git commit --verbose --amend<CR>
  nnoremap <leader>gpl :<C-u>Git pull --ff-only --recurse-submodules<CR>
  nnoremap <leader>gps :<C-u>Git push --set-upstream<CR>
  nnoremap <leader>gpf :<C-u>Git push --set-upstream --force<CR>
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
  " }}}
endif


" ale  {{{
let g:ale_python_mypy_options = '--check-untyped-defs --ignore-missing-imports'
" }}}


" move
let g:move_key_modifier = 'C'

" Tagbar {{{
nnoremap <leader>tb :TagbarToggle<CR>

let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'Elixir',
    \ 'kinds'     : [
        \ 'f:functions',
        \ 'c:callbacks',
        \ 'd:delegates',
        \ 'e:exceptions',
        \ 'i:implementations',
        \ 'a:macros',
        \ 'o:operators',
        \ 'm:modules',
        \ 'p:protocols',
        \ 'r:records',
        \ 't:tests'
    \ ],
    \ 'sro'        : '.'
\ }
" }}}

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

let g:local_vimrc = {'names': ['.lvimrc'], 'hash_fun': 'LVRHashOfFile'}

let g:sql_type_default = 'pgsql'

" airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

let g:airline#extensions#keymap#enabled = 0
let g:airline_solarized_bg = 'light'
" }}}

" dein and plugins setup }}}


" Settings {{{

filetype plugin on
syntax on

" Fully disable mouse
set mouse=

" Tab width is 2 columns
set tabstop=2
" Backspace remove up to 2 spaces in beginning of line in insert mode
set softtabstop=2
" < and > commands remove/add 2 spaces to the end of line
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

augroup filetype_cs
  autocmd!
  autocmd Filetype cs setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup end

augroup filetype_terraform
  autocmd!
  autocmd Filetype terraform setlocal fo=
augroup end

augroup filetype_haskell
  autocmd!
  " Backspace remove only one space in beginning of line in haskell sources
  autocmd Filetype haskell setlocal softtabstop=0
augroup end

augroup filetype_go
  autocmd!
  autocmd Filetype go setlocal noexpandtab nolist
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
