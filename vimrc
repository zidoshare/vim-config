scriptencoding utf-8
set encoding=utf8
" ============================================================================
" Author: zido
" Blog: https://zido.site
" Version: v0.1.2
" Update Time: 2021-10-11

" ============================================================================

" 配置 leader 键，放在最上面方便修改
let mapleader=";"

" 不兼容 vi
set nocompatible

" Vim-Plug 初始化
let plug_visible=1
let plug_file=expand('~/.vim/autoload/plug.vim')
if !filereadable(plug_file)
    echo "Installing vim-plug"
    echo ""
    silent curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let plug_visible=0
endif

call plug#begin('~/.vim/plugged')
" <F3> 打开关闭文件树
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin'

" <leader>cc 注释，<leader>cc 取消注释
Plug 'preservim/nerdcommenter'

Plug 'flazz/vim-colorschemes'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" <leader>ff 输入文件名，模糊搜索跳转
" <C-F> 当前缓冲区搜索
" <C-H> 全局搜索
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

Plug 'kien/tabman.vim'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install'  }

" 多光标模式
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" 一些中文
Plug 'voldikss/vim-translator'
Plug 'yianwillis/vimcdoc'
Plug 'rust-lang/rust.vim'
Plug 'vim-syntastic/syntastic', {'tag': '3.10.0'}
" 需要确保已经安装 go rust node/npm
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clang-completer --go-completer --ts-completer --rust-completer'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" 生成 gotests
Plug 'buoto/gotests-vim'
" <F8> 开关 tagbar
Plug 'preservim/tagbar'
" 突出显示之外的空格
" 使用 <leader>tw 去除多余空格
Plug 'ntpeters/vim-better-whitespace'

" c 语言格式化
Plug 'rhysd/vim-clang-format'

" 书签管理插件
" Add/remove bookmark at current line	mm	:BookmarkToggle
" Add/edit/remove annotation at current line	mi	:BookmarkAnnotate <TEXT>
" Jump to next bookmark in buffer	mn	:BookmarkNext
" Jump to previous bookmark in buffer	mp	:BookmarkPrev
" Show all bookmarks (toggle)	ma	:BookmarkShowAll
" Clear bookmarks in current buffer only	mc	:BookmarkClear
" Clear bookmarks in all buffers	mx	:BookmarkClearAll
" Move up bookmark at current line	[count]mkk	:BookmarkMoveUp [<COUNT>]
" Move down bookmark at current line	[count]mjj	:BookmarkMoveDown [<COUNT>]
" Move bookmark at current line to another line	[count]mg	:BookmarkMoveToLine <LINE>
Plug 'MattesGroeger/vim-bookmarks'
call plug#end()

if plug_visible == 0
    echo "Installing Plugins..."
    echo ""
    :PlugInstall
endif

filetype plugin indent on
filetype indent on

" 常规设置
syntax on
set cursorcolumn
set cursorline
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
" 关闭自动折行
set nowrap


" 更好的 backup, swap and undos 存储
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

"set showmatch
set tabstop=2
set softtabstop=2
set backspace=2
set shiftwidth=2
" 将不明字符显示为两个宽度，解决全角字符显示不全的问题
" set ambiwidth=double
"set autoindent
colorscheme molokai
let g:airline_theme='molokai'
let g:airline_powerline_fonts = 1
let g:ycm_confirm_extra_conf=0

" 内置功能快捷键

" 配置在底部打开终端
noremap <leader>t :bel ter ++rows=16<CR>

" 搜索
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 1
let g:Lf_DefaultExternalTool='rg'
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

let g:Lf_RgConfig = [
        \ "--max-columns=150",
        "\ "--type-add web:*.{html,css,js}*",
        \ "--glob=!git/*",
        \ "--hidden"
    \ ]
let g:Lf_PreviewInPopup = 1
" open the preview window automatically
let g:Lf_PreviewResult = {'Rg': 1 }
" search word under cursor, the pattern is treated as regex, and enter normal mode directly
" noremap <leader>r :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search word under cursor, use --heading
" 全局搜索
noremap <C-H> :<C-U><C-R>=printf("Leaderf! rg --heading -e %s", expand("<cword>"))<CR>
" search word under cursor, the pattern is treated as regex,
" append the result to previous search results.
" noremap <C-S-G> :<C-U><C-R>=printf("Leaderf! rg --append -e %s ", expand("<cword>"))<CR>
" search word under cursor literally only in current buffer
" 当前缓冲区搜索
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -e %s ", expand("<cword>"))<CR>
" search word under cursor literally in all listed buffers
" noremap <leader>fd :<C-U><C-R>=printf("Leaderf! rg -F --all-buffers -e %s ", expand("<cword>"))<CR>
" search visually selected text literally, don't quit LeaderF after accepting an entry
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F --stayOpen -e %s ", leaderf#Rg#visual())<CR>
" recall last search. If the result window is closed, reopen it.
noremap go :<C-U>Leaderf! rg --recall<CR>

"为不同的文件类型设置不同的空格数替换TAB
autocmd FileType php,python,java,perl set ai
autocmd FileType php,python,java,perl set sw=4
autocmd FileType php,python,java,perl set ts=4
autocmd FileType php,python,java,perl set sts=4
autocmd FileType javascript,html,css,xml set ai
autocmd FileType javascript,html,css,xml set sw=2
autocmd FileType javascript,html,css,xml set ts=2
autocmd FileType javascript,html,css,xml set sts=2
autocmd FileType go set sw=4
autocmd FileType go set ts=4
autocmd FileType go set sts=4
autocmd FileType go set noexpandtab
autocmd FileType vim,tex let b:autoformat_autoindent=0


set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口

" rust 自动格式化
let g:rustfmt_autosave = 1
let g:rustfmt_autosave_because_of_config = v:null
let g:rustfmt_autosave_if_config_present = v:null
" let g:rustfmt_command = 'cargo fmt -- '
" let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 1
let g:rustfmt_options = ''

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" set color for nerd tree
" NERDTress File highlighting
let g:airline#extensions#nerdtree_statusline = 0
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif:w

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
map <F3> :NERDTreeToggle<CR>
map <leader>e :NERDTreeToggle<CR>
" tagbar打开关闭
map <F8> :TagbarToggle<CR>

" markdown
augroup Markdown
    autocmd!
    autocmd FileType markdown set wrap
    autocmd FileType markdown nmap <F5> <Plug>MarkdownPreview
    autocmd FileType markdown nmap <F6> <Plug>MarkdownPreviewStop
    autocmd FileType markdown nmap <F7> <Plug>MarkdownPreviewToggle
augroup END
" markdown 不折叠
let g:vim_markdown_folding_disabled = 1
nnoremap <leader>tw :StripWhitespace<CR>


" ycm 跳转:w
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:clang_format#code_style = "mozilla"
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
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

autocmd FileType c ClangFormatAutoEnable

" 书签管理
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_highlight_lines = 1
" 书签自动保存
let g:bookmark_auto_save = 1
let g:bookmark_auto_close = 1
let g:bookmark_show_toggle_warning = 0
let g:bookmark_center = 1
let g:bookmark_display_annotation = 1
