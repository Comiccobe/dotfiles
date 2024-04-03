set belloff=all
set scrolloff=8
set nocompatible
set cryptmethod=blowfish2
set wildcharm=<C-z>
set laststatus=2
if has("gui_running")
 set lines=60
 set columns=160
 set guioptions -=m
 set guioptions -=T
 set guioptions -=r
 set guifont=Fira\ Code:h11
 " NOTE: Uncomment to enable ligatures.
 "       Updates to ligatures does not work consistently.
 " set renderoptions=type:directx
 " set encoding=utf-8
 " set guiligatures=!\"$%&\'()*+,-./:;<=>?@abcdefghijklmnopqrstuvwxyz[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~
endif

" NEW COC SPECIFIC
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>fx  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" NEW COC SPECIFIC END

inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
" nnoremap q @q
vnoremap q :norm @q<cr>
vnoremap < <gv
vnoremap > >gv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzz
nnoremap N nzz

abbreviate treu true

set wildignore+=**\node_modules\**
set wildignore+=**/node_modules/**
set wildignore+=**/build/**
set wildignore+=**/obj/**
set wildignore+=**/.next/**
set wildignore+=**\.next\**
let $path = $path . ':' . expand('~/.cabal/bin')
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
" set lazyredraw
let g:tsuquyomi_javascript_support = 1
let g:tsuquyomi_disable_quickfix = 1
let  mapleader=","
let g:tmux_navigator_disable_when_zoomed = 1
let g:vim_vue_plugin_load_full_syntax = 1
let g:vim_vue_plugin_use_typescript = 1
let g:fzf_preview_window = []

if has("win32")
  " let $FZF_DEFAULT_COMMAND='dir /s /b /a-d | findstr /v /i /c:".next" /c:"node_modules" /c:".git"'
  let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
endif

let FZF_DEFAULT_OPTS='--color=bg+:#073642,bg:#002b36,spinner:#719e07,hl:#586e75 --color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#719e07 --color=marker:#719e07,fg+:#839496,prompt:#719e07,hl+:#719e07'

" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"  \ 'bg':      ['bg', 'Background'],
"  \ 'hl':      ['fg', 'Comment'],
"  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"  \ 'hl+':     ['fg', 'Statement'],
"  \ 'info':    ['fg', 'PreProc'],
"  \ 'border':  ['fg', 'Ignore'],
"  \ 'prompt':  ['fg', 'Conditional'],
"  \ 'pointer': ['fg', 'Exception'],
"  \ 'marker':  ['fg', 'Keyword'],
"  \ 'spinner': ['fg', 'Label'],
"  \ 'header':  ['fg', 'Comment'] }

let g:fzf_history_dir = '~/.local/share/fzf-history'
nnoremap <C-p> :GFiles --cached --others --exclude-standard<CR>
nnoremap <leader>pf :Files<CR>

" leader commands
nnoremap <leader>l :Lines<CR>
nnoremap <leader>k :BLines<CR>
nnoremap <leader>bc :BCommits<CR>
nnoremap <leader>a :Locate 
nnoremap <leader>ag :Ag .<CR>
nnoremap <leader>ner :ll<CR>
nnoremap <leader>on :only<CR>
nnoremap <leader>tag :CtrlPTag<CR>
nnoremap <leader>dwm :!clear && git diff master -- % %<CR>
nnoremap <leader>mn ]`
nnoremap <leader>mN [`
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bN :bN<CR>
nnoremap <leader>dm :delmarks!<CR>
nnoremap <leader>vsp :vsp<CR>
nnoremap <leader>sp :sp<CR>
nnoremap <leader>sc :tabe ~/scratch.txt<CR>
nnoremap <leader>fs :call Fullscreen()<CR>
nnoremap <leader>eq :wincmd =<CR>
nnoremap <leader>su <c-w>w<c-u><c-w>w
nnoremap <leader>sd <c-w>w<c-d><c-w>w
nnoremap <leader>fix :Prettier<CR>
nnoremap <leader>light :call LightMode()<CR>
nnoremap <leader>dark :call DarkMode()<CR>
nnoremap <leader>ep A <esc>p
nnoremap <leader>gw :Gw<CR>
nnoremap <leader>ht :term<CR>
nnoremap <leader>vt :vert term<CR>
nnoremap <leader>wsl :call WSL()<CR>
nnoremap <leader>twsl :call WSL_tab()<CR>


tnoremap <c-h> <c-w><c-h>
tnoremap <c-l> <c-w><c-l>
" tnoremap <c-j>j <c-w><c-j>
" tnoremap <c-k>k <c-w><c-k>

function! Fullscreen()
 exe "wincmd \|"
 exe "wincmd \_"
endfunction

nnoremap <leader>q :q<CR>
vnoremap <leader>q :q<CR>

nnoremap <leader>tq :tabc<CR>
vnoremap <leader>tq :tabc<CR>
nnoremap <leader>tn :tabnew<CR>
vnoremap <leader>tn :tabnew<CR>

nnoremap <leader>cn :cnext<CR>
vnoremap <leader>cn :cnext<CR>

nnoremap <leader>cp :cprev<CR>
vnoremap <leader>cp :cprev<CR>

vmap <silent> <leader>y "+y
vmap <silent> <leader>+ "+p
nmap <silent> <leader>+ "+p

nnoremap <leader><space> :w!<CR>
vnoremap <leader><space> <ESC>:w!<CR>

nmap <leader>oqq :copen<CR>
nmap <leader>cqq :ccl<CR>

vmap <leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
vmap <leader>ga :<C-U>!git annotate <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
vmap <leader>gg :<C-U>!git log --pretty=short <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

map <silent> <leader>src :execute "vimgrep /" . expand("<cword>") . "./**/*.*" <Bar> cw<CR>
map <leader>vimrc :source ~/.vimrc<cr>
map <leader>erc :tabe ~/.vimrc<cr>
map <leader>egc :tabe ~/.gitconfig<cr>
map <leader>ebp :tabe ~/.bash_profile<cr>
map <leader>snip :execute "vsp ~/.vim/UltiSnips/" . &filetype . ".snippets"<CR>
nmap <silent> <leader>thm :call SwitchTheme()<CR>

