"==========================================
"加载插件
"==========================================

"修改leader键
let mapleader = ','
let g:mapleader = ','

" 开启语法高亮
syntax on


" load bundles
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

"
"==========================================
" General 基础设置
"==========================================

" history存储长度。
set history=2000


filetype on                 "检测文件类型
filetype indent on          "针对不同的文件类型采用不同的缩进格式
filetype plugin on          "允许插件
filetype plugin indent on   "启动自动补全

"非兼容vi模式。去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set nocompatible
set autoread                " 文件修改之后自动载入。
set shortmess=atI           " 启动的时候不显示那个援助索马里儿童的提示

set nobackup                " 取消备份。 视情况自己改
set noswapfile              " 关闭交换文件

" Create undo file
if has('persistent_undo')
  set undolevels=1000         " How many undos
  set undoreload=10000        " number of lines to save for undo
  set undofile                " So is persistent undo ...
  set undodir=/tmp/vimundo
endif

set cursorcolumn            " 突出显示当前行等 不喜欢这种定位可注解
set cursorline              " 突出显示当前行


set wildignore=*.swp,*.bak,*.pyc,*.class

"设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制
"好处：误删什么的，如果以前屏幕打开，可以找回
"
set t_ti= t_te=


"- 则点击光标不会换,用于复制
" 修复ctrl+m 多光标操作选择的bug，但是改变了ctrl+v进行字符选中时将包含光标下的字符
"set selection=exclusive
set selection=inclusive
set selectmode=mouse,key

" No annoying sound on errors
" 去掉输入错误的提示声音
set title                " change the terminal's title
set novisualbell         " don't beep
set noerrorbells         " don't beep
set t_vb=
set tm=500

"==========================================
" Show 展示/排版等界面格式设置
"==========================================

set ruler               "显示当前的行号列号：
set showcmd             "在状态栏显示正在输入的命令
set showmode            "Show current mode

"在上下移动光标时，光标上方或下方至少会保留显示的行数
set scrolloff=7

" 命令行（在状态行下）的高度，默认为1，这里是2
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2

set number                    "显示行号：
set nowrap                    " 取消换行。

set showmatch                 "括号配对情况
" How many tenths of a second to blink when matching brackets
set matchtime=2

"设置文内智能搜索提示
" 高亮search命中的文本。
set hlsearch
" 打开增量搜索模式,随着键入即时搜索
set incsearch
" 搜索时忽略大小写
set ignorecase
" 有一个或以上大写字母时仍大小写敏感
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise

" 代码折叠
set foldenable
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
set foldmethod=indent
set foldlevel=99
"za，打开或关闭当前折叠
"zM，关闭所有折叠
"zR，打开所有折叠

"缩进配置
set smartindent
set autoindent    "打开自动缩进

" tab相关变更
set tabstop=4     " 设置Tab键的宽度        [等同的空格个数]
set shiftwidth=4  " 每一次缩进对应的空格数
set softtabstop=4 " 按退格键时可以一次删掉 4 个空格
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set expandtab     " 将Tab自动转化成空格    [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set shiftround    " 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'

" A buffer becomes hidden when it is abandoned
set hidden
set wildmode=list:longest
set ttyfast

" 00x增减数字时使用十进制
set nrformats=

"==========================================
" file encode, 文件编码,格式
"==========================================
set encoding=utf-8            " 设置新文件的编码为 UTF-8
" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn               "language message zh_CN.UTF-8

set ffs=unix,dos,mac          " Use Unix as the standard file type

"如遇Unicode值大于255的文本，不必等到空格再折行。
set formatoptions+=m
"合并两行中文时，不在中间加空格：
set formatoptions+=B

"==========================================
" others 其它配置
"==========================================
autocmd! bufwritepost ~/.vimrc source % " vimrc文件修改之后自动加载。 linux。

" 自动补全配置
"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu

" 增强模式中的命令行自动完成操作
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.class

"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" Python 文件的一般设置，比如不要 tab 等
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai

" JavaScript 文件, 2个空格缩进
autocmd FileType javascript set tabstop=2 shiftwidth=2 expandtab ai
autocmd FileType coffee set tabstop=2 shiftwidth=2 expandtab ai
autocmd FileType json set tabstop=2 shiftwidth=2 expandtab ai
autocmd FileType html set tabstop=2 shiftwidth=2 expandtab ai
autocmd FileType css set tabstop=2 shiftwidth=2 expandtab ai
autocmd FileType yaml,jade set tabstop=2 shiftwidth=2 expandtab ai


" if this not work ,make sure .viminfo is writable for you
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Remember info about open buffers on close"
set viminfo^=%

" For regular expressions turn magic on
set magic

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

"==========================================
"HotKey  自定义快捷键
"==========================================
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" 设置快捷键将选中文本块复制至系统剪贴板
"vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
" nmap <Leader>p "+p
" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
"nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
"nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
"nmap <Leader>Q :qa!<CR>

"Treat long lines as break lines (useful when moving around in them)
"se swap之后，同物理行上线直接跳
map j gj
map k gk

