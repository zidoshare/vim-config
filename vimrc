scriptencoding utf-8
set encoding=utf8
" ============================================================================
" Author: zido
" Blog: https://zido.site
" Version: v0.10.0
" Update Time: 2024-01-29

" ============================================================================

" 配置 leader 键，放在最上面方便修改
let mapleader = "\\"

" 不兼容 vi
set nocompatible

" Vim-Plug 初始化
let plug_visible=1
let plug_file=expand('~/.vim/autoload/plug.vim')
if !filereadable(plug_file)
  echo "Installing vim-plug"
  echo ""
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let plug_visible=0
endif

" ============================================================================
" 插件管理
" ============================================================================
call plug#begin('~/.vim/plugged')
" <leader>e 左侧文件树插件
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'ryanoasis/vim-devicons'
" 注释插件，<leader>cc 注释，<leader>cc 取消注释
Plug 'preservim/nerdcommenter'
" 美化
Plug 'flazz/vim-colorschemes'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" <leader>ff 输入文件名，模糊搜索跳转
" Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" fzf 文件管理
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" tab 管理， <leader>mt 打开标签页管理器
" Plug 'kien/tabman.vim'

" Markdown
Plug 'godlygeek/tabular'

" 一些中文
Plug 'voldikss/vim-translator'
Plug 'yianwillis/vimcdoc'

" 突出显示之外的空格
" 使用 <leader>tw 去除多余空格
Plug 'ntpeters/vim-better-whitespace'

" go 语言插件
" 生成 gotests
Plug 'buoto/gotests-vim'

" <F8> 开关 tagbar
Plug 'preservim/tagbar'

" c 语言
" c 语言格式化
" Plug 'rhysd/vim-clang-format'

" 书签管理插件
Plug 'MattesGroeger/vim-bookmarks'

" json-c
Plug 'kevinoid/vim-jsonc'

" Kotlin 基本支持
Plug 'udalov/kotlin-vim'

" 帮助编辑
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/argtextobj.vim'
" 一个好用的 `%` 键
Plug 'adelarsq/vim-matchit'
Plug 'fatih/vim-go'
" 输入 gJ 把 struct 属性搞成一行，gS 把一行多行
Plug 'AndrewRadev/splitjoin.vim'

Plug 'machakann/vim-highlightedyank'

Plug 'github/copilot.vim'

Plug 'honza/vim-snippets'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

call plug#end()

if plug_visible == 0
  echo "Installing Plugins..."
  echo ""
  :PlugInstall
endif

" ============================================================================
" 常规编辑器设置
" ============================================================================
colorscheme xoria256
let g:airline_theme='molokai'
let g:airline_powerline_fonts = 1
filetype plugin indent on
filetype indent on
syntax on
" set cursorline
" set cursorcolumn
set nu
set rnu
set ruler
set t_Co=256
set cindent
" 总是显示状态栏
set laststatus=2
set hlsearch
set expandtab
set smartindent
set smarttab
set complete-=i
" 关闭自动折行
" set nowrap
" set hidden
"set showmatch
set tabstop=2
set softtabstop=2
set backspace=2
set shiftwidth=2
set autoindent
set scrolloff=10
set incsearch
set wildmenu
hi ColorColumn ctermbg=238 guibg=lightgrey
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set directory=~/.vim/dirs/tmp
set backup
set backupdir=~/.vim/dirs/backups
set undofile
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'
if !isdirectory(&backupdir)
  call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
  call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
  call mkdir(&undodir, "p")
endif

" ======= 设置当文件被外部改变的时侯自动读入文件 ======= "
if exists("&autoread")
  set autoread
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tab_nr = 1

set synmaxcol=256
set ttyfast " u got a fast terminal
set ttyscroll=3
set lazyredraw " to avoid scrolling problems

" 内置功能快捷键
" ==================== Tab 管理 ====================
" Create a new tab with tu
noremap tu :tabe<CR>
noremap tU :tab split<CR>
" Move around tabs with tn and ti
noremap tn :tabnext<CR>
noremap tp :tabprev<CR>
" Move the tabs with tmn and tmi
noremap tmn :-tabmove<CR>
noremap tmp :+tabmove<CR>