command! -nargs=1 FndArg execute 'args `find . -name *' . <q-args> . '* -print` .'
command! -nargs=1 Fnd execute 'vimgrep /' . <q-args> . '/j ./**/*.*'
command! -nargs=1 Silent
\   execute 'silent !' . <q-args>
\ | execute 'redraw!'

" set shell=/bin/zsh
" set runtimepath^=~/.vim/bundle/ctrlp.vim
" set rtp+=/usr/local/opt/fzf
packadd! matchit
call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'elixir-lang/vim-elixir'
Plug 'eagletmt/ghcmod-vim', {'for': 'haskell'}
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Shougo/neocomplete.vim', {'for': 'haskell'}
Plug 'eagletmt/neco-ghc', {'for': 'haskell'}
Plug 'rust-lang/rust.vim'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'bkad/CamelCaseMotion'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'grassdog/tagman.vim'
Plug 'wellle/targets.vim'
Plug 'markonm/traces.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-highlightedyank'
Plug 'prettier/vim-prettier'
Plug 'adamclerk/vim-razor'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mustache/vim-mustache-handlebars'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ziglang/zig.vim'
Plug 'https://github.com/github/copilot.vim.git'
call plug#end()

augroup SignColumnBackground
 autocmd!
 autocmd ColorScheme * highlight! link SignColumn LineNr
augroup END

" Use neco-ghc for completion
augroup Haskell
 autocmd!
 autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END

function! ArgsGrep(folder, pattern)
 exe 'args `grep -Rl ' . a:pattern . ' ' . a:folder . '`'
endfunction

function! s:DiffWithSaved()
   let filetype=&ft
   diffthis
   vnew | r # | normal! 1Gdd
   diffthis
   exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction

com! DiffSaved call s:DiffWithSaved()
set autoread
"" set cursorline
filetype plugin indent on
filetype plugin on

set tabstop=2
set shiftwidth=2

let g:clang_format#auto_format = 0
augroup CFileType
 autocmd!
 autocmd FileType c setlocal tabstop=2
 autocmd FileType c setlocal shiftwidth=2
 autocmd FileType c ClangFormatAutoEnable
augroup END

augroup CSFileType
 autocmd!
 autocmd FileType cs setlocal tabstop=4
 autocmd FileType cs setlocal shiftwidth=4
augroup END

augroup JSFileType
 autocmd!
 autocmd FileType javascript setlocal tabstop=2
 autocmd FileType javascript setlocal shiftwidth=2
augroup END