"Smart way to move between windows 分屏窗口移动
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Go to home and end using capitalized directions
noremap H ^
noremap L $


noremap <F1> <Esc>"
nnoremap <F2> :set number! number?<CR>
nnoremap <F3> :set list! list?<CR>
nnoremap <F4> :set wrap! wrap?<CR>

"use sane regexes"
nnoremap / /\v
vnoremap / /\v

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" --------tab/buffer相关

"Use arrow key to change buffer"
" TODO: 如何跳转到确定的buffer?
" :b1 :b2   :bf :bl
nnoremap [b :bprevious<cr>
nnoremap ]b :bnext<cr>
noremap <left> :bp<CR>
noremap <right> :bn<CR>


" tab 操作
" TODO: ctrl + n 变成切换tab的方法
" http://vim.wikia.com/wiki/Alternative_tab_navigation
" http://stackoverflow.com/questions/2005214/switching-to-a-particular-tab-in-vim
"map <C-2> 2gt
map <leader>th :tabfirst<cr>
map <leader>tl :tablast<cr>

map <leader>tj :tabnext<cr>
map <leader>tk :tabprev<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprev<cr>

map <leader>te :tabedit<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabm<cr>


" 新建tab  Ctrl+t
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>

" TODO: 配置成功这里, 切换更方便, 两个键
" nnoremap <C-S-tab> :tabprevious<CR>
" nnoremap <C-tab>   :tabnext<CR>
" inoremap <C-S-tab> <Esc>:tabprevious<CR>i
" inoremap <C-tab>   <Esc>:tabnext<CR>i
" nnoremap <C-Left> :tabprevious<CR>
" nnoremap <C-Right> :tabnext<CR>

" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Toggles between the active and last active tab "
" The first tab is always 1 "
let g:last_active_tab = 1
" nnoremap <leader>gt :execute 'tabnext ' . g:last_active_tab<cr>
" nnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
" vnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
vnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
autocmd TabLeave * let g:last_active_tab = tabpagenr()


" ------- 选中及操作改键

"Reselect visual block after indent/outdent.调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

" y$ -> Y Make Y behave like other capitals
map Y y$


"新建某些类型文件时，自动插入相应文件头
autocmd BufNewFile  *.sh,*.py  exec ":call SetTitle()"
autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#

"定义函数SetTitle，自动插入文件头
func! SetTitle ()
    if &filetype == 'sh'                    "如果文件类型为.sh文件
        call setline(1,"#!/bin/bash")
        call append(line("."), "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"#coding=utf-8")
        call append(line(".")+1, "")
"    else
        "call setline(1,          "/*************************************************************************")
        "call append(line("."),   "      > File Name: ".expand("%"))
        "call append(line(".")+1, "      > Author: 房文同")
        "call append(line(".")+2, "      > Mail: fangwentong2012@gmail.com")
        "call append(line(".")+3, "      > Encoding:  utf-8")
        "call append(line(".")+4, "      > Created Time: ".strftime("%c"))
        "call append(line(".")+5, " ************************************************************************/")
        "call append(line(".")+6, "")
    endif
    if &filetype == 'cpp'
        call setline(1, "#include<iostream>")
        call append(line("."), "using namespace std;")
        call append(line(".")+1, "")
    endif
    if &filetype == 'c'
        call setline(1, "#include<stdio.h>")
        call append(line("."), "")
    endif
    "if &filetype == 'java'
            "call append(line(".")+6,"public class ".expand("%"))
            "call append(line(".")+7,"")
    "endif
    "新建文件后，自动定位到文件末尾
    normal G
    normal o
endfunc



"C，C++, shell, python, javascript, ruby...等按F5运行
map <F5> :call CompileRun()<CR>
func! CompileRun()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
        exec "!rm ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
        exec "!rm ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
        exec "!rm ./%<.class"
    elseif &filetype == 'sh'
        exec "!time bash %"
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'html'
        exec "!chrome % &"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd' "MarkDown 解决方案为VIM + Chrome浏览器的MarkDown Preview Plus插件，保存后实时预览
        exec "!chrome % &"
    elseif &filetype == 'javascript'
        exec "!time node %"
    elseif &filetype == 'coffee'
        exec "!time coffee %"
    elseif &filetype == 'ruby'
        exec "!time ruby %"
    endif
endfunc

"==========================================
" 主题,及一些展示上颜色的修改
"==========================================
"
" Set extra options when running in GUI mode
if has("gui_running")
    set guifont=Monaco:h15   "Mac OS X
    if has("gui_gtk2")       "GTK2
        set guifont=Monaco\ 12,Monospace\ 12
    endif
    set guioptions-=T
    set guioptions+=e
    set guioptions-=r
    set guioptions-=L
    set guitablabel=%M\ %t
    set showtabline=1
    set linespace=2
    set noimd
    set t_Co=256
endif

colorscheme solarized
set background=dark
set t_Co=256

colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1

" colorscheme tomorrow
" colorscheme tomorrow-night
" colorscheme tomorrow-night-eighties
" colorscheme tomorrow-night-bright

"设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

"" for error highlight，防止错误整行标红导致看不清
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

