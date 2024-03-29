" TODO: Organize .vimrc
" TODO: Add haskell build system
" TODO: Finish c# integration
" TODO: Finish sql integration
" TODO: Integrate migrate.exe
" TODO: Add a way for project specific .vimrc
" TODO: Add these to .md files:
"   lägg till skiljetecken till undo
"   inoremap . .<c-g>u
"   inoremap ? ?<c-g>u
"   inoremap ! !<c-g>u
"   inoremap , ,<c-g>u

" lägg till input mode undo/delete line till undo
set nocompatible
set cryptmethod=blowfish2
set wildcharm=<C-z>
set laststatus=2

" COC SPECIFIC
set updatetime=300
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <c-n> <Plug>(coc-diagnostic-prev)
nmap <silent> <c-m> <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> <leader>ref <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>fx  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

let g:coc_global_extensions=['coc-vetur', 'coc-omnisharp']

" COC SPECIFIC END

inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
nnoremap Q @q
vnoremap Q :norm @q<cr>
map Y y$
vnoremap < <gv
vnoremap > >gv

abbreviate treu true

" For comparing PR against specific commit
" let g:gitgutter_diff_base = '99ce15b322c6e2413715a353975bf7330c105179'

" augroup myvimrc
"     autocmd!
"     autocmd QuickFixCmdPost [^l]* cwindow
"     autocmd QuickFixCmdPost l*    lwindow
" augroup END
set wildignore+=**/node_modules/**
set wildignore+=**/build/**
set wildignore+=**/obj/**
let $PATH = $PATH . ':' . expand('~/.cabal/bin')
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
set lazyredraw
let g:tsuquyomi_javascript_support = 1
let g:tsuquyomi_disable_quickfix = 1
let  mapleader=","
let g:tmux_navigator_disable_when_zoomed = 1
let g:vim_vue_plugin_load_full_syntax = 1
let g:vim_vue_plugin_use_typescript = 1

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Background'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
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
nnoremap <C-p> :FZF<CR>

" leader commands
nnoremap <leader>l :Lines<CR>
nnoremap <leader>k :BLines<CR>
nnoremap <leader>bc :BCommits<CR>
nnoremap <leader>a :Locate 
nnoremap <leader>ag :Ag .<CR>
nnoremap <leader>cod :call SwitchTabPage(1)<CR>
nnoremap <leader>tod :call SwitchTabPage(2)<CR>
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
nnoremap <leader>fs :call Fullscreen()<CR>
nnoremap <leader>eq :wincmd =<CR>
nnoremap <leader>su <c-w>w<c-u><c-w>w
nnoremap <leader>sd <c-w>w<c-d><c-w>w
nnoremap <leader>fix :Prettier<CR>
nnoremap <leader>light :call LightMode()<CR>
nnoremap <leader>dark :call DarkMode()<CR>
nnoremap <leader>ep A <esc>p
nnoremap <leader>gw :Gw<CR>

tnoremap <c-h> <c-w><c-h>
tnoremap <c-l> <c-w><c-l>
" tnoremap <c-j> <c-w><c-j>
" tnoremap <c-k> <c-w><c-k>

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

" typescript specific
nmap <silent> <leader>psp :call SplitParams()<CR>
nmap <silent> <leader>isp :call SplitImports()<CR>
nmap <silent> <leader>jsp :call SplitJSX()<CR>
nmap <silent> <leader>cfn :call CreateConstFunction()<CR>

nmap <leader>inf :call SearchInFiles()<CR>
function! SearchInFiles()
  exe ":e !ag --nobreak --nonumbers --noheading . | fzf"
endfunction

function! SplitParams()
  exe "normal 0f(%i,\r"
  exe "normal kf(a\r"
  exe "s/, /,\r/ge"
  exe "normal =i("
endfunction

function! SplitImports()
  exe "normal 0f{%hxi,\r"
  exe "normal kf{a\r"
  exe "s/, /,\r/ge"
  exe "normal =i{"
endfunction

function! SplitJSX()
  exe "normal f cl\r    "
  exe "normal 0wf cl\r    "
  exe "normal 0wf cl\r    "
  exe "normal 0wf cl\r    "
  exe "normal 0wf cl\r    "
  exe "normal 0wf cl\r    "
  exe "normal 0wf cl\r    "
  exe "normal 0wf cl\r    "
  exe "normal 0wf cl\r    "
  exe "normal hhxx"
endfunction

" regular expressions that match numbers (order matters .. keep '\d' last!)
" note: \+ will be appended to the end of each
let s:regNums = [ '0b[01]', '0x\x', '\d' ]

function! s:inNumber()
	" select the next number on the line
	" this can handle the following three formats (so long as s:regNums is
	" defined as it should be above this function):
	"   1. binary  (eg: "0b1010", "0b0000", etc)
	"   2. hex     (eg: "0xffff", "0x0000", "0x10af", etc)
	"   3. decimal (eg: "0", "0000", "10", "01", etc)
	" NOTE: if there is no number on the rest of the line starting at the
	"       current cursor position, then visual selection mode is ended (if
	"       called via an omap) or nothing is selected (if called via xmap)

	" need magic for this to work properly
	let l:magic = &magic
	set magic

	let l:lineNr = line('.')

	" create regex pattern matching any binary, hex, decimal number
	let l:pat = join(s:regNums, '\+\|') . '\+'

	" move cursor to end of number
	if (!search(l:pat, 'ce', l:lineNr))
		" if it fails, there was not match on the line, so return prematurely
		return
	endif

	" start visually selecting from end of number
	normal! v

	" move cursor to beginning of number
	call search(l:pat, 'cb', l:lineNr)

	" restore magic
	let &magic = l:magic
endfunction

" "in number" (next number after cursor on current line)
xnoremap <silent> in :<c-u>call <sid>inNumber()<cr>
onoremap <silent> in :<c-u>call <sid>inNumber()<cr>

function! s:aroundNumber()
	" select the next number on the line and any surrounding white-space;
	" this can handle the following three formats (so long as s:regNums is
	" defined as it should be above these functions):
	"   1. binary  (eg: "0b1010", "0b0000", etc)
	"   2. hex     (eg: "0xffff", "0x0000", "0x10af", etc)
	"   3. decimal (eg: "0", "0000", "10", "01", etc)
	" NOTE: if there is no number on the rest of the line starting at the
	"       current cursor position, then visual selection mode is ended (if
	"       called via an omap) or nothing is selected (if called via xmap);
	"       this is true even if on the space following a number

	" need magic for this to work properly
	let l:magic = &magic
	set magic

	let l:lineNr = line('.')

	" create regex pattern matching any binary, hex, decimal number
	let l:pat = join(s:regNums, '\+\|') . '\+'

	" move cursor to end of number
	if (!search(l:pat, 'ce', l:lineNr))
		" if it fails, there was not match on the line, so return prematurely
		return
	endif

	" move cursor to end of any trailing white-space (if there is any)
	call search('\%'.(virtcol('.')+1).'v\s*', 'ce', l:lineNr)

	" start visually selecting from end of number + potential trailing whitspace
	normal! v

	" move cursor to beginning of number
	call search(l:pat, 'cb', l:lineNr)

	" move cursor to beginning of any white-space preceding number (if any)
	call search('\s*\%'.virtcol('.').'v', 'b', l:lineNr)

	" restore magic
	let &magic = l:magic
endfunction

" "around number" (next number on line and possible surrounding white-space)
xnoremap <silent> an :<c-u>call <sid>aroundNumber()<cr>
onoremap <silent> an :<c-u>call <sid>aroundNumber()<cr>

function! s:inIndentation()
	" select all text in current indentation level excluding any empty lines
	" that precede or follow the current indentationt level;
	"
	" the current implementation is pretty fast, even for many lines since it
	" uses "search()" with "\%v" to find the unindented levels
	"
	" NOTE: if the current level of indentation is 1 (ie in virtual column 1),
	"       then the entire buffer will be selected
	"
	" WARNING: python devs have been known to become addicted to this

	" magic is needed for this
	let l:magic = &magic
	set magic

	" move to beginning of line and get virtcol (current indentation level)
	" BRAM: there is no searchpairvirtpos() ;)
	normal! ^
	let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')

	" pattern matching anything except empty lines and lines with recorded
	" indentation level
	let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'

	" find first match (backwards & don't wrap or move cursor)
	let l:start = search(l:pat, 'bWn') + 1

	" next, find first match (forwards & don't wrap or move cursor)
	let l:end = search(l:pat, 'Wn')

	if (l:end !=# 0)
		" if search succeeded, it went too far, so subtract 1
		let l:end -= 1
	endif

	" go to start (this includes empty lines) and--importantly--column 0
	execute 'normal! '.l:start.'G0'

	" skip empty lines (unless already on one .. need to be in column 0)
	call search('^[^\n\r]', 'Wc')

	" go to end (this includes empty lines)
	execute 'normal! Vo'.l:end.'G'

	" skip backwards to last selected non-empty line
	call search('^[^\n\r]', 'bWc')

	" go to end-of-line 'cause why not
	normal! $o

	" restore magic
	let &magic = l:magic
endfunction

" "in indentation" (indentation level sans any surrounding empty lines)
xnoremap <silent> ii :<c-u>call <sid>inIndentation()<cr>
onoremap <silent> ii :<c-u>call <sid>inIndentation()<cr>

function! s:aroundIndentation()
	" select all text in the current indentation level including any emtpy
	" lines that precede or follow the current indentation level;
	"
	" the current implementation is pretty fast, even for many lines since it
	" uses "search()" with "\%v" to find the unindented levels
	"
	" NOTE: if the current level of indentation is 1 (ie in virtual column 1),
	"       then the entire buffer will be selected
	"
	" WARNING: python devs have been known to become addicted to this

	" magic is needed for this (/\v doesn't seem work)
	let l:magic = &magic
	set magic

	" move to beginning of line and get virtcol (current indentation level)
	" BRAM: there is no searchpairvirtpos() ;)
	normal! ^
	let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')

	" pattern matching anything except empty lines and lines with recorded
	" indentation level
	let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'

	" find first match (backwards & don't wrap or move cursor)
	let l:start = search(l:pat, 'bWn') + 1

	" NOTE: if l:start is 0, then search() failed; otherwise search() succeeded
	"       and l:start does not equal line('.')
	" FORMER: l:start is 0; so, if we add 1 to l:start, then it will match
	"         everything from beginning of the buffer (if you don't like
	"         this, then you can modify the code) since this will be the
	"         equivalent of "norm! 1G" below
	" LATTER: l:start is not 0 but is also not equal to line('.'); therefore,
	"         we want to add one to l:start since it will always match one
	"         line too high if search() succeeds

	" next, find first match (forwards & don't wrap or move cursor)
	let l:end = search(l:pat, 'Wn')

	" NOTE: if l:end is 0, then search() failed; otherwise, if l:end is not
	"       equal to line('.'), then the search succeeded.
	" FORMER: l:end is 0; we want this to match until the end-of-buffer if it
	"         fails to find a match for same reason as mentioned above;
	"         again, modify code if you do not like this); therefore, keep
	"         0--see "NOTE:" below inside the if block comment
	" LATTER: l:end is not 0, so the search() must have succeeded, which means
	"         that l:end will match a different line than line('.')

	if (l:end !=# 0)
		" if l:end is 0, then the search() failed; if we subtract 1, then it
		" will effectively do "norm! -1G" which is definitely not what is
		" desired for probably every circumstance; therefore, only subtract one
		" if the search() succeeded since this means that it will match at least
		" one line too far down
		" NOTE: exec "norm! 0G" still goes to end-of-buffer just like "norm! G",
		"       so it's ok if l:end is kept as 0. As mentioned above, this means
		"       that it will match until end of buffer, but that is what I want
		"       anyway (change code if you don't want)
		let l:end -= 1
	endif

	" finally, select from l:start to l:end
	execute 'normal! '.l:start.'G0V'.l:end.'G$o'

	" restore magic
	let &magic = l:magic
endfunction

" "around indentation" (indentation level and any surrounding empty lines)
xnoremap <silent> ai :<c-u>call <sid>aroundIndentation()<cr>
onoremap <silent> ai :<c-u>call <sid>aroundIndentation()<cr>

command! -nargs=1 FndArg execute 'args `find . -name *' . <q-args> . '* -print` .'
command! -nargs=1 Fnd execute 'vimgrep /' . <q-args> . '/j ./**/*.*'
command! -nargs=1 Silent
\   execute 'silent !' . <q-args>
\ | execute 'redraw!'