set swapfile
" set backup
set undofile
set undolevels=1000
set undoreload=10000
set directory=~/.vim/swapdir
set backupdir=~/.vim/backupdir
set undodir=~/.vim/undodir

set relativenumber 
set showtabline=0
set number
set expandtab
set ignorecase
set smartcase
set incsearch
set hlsearch

let g:camelcasemotion_key = '<leader>'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_case_sensitive = 0
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
" let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|deps\|_build\|elm-stuff'
let g:UltiSnipsExpandTrigger="<tab>"                                            
let g:UltiSnipsJumpForwardTrigger="<tab>"                                       
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"   
let g:highlightedyank_highlight_duration = 100
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0

augroup PrettierOnSave
 autocmd!
 autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.hbs Prettier
augroup END

" TODO: change this to a toggle function
" TODO: find a way to have this work as a global keybind
"       even if vim is not focused.
function! SwitchTheme()
 let currentTheme = $CURRENT_TERMINAL_THEME
 if currentTheme == 'dark'
   let $CURRENT_TERMINAL_THEME = 'light'
   call LightMode()
 elseif currentTheme == 'light'
   call DarkMode()
 else
   call DarkMode()
 endif
endfunction


function! DarkMode()
 if has("gui_running")
   exe "set background=dark"
   exe "colorscheme solarized8"
   highlight ColorColumn ctermbg=white
   let $CURRENT_TERMINAL_THEME = 'dark'
 else
   exe "silent !sh ~/dark-theme.sh"
   exe "set background=dark"
   exe "colorscheme solarized8"
   highlight ColorColumn ctermbg=white
   let $CURRENT_TERMINAL_THEME = 'dark'
 endif
endfunction
function! LightMode()
 if has("gui_running")
   exe "set background=light"
   exe "colorscheme solarized8"
   highlight ColorColumn ctermbg=black
   let $CURRENT_TERMINAL_THEME = 'light'
 else
   exe "silent !sh ~/light-theme.sh"
   exe "set background=light"
   exe "colorscheme solarized8"
   highlight ColorColumn ctermbg=black
   let $CURRENT_TERMINAL_THEME = 'light'
 endif
endfunction

function! SetInitialTheme()
 let currentTheme = $CURRENT_TERMINAL_THEME
 if currentTheme == 'dark'
   call DarkMode()
 elseif currentTheme == 'light'
   call LightMode()
 else
   call LightMode()
 endif
endfunction

syntax enable
call SetInitialTheme()

" search for more occurences of selection
vnoremap // y/\V<C-R>"<CR>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" move selected line up or down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

set splitright
" let &makeprg="MSBuild.exe \/\/nologo \/\/v:q \/\/property:GenerateFullPaths=true"
let &makeprg="npm run lint"

set errorformat=%EERROR:\ %f[%l\\,\ %c]:\ %m,%WWARNING:\ %f[%l\\,\ %c]:\ %m,%E%f[%l\\,\ %c]:\ %m
" set errorformat=%f(%l\\,%v):\ %t%*[^:]:\ %m,
" "             \%trror%*[^:]:\ %m,
" "             \%tarning%*[^:]:\ %m
set backspace=indent,eol,start
augroup BgHighlight
   autocmd!
   autocmd WinEnter,BufEnter * if !exists('w:firstMatchId') | let w:firstMatchId = matchadd('ColorColumn', '\%81v', 100) | endif
   autocmd WinEnter,BufEnter * if !exists('w:secondMatchId') | let w:secondMatchId = matchadd('ColorColumn', '\%141v', 100) | endif
augroup END

" c-specific
nnoremap <leader>sh :!sh build-mac.sh<CR>
" hi debugPC term=reverse ctermbg=black guibg=darkblue
" hi debugBreakpoint term=reverse ctermbg=red guibg=red
"

" USE WSL AS TERMINAL IN GVIM(WINDOWS)
" if has("win32")
"     set shell=C:\Windows\Sysnative\wsl.exe
"     set shellpipe=|
"     set shellredir=>
"     set shellcmdflag=
" endif
function! WSL_tab()
  exe "tabnew"
  call WSL()
  exe "on"
endfunction

function! WSL()
  set shell=C:\Windows\system32\wsl.exe
  set shellpipe=|
  set shellredir=>
  set shellcmdflag=
  exe "vert term"
  set shell=C:\Windows\system32\cmd.exe
  set shellpipe=>%s\ 2>&1
  set shellredir=>%s\ 2>&1
  set shellcmdflag=/c
endfunction