" 配置在底部打开终端
noremap <leader>tt :bel ter ++rows=16<CR>
nmap - o<Esc>k
nmap _ o<Esc>

"为不同的文件类型设置不同的空格数替换TAB
autocmd FileType php,python,java,perl,kotlin set ai
autocmd FileType php,python,java,perl,kotlin set sw=4
autocmd FileType php,python,java,perl,kotlin set ts=4
autocmd FileType php,python,java,perl,kotlin set sts=4
autocmd FileType proto,javascript,html,css,xml set ai
autocmd FileType proto,javascript,html,css,xml set sw=2
autocmd FileType proto,javascript,html,css,xml set ts=2
autocmd FileType proto,javascript,html,css,xml set sts=2
autocmd FileType go set sw=4
autocmd FileType go set ts=4
autocmd FileType go set sts=4
autocmd FileType go set noexpandtab
autocmd FileType vim,tex let b:autoformat_autoindent=0

" set color for nerd tree
" NERDTress File highlighting
let g:airline#extensions#nerdtree_statusline = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
autocmd StdinReadPre * let s:std_in=1

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ 'Modified'  :'✹',
      \ 'Staged'    :'✚',
      \ 'Untracked' :'✭',
      \ 'Renamed'   :'➜',
      \ 'Unmerged'  :'═',
      \ 'Deleted'   :'✖',
      \ 'Dirty'     :'✗',
      \ 'Ignored'   :'☒',
      \ 'Clean'     :'✔︎',
      \ 'Unknown'   :'?',
      \ }
" nerdtree打开关闭
map <leader>e :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>
" tagbar打开关闭
map <F8> :TagbarToggle<CR>

" 删除空格
nnoremap <leader>tw :StripWhitespace<CR>

let g:clang_format#code_style = "gnu"
"let g:clang_format#style_options = {
"            \ "AccessModifierOffset" : -4,
"            \ "AllowShortIfStatementsOnASingleLine" : "true",
"            \ "AlwaysBreakTemplateDeclarations" : "true",
"            \ "Standard" : "C11"}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
autocmd FileType c ClangFormatAutoEnable

" 书签管理
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=233 ctermfg=NONE
let g:bookmark_highlight_lines = 1
" 书签自动保存
let g:bookmark_auto_save = 1
let g:bookmark_auto_close = 1
let g:bookmark_show_toggle_warning = 0
let g:bookmark_center = 1
let g:bookmark_display_annotation = 1

nmap <Leader><Leader> <Plug>BookmarkToggle
nmap <Leader>mi <Plug>BookmarkAnnotate
nmap <Leader>ma <Plug>BookmarkShowAll
nmap <Leader>mj <Plug>BookmarkNext
nmap <Leader>mk <Plug>BookmarkPrev
nmap <Leader>mc <Plug>BookmarkClear
nmap <Leader>mx <Plug>BookmarkClearAll
nmap <Leader>mkk <Plug>BookmarkMoveUp
nmap <Leader>mjj <Plug>BookmarkMoveDown
nmap <Leader>mg <Plug>BookmarkMoveToLine

let g:bookmark_no_default_key_mappings = 1

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-s': 'vsplit' }

" Default fzf layout
" - Popup window (center of the screen)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
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

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'
nmap <leader>ff :FZF<cr>
nmap <leader>fh :<C-U><C-R>=printf("Rg %s",expand("<cword>"))<CR><CR>
vnoremap <leader>fh y:<C-R>=printf("Rg \"%s\"",escape(@",'/\'))<CR><CR>
set selection=inclusive
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" 使用 // 搜索 visual 模式下选中的文本
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

function! ToggleVerbose()
  if !&verbose
    set verbosefile=~/.log/vim/verbose.log
    set verbose=15
  else
    set verbose=0
    set verbosefile=
  endif
endfunction
let &t_ut=''

let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_test_show_name = 0
let g:go_fmt_command = "goimports"
" let g:go_auto_sameids = 1
let g:go_diagnostics_enabled = 2
nmap ]e :cnext<CR>
nmap [e :cnext<CR>
nmap gi :GoImplentations<CR>
nmap <leader>cr :GoRename<CR>
nnoremap <leader>a :cclose<CR>