set shell=/bin/zsh
" set runtimepath^=~/.vim/bundle/ctrlp.vim
set rtp+=/usr/local/opt/fzf
packadd! matchit
call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'elixir-lang/vim-elixir'
Plug 'eagletmt/ghcmod-vim', {'for': 'haskell'}
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Shougo/neocomplete.vim', {'for': 'haskell'}
Plug 'eagletmt/neco-ghc', {'for': 'haskell'}
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'bkad/CamelCaseMotion'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'grassdog/tagman.vim'
Plug 'wellle/targets.vim'
Plug 'markonm/traces.vim'
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

" augroup Javascript
"   autocmd!
"   autocmd FileType javascript setlocal omnifunc=tsuquyomi#complete
" augroup END



function! ArgsGrep(folder, pattern)
  exe 'args `grep -Rl ' . a:pattern . ' ' . a:folder . '`'
endfunction

function! DelTagOfFile(file)
	let fullpath = a:file
	let cwd = getcwd()
	let tagfilename = cwd . "/tags"
	let f = substitute(fullpath, cwd . "/", "", "")
	let f = escape(f, './')
	let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
	let resp = system(cmd)
endfunction

function! UpdateTags()
	let f = expand("%:p")
	let cwd = getcwd()
	let tagfilename = cwd . "/tags"
	let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
	call DelTagOfFile(f)
	let resp = system(cmd)
