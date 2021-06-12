"basic set
set nocompatible   "不兼容旧的vi命令
set encoding=utf-8                      "将字符编码设置为UTF-8
set termencoding=utf-8                  "将终端使用的字符编码设置为UTF-8
set fileencodings=utf-8,gbk,latin1      "将磁盘文件的字符编码设置为UTF-8
set nofoldenable
syntax on                               "打开语法高亮，自动识别代码，使用多种颜色显示
filetype plugin indent on               "开启文件类型检查

"indent set
set autoindent     "自动缩进
set softtabstop=4           " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4               " 设定 tab 长度为 4
set shiftwidth=4       "表示缩进时每一级的缩进长度
set expandtab           "输入 tab 时自动将其转化为空格

"appearance
set number          "设置行号
augroup relative_numbser
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END

set cursorline      "突出显示当前行
    hi CursorLine cterm=none ctermbg=DarkMagenta ctermfg=White  "高亮当前行
set colorcolumn=120  "设置列宽提示，提示注意代码长度
set textwidth=120
set laststatus=2 " 总是显示状态栏
set ruler          "在状态栏显示光标所在行、列
set showcmd       "显示输入的vim命令

"search
set hlsearch        "高亮搜索
set showmatch       "自动显示配对的括号
set incsearch      "搜索时光标自动跳转匹配位置
set path=./;,**
set tags=./tags';,tags

"edit
"set spell spelllang=en_us   "打开英文单词的拼写检查
set nobackup                "不创建备份文件，默认会在原文件名末尾加一个波浪号~
set noswapfile              "不创建交换文件,结尾是.swp
set noerrorbells  "出错时不响铃
set novisualbell "出错是不要视觉提示
set autowrite      "自动存盘
set history=1000  "记住多少次历史操作
set autochdir         "以当前目录作为工作目录
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<  "tab显示>-,trail尾部空格显示-，左侧超出屏幕显示>,右侧超出屏幕标指为<
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickly Run
map <F5> :call CompileRunGcc()<CR>
function! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec '!g++ % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'cpp'
        exec '!g++ % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'python'
        exec '!python3 %'
       " exec '!time python3.6 %'
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == "java"
        exec '!javac %'
        exec "!time java %<"
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"将:&&重隐射为&
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"重隐射*,#，查找高亮选择的文本，而不仅是字符串
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype. '\'), '\n', '\\n','g')
  let @s = temp
endfunction

"%%从行中任何位置直接跳转到( )上
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'

"清除并重绘显示屏，清除高亮"
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"创建新文件时，自动添加文件头注释
"autocmd BufNewFile *.c,*.cpp,*.sh,*.py,*.java exec ":call SetTitle()"
"func SetTitle() 定义函数SetTitle，自动插入文件头
    "如果文件类型为.c或者.cpp文件
    "if (&filetype == 'c' || &filetype == 'cpp')
        "call setline(1, "/*************************************************************************")
        "call setline(2, "\ @Author: 程胜")
        "call setline(3, "\ @Created Time : ".strftime("%c"))
        "call setline(4, "\ @File Name: ".expand("%"))
        "call setline(5, "\ @Description:")
        "call setline(6, " ************************************************************************/")
        "call setline(7,"")
    "endif
    "如果文件类型为.sh文件
    "if &filetype == 'shell'
        "call setline(1, "\#!/bin/sh")
        "call setline(2, "\# Author: 你的名字")
        "call setline(3, "\# Created Time : ".strftime("%c"))
        "call setline(4, "\# File Name: ".expand("%"))
        "call setline(5, "\# Description:")
        "call setline(6,"")
    "endif
    "如果文件类型为.py文件
    "if &filetype == 'python'
        "call setline(1, "\#!/usr/bin/env python")
        "call setline(2, "\# -*- coding=utf8 -*-")
        "call setline(3, "\"\"\"")
        "call setline(4, "\# Author: 程胜")
        "call setline(5, "\# Created Time : ".strftime("%c"))
        "call setline(6, "\# File Name: ".expand("%"))
        "call setline(7, "\# Description:")
        "call setline(8, "\"\"\"")
        "call setline(9,"")
    "endif
    "如果文件类型为.java文件
    "if &filetype == 'java'
        "call setline(1, "//coding=utf8")
        "call setline(2, "/**")
        "call setline(3, "\ *\ @Author: 程胜")
        "call setline(4, "\ *\ @Created Time : ".strftime("%c"))
        "call setline(5, "\ *\ @File Name: ".expand("%"))
        "call setline(6, "\ *\ @Description:")
        "call setline(7, "\ */")
        "call setline(8,"")
        "endif
"endfunc
"autocmd BufNewfile * normal G   " 新建文件时，以正常模式自动将光标移动到文件末尾
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-pathogen'
Plug 'fisadev/fisa-vim-config'
Plug 'nathanaelkane/vim-indent-guides' " 代码块竖线
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'vim-scripts/YankRing.vim'
"Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/ShowMarks'
Plug 'ntpeters/vim-better-whitespace'
Plug 'luochen1990/rainbow'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
""Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
""Plug 'tpope/vim-rails'
Plug 'ycm-core/YouCompleteMe'
Plug 'Yggdroot/indentLine'
Plug 'mattn/emmet-vim'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/c.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'Chiel92/vim-autoformat'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'alvan/vim-closetag'
Plug 'valloric/MatchTagAlways'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'altercation/vim-colors-solarized'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme='papercolor'
Plug 'suan/vim-instant-markdown'
    let g:instant_markdown_slow = 1
    let g:instant_markdown_autostart = 0
