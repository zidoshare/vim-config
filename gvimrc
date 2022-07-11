set lines=45
set columns=160

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
if has("gui_macvim")
  set guifont=CaskaydiaCove\ Nerd\ Font\ Mono:h16
else
  set guifont=CaskaydiaCove\ Nerd\ Font\ Mono\ 10
endif
" 底部空白条
set guiheadroom=0