endfunction

" update tags on c# files
" autocmd BufWritePost *.cpp,*.h,*.c,*.cs call UpdateTags()

function! Sql(q)
    let cmd = 'sqlcmd -s ", " -Q "set nocount on;' . a:q . '" -h-1 | tr "\r" " " | tr "\n" "+" | tr -d " "'
    let resp = system(cmd)
    echom resp
endfunction

function! Diff(a, b)
    exe "tabe"
    exe "new"
    exe "only"
    exe "put " . a:a
    exe "diffthis"
    exe "vnew"
    exe "put " . a:b
    exe "diffthis"
endfunction

function! EndDiff()
    exe "tabclose!"
endfunction

function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction

function! SwitchTabPage(n)
    if a:n == tabpagenr()
        return
    else
        exe "normal " . a:n . "gt<CR>"
    endif
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

set ttimeoutlen=50  " Make Esc work faster
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

" " single quotes over double quotes
" " Prettier default: false
" let g:prettier#config#single_quote = 'true'
"
" let g:prettier#config#semi = 'true'

" " avoid|always
" " Prettier default: avoid
" let g:prettier#config#arrow_parens = 'always'

" " none|es5|all
" " Prettier default: none
" let g:prettier#config#trailing_comma = 'all'

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
  exe "silent !sh ~/dark-theme.sh"
  exe "set background=dark"
  exe "colorscheme solarized"
  highlight ColorColumn ctermbg=white
  let $CURRENT_TERMINAL_THEME = 'dark'
endfunction
function! LightMode()
  exe "silent !sh ~/light-theme.sh"
  exe "set background=light"
  exe "colorscheme solarized"
  highlight ColorColumn ctermbg=black
  let $CURRENT_TERMINAL_THEME = 'light'
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