Plug 'kien/ctrlp.vim'
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_map = '<leader>p'
    let g:ctrlp_cmd = 'CtrlP'
    map <leader>f :CtrlPMRU<CR>
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
        \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
        \}
    let g:ctrlp_working_path_mode=0
    let g:ctrlp_match_window_bottom=1
    let g:ctrlp_max_height=15
    let g:ctrlp_match_window_reversed=0
   let g:ctrlp_mruf_max=500
    let g:ctrlp_follow_symlinks=1
Plug 'rking/ag.vim'
    nmap <c-t> :Ag!<space>
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop'  }
Plug 'terryma/vim-multiple-cursors'

 call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"ctags插件
"autocmd BufWritePost * call system("ctags -R")  "保存文件时自动调用ctags
nnoremap <F10> :!ctags -R<CR>

"NERDTree"
"map <F10> :NERDTreeToggle<CR>

"tagbar
nmap <F9> :TagbarToggle<CR>
let g:tagbar_width = 40
let g:tagbar_left = 1
let g:tagbar_right = 1

"EasyAlign
nmap ga <Plug>(EasyAlign)
vmap ga <Plug>(EasyAlign)

"vim-indent-guides"
""let g:indent_guides_enable_on_vim_startup = 1  "enable
let g:indent_guides_start_level = 1            "对齐线的缩进级别
let g:indent_guides_guide_size = 1             "size，1 char
let g:indent_guides_tab_guides = 0             "添加行，对tab对齐的禁用

augroup vim-commentary
    autocmd!
    autocmd FileType python,shell set commentstring=#\ %s                 " 设置Python注释字符
    autocmd FileType mako set cms=##\ %s
augroup END

"YankRing.vim"
nmap <Leader>y :YRShow<CR>  "<leader>指键盘上的\"

"vim-better-whitespace
let g:better_whitespace_enabled=1       "显示尾部空格
let g:strip_whitespace_on_save=1        "去除尾部空格

"rainbow
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

"YouCompleteMe
map <F8> :YcmDiags<CR>
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'  "寻找ycm全局配置文件
let g:ycm_key_invoke_completion = '<c-z>'   "修改补全快捷键
let g:ycm_min_num_identifier_candidate_chars = 2    "输入第2个字符就开始补全
let g:ycm_collect_identifiers_from_tag_files = 1 "使用ctags生成的tags文件
let g:ycm_confirm_extra_conf=0    "打开vim时不再询问是否加载ycm_extra_conf.py配置
set completeopt=menu,menuone
let g:ycm_error_symbol = '>>'    "错误的显示符号
let g:ycm_warning_symbol = '>*'  "警告的显示符号
let g:ycm_complete_in_comments=1  "在注释中也可补全
let g:ycm_show_diagnostics_ui=0 "0表示禁用ycm自带的syntastic插件
map gd :YcmCompleter GoToDefinitionElseDeclaration<CR>

"indentLine
let g:indentLine_enabled = 1
set foldmethod=indent "基于缩进折叠"
set nofoldenable  " 启动vim时关闭折叠

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"C language
"let g:ycm_show_diagnostics_ui = 0       "启用对C族的语法检查(YouCompleteMe默认禁止)"
"python
let g:syntastic_python_checkers = ['flake8','pyflakes','python']    "choose checker
"let g:syntastic_python_pyflakes_exec = 'python'  "指定pyrhon程序运行指定的checker，一般不用设置
"javaScript
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint'

"vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1    "显示缓冲区号，并可用一下映射切换
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

"auto-pairs
let g:AutoPairsFlyMode = 1

"vim-autoformat
noremap <F7> :Autoformat<CR> " Ycm 是否安装成功诊断
let g:autoformat_verbosemode=1   "output errors on formatters that failed
"for C, C++, C++/CLI, Objective‑C, C#, and Java Source Code
let g:formatdef_astyle_c = '"astyle --style=attach --pad-oper"'
let g:formatters_c = ['astyle_c']
let g:formatters_cpp = ['astyle_c']
let g:formatters_java = ['astyle_c']
"for python
let g:formatdef_autopep8 = "'autopep8 - --aggressive --aggressive'"
let g:formatters_python = ['autopep8']
"javaScript,CSS,HTML
let g:formatdef_jsbeautify_javascrip= '"js-beautify -s 4 -"'
let g:formatters_javascript = ['jsbeautify_javascrip']

"Emmet
let g:user_emmet_leader_key='<Tab>'

"MatchTagAlways
nnoremap <leader>% :MtaJumpToOtherTag<CR>

"vim-css3-syntax
augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END

"vim-colors-solarized
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

"vim-javascript
map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
set foldmethod=syntax
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = " "
let g:javascript_conceal_underscore_arrow_function = " "
set conceallevel=1

augroup isort
    " \i mapping: use isort sort import python packages
    autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>
augroup END

