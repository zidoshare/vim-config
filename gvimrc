set lines=45
set columns=160
" ======= 恢复上次文件打开位置 ======= "
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"不显示工具/菜单栏
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions-=b
" 使用内置 tab 样式而不是 gui
set guioptions-=e
set guifont=CaskaydiaCove\ Nerd\ Font\ Mono\ 10
" 底部空白条
set guiheadroom=0
