scriptencoding utf-8
set encoding=utf8
" ============================================================================
" Author: zido
" Blog: https://zido.site
" Version: v0.5.0
" Update Time: 2022-07-03

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
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let plug_visible=0
endif

" ============================================================================
" 插件管理
" ============================================================================
call plug#begin('~/.vim/plugged')
" <leader>e 左侧文件树插件
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin'
" 注释插件，<leader>cc 注释，<leader>cc 取消注释
Plug 'preservim/nerdcommenter'
" 美化
Plug 'flazz/vim-colorschemes'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
" <leader>ff 输入文件名，模糊搜索跳转
" <C-F> 当前缓冲区搜索
" <C-H> 全局搜索
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" tab 管理， <leader>mt 打开标签页管理器
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

" 突出显示之外的空格
" 使用 <leader>tw 去除多余空格
Plug 'ntpeters/vim-better-whitespace'

" LSP 语言服务器
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" go 语言插件
" 生成 gotests
Plug 'buoto/gotests-vim'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" <F8> 开关 tagbar
Plug 'preservim/tagbar'

" c 语言
" c 语言格式化
Plug 'rhysd/vim-clang-format'

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

Plug 'machakann/vim-highlightedyank'
call plug#end()

if plug_visible == 0
    echo "Installing Plugins..."
    echo ""
    :PlugInstall
endif

" ============================================================================
" 常规编辑器设置
" ============================================================================
filetype plugin indent on
filetype indent on
syntax on
set cursorline
set cursorcolumn
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
set hidden
"set showmatch
set tabstop=2
set softtabstop=2
set backspace=2
set shiftwidth=2
set autoindent

colorscheme xoria256
let g:airline_theme='molokai'
let g:airline_powerline_fonts = 1

" 内置功能快捷键

" 配置在底部打开终端
noremap <leader>tt :bel ter ++rows=16<CR>

" 搜索
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 1
" 需要安装 ripgrep
let g:Lf_DefaultExternalTool='rg'
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
" Show icons, icons are shown by default
let g:Lf_ShowDevIcons = 1

let g:Lf_StlColorscheme = 'powerline'
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
        \ "--type-add web:*.{html,css,js}*",
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
noremap fh :<C-U><C-R>=printf("Leaderf! rg --heading -e %s", expand("<cword>"))<CR>
" search word under cursor, the pattern is treated as regex,
" append the result to previous search results.
" noremap <C-S-G> :<C-U><C-R>=printf("Leaderf! rg --append -e %s ", expand("<cword>"))<CR>
" search word under cursor literally only in current buffer
" 当前缓冲区搜索
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR>
noremap ff :<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -e %s ", expand("<cword>"))<CR>
" search word under cursor literally in all listed buffers
" noremap <leader>fd :<C-U><C-R>=printf("Leaderf! rg -F --all-buffers -e %s ", expand("<cword>"))<CR>
" search visually selected text literally, don't quit LeaderF after accepting an entry
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F --stayOpen -e %s ", leaderf#Rg#visual())<CR>
" recall last search. If the result window is closed, reopen it.
noremap go :<C-U>Leaderf! rg --recall<CR>

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
    autocmd FileType markdown nmap <leader>mp <Plug>MarkdownPreview
    autocmd FileType markdown nmap <leader>ms <Plug>MarkdownPreviewStop
    autocmd FileType markdown nmap <leader>mt <Plug>MarkdownPreviewToggle
augroup END
" markdown 不折叠
let g:vim_markdown_folding_disabled = 1

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
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_highlight_lines = 1
" 书签自动保存
let g:bookmark_auto_save = 1
let g:bookmark_auto_close = 1
let g:bookmark_show_toggle_warning = 0
let g:bookmark_center = 1
let g:bookmark_display_annotation = 1

nmap <Leader><Leader> <Plug>BookmarkToggle
nmap <Leader>bi <Plug>BookmarkAnnotate
nmap <Leader>ba <Plug>BookmarkShowAll
nmap <Leader>bj <Plug>BookmarkNext
nmap <Leader>bk <Plug>BookmarkPrev
nmap <Leader>bc <Plug>BookmarkClear
nmap <Leader>bx <Plug>BookmarkClearAll
nmap <Leader>bkk <Plug>BookmarkMoveUp
nmap <Leader>bjj <Plug>BookmarkMoveDown
nmap <Leader>bg <Plug>BookmarkMoveToLine

let g:bookmark_no_default_key_mappings = 1
" coc config
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("nvim-0.5.0") || has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif

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
inoremap <silent><expr> <c-@> coc#refresh()

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> goi <Plug>(coc-implementation)
nmap <silent> gor <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>

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
map <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1, 10) : "\<C-d>"
  nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0, 10) : "\<C-u>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-u>"
  vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-d>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

let g:coc_global_extensions = ['coc-json',
  \ 'coc-rust-analyzer',
  \ 'coc-go',
  \ 'coc-toml',
  \ 'coc-clangd',
  \ 'coc-protobuf',
  \ 'coc-kotlin',
  \ 'coc-snippets',
  \ 'coc-vimlsp',
  \ 'coc-translator',
  \ 'coc-html']


nmap <Leader>tr <Plug>(coc-translator-p)
vmap <Leader>tr <Plug>(coc-translator-pv)
" echo
" nmap <Leader>e <Plug>(coc-translator-e)
" vmap <Leader>e <Plug>(coc-translator-ev)
" " replace
" nmap <Leader>r <Plug>(coc-translator-r)
" vmap <Leader>r <Plug>(coc-translator-rv)

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>
autocmd FileType go nmap gtf :CocCommand go.test.generate.file<cr>
autocmd FileType go nmap gtc :CocCommand go.test.generate.function<cr>
autocmd FileType go nmap gtt :CocCommand go.test.toggle<cr>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)


let g:VM_maps = {}
let g:VM_leader = ','
let g:VM_maps['Motion ,'] = ',,'
let g:VM_maps['Find Under'] = '<C-n>'
let g:VM_maps['Find Subword Under'] = '<C-n>'
let g:VM_maps["Add Cursor Down"] = '<C-j>'
let g:VM_maps["Add Cursor Up"] = '<C-k>'
let g:VM_maps["Undo"] = 'u'
let g:VM_maps["Redo"] = '<C-r>'
