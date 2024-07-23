let g:mapleader = ' '
set nocompatible    "采用vim自己的操作命令
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs', {'for': ['cpp','c','java','python','vim','js','lua', 'glsl', 'lex'] }
Plug 'luochen1990/rainbow', {'for': ['cpp','c','java','python']}

Plug 'preservim/nerdtree', {'on': ['NERDTree','NERDTreeToggle'] }
Plug 'preservim/tagbar', {'on': 'TagbarToggle'}

Plug 'lifepillar/vim-solarized8'

" Plug 'vim-airline/vim-airline'

Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp'}

"所有常用的snippet都在vim-snippets里
Plug 'honza/vim-snippets'
"Ulitsnips 是引擎
Plug 'Sirver/ultisnips'

"注释 
Plug 'preservim/nerdcommenter'

"fzf
Plug 'junegunn/fzf', {'do' :{-> fzf#install()}}
Plug 'junegunn/fzf.vim'
" Files [PATH] 
" Ag 
let g:fzf_layout={ 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }

" 能够调试多种语言的插件，以后可能会用到
" Plug 'puremourning/vimspector'	
Plug 'ycm-core/YouCompleteMe'

Plug 'hrsh7th/vim-eft'
nmap ; <Plug>(eft-repeat)
xmap ; <Plug>(eft-repeat)
omap ; <Plug>(eft-repeat)

nmap f <Plug>(eft-f)
xmap f <Plug>(eft-f)
omap f <Plug>(eft-f)
nmap F <Plug>(eft-F)
xmap F <Plug>(eft-F)
omap F <Plug>(eft-F)

nmap t <Plug>(eft-t)
xmap t <Plug>(eft-t)
omap t <Plug>(eft-t)
nmap T <Plug>(eft-T)
xmap T <Plug>(eft-T)
omap T <Plug>(eft-T)

" custom highlight
let g:eft_highlight = {
\   '1': {
\     'highlight': 'EftChar',
\     'allow_space': v:true,
\     'allow_operator': v:true,
\   },
\   '2': {
\     'highlight': 'EftSubChar',
\     'allow_space': v:false,
\     'allow_operator': v:false,
\   },
\   'n': {
\     'highlight': 'EftSubChar',
\     'allow_space': v:false,
\     'allow_operator': v:false,
\   }
\ }

Plug 'romainl/vim-cool'
let g:CoolTotalMatches = 1

Plug 'tikhomirov/vim-glsl', {'for': ['glsl']}
autocmd! BufNewFile,BufRead *.vs,*.fs,*.gs set ft=glsl

Plug 'junegunn/vim-easy-align'
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

Plug 'sbdchd/neoformat'

call plug#end()
filetype plugin indent on    " required

" branch/tag/commit		Branch/tag/commit of the repository to use
" rtp					Subdirectory that contains Vim plugin
" dir					Custom directory for the plugin
" as					Use different name for the plugin
" do					Post-update hook (string or funcref)
" on					On-demand loading: Commands or <Plug>-mappings
" for					On-demand loading: File types
" frozen				Do not update unless explicitly specified

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings = 1
let g:ycm_key_invoke_completion = '<c-z>'
"  关闭自动显示文档
let g:ycm_auto_hover = 0

set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  { 'c,cpp,python,java,go,erlang,perl,py': ['re!\w{2}'], 'cs,lua,javascript': ['re!\w{2}'],}


"解决ycm与snippets按键冲突问题
"==========================================================================================
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif
if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
"==========================================================================================


" 彩虹括号
let g:rainbow_active=1

"tagbar
let g:tagbar_position='left'
let g:tagbar_width=33
nmap <silent> <C-t> :TagbarToggle<CR>


"nerdtree
nnoremap <silent> <C-p> :NERDTree<CR>
inoremap <silent> <C-p> <ESC>:NERDTree<CR>
nnoremap <silent> <C-p> :NERDTreeToggle<CR>
inoremap <silent> <C-p> <ESC>:NERDTreeToggle<CR>
let g:NERDTreeWinPos = 'right'  "窗口在右侧
let g:NERDTreeHidden = 0    "不显示隐藏文件

"退出vim时 如果只有NERDTree就全部关闭
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" vim-airline
" let laststatus=2
" let g:airline_powerline_fonts=1
" " 打开tabline功能，方便查看Buffer和切换
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#searchcoun#enables = 0
" let g:airline#extensions#tabline#buffer_nr_show = 1
" nnoremap <silent>K :bn<CR>
" inoremap <C-k> <ESC>:bn<CR>
" nnoremap <silent>J :bp<CR>
" inoremap <C-j> <ESC>:bp<CR>
" nnoremap <silent>bb :bd<CR>
" " :bn   :bp     为buffer命令
" " 关闭状态显示空白符号计数
" let g:airline#extensions#whitespace#enabled = 0
" let g:airline#extensions#whitespace#symbol = '!'

" if !exists('g:airline_symbols')
	" let g:airline_symbols = {}
" endif
" " powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbolsbranch = ''
" let g:airline_symbolscolnr = ' :'
" let g:airline_symbolsreadonly = ''
" let g:airline_symbolslinenr = ' :'
" let g:airline_symbolsmaxlinenr = '☰ '
" let g:airline_symbolsdirty='⚡'

"vim-tex
"LaTeX配置
let g:vimtex_compiler_latexmk_engines = {'_':'-xelatex'}
let g:vimtex_compiler_latexrun_engines ={'_':'xelatex'}
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'


"nerdcommenter
"对美化的多行注释使用紧凑语法
let  g:NERDCompactSexyComs  =  1
" Align line-wise comment delimiters flush left 而不是下面的代码缩进
let  g:NERDDefaultAlign  =  ' left '
" 注释后添加空格
let g:NERDSpaceDelims=1

"fzf
nmap <leader>f :FZF<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=dark
autocmd vimenter * ++nested colorscheme solarized8_high
" 打开文件时回到上次编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set smarttab
set tabstop=4
set shiftwidth=4

" "Tab转为4个空格
" set softtabstop=4   

set noexpandtab     "不要用空格代替制表符

set nobackup		"不需要备份文件
set noswapfile		"不创建临时交换文件
set nowritebackup	"编辑的时候不需要备份文件
set noundofile		"不创建撤销文件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"gvim config
set go=
set guifont=YaHeiConsolasHybrid\ 14
set shortmess=atI   "启动时不显示援助乌干达儿童
winpos 235 235

"在不同的模式中使用不同的光标形式, 只在gvim中生效
if empty($TMUX)
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
set nu  "显示行号
set rnu	"相对行号
set showcmd     "显示命令
set showmode    "显示当前模式
syntax on   "语法高亮
set mouse=a     "支持鼠标
set encoding=utf-8

"set t_Co=256        "使用256色
"使用真彩
if has("termguicolors")
 set termguicolors
endif
" set term=screen-256color

set autoindent      "按下回车键后，下一行的缩进会自动跟上一行的缩进保持一致
set smartindent
set cursorline      "光标所在行高亮
"hi Cursorline   cterm=NONE  ctermbg=black 
"设置背景颜色为黑色
set wrap    "自动折行，即太长的行分成几行显示
"set nowrap "关闭自动折行
"set sidescrolloff=15 
"水平滚动时，光标距离行首或者行尾的位置，在不折行时有用
set scrolloff=3
"垂直滚动时，光标距离行首或者行尾的位置=3
set ruler   "在状态栏显示光标的当前位置

set showmatch
"光标在遇到括号时，自动高亮对应的另一个括号
set matchtime=1     "匹配括号高亮的时间
set hlsearch
set incsearch
"搜索时，高亮显示匹配结果
set incsearch
"输入搜索模式时，每输入一个字符，就自动调到第一个匹配的结果
set ignorecase
"搜索时忽略大小写
" set undofile
"保留撤销历史
"Vim 会在编辑时保存操作历史，用来供用户撤消更改。默认情况下，操作记录只 
""在本次编辑时有效，一旦编辑结束、文件关闭，操作历史就消失了。
"打开这个设置，可以在文件关闭后，操作记录保留在一个文件里面，继续存在
"这意味着，重新打开一个文件，可以撤销上一次编辑时的操作。撤消文件是跟
"原文件保存在一起的隐藏文件，文件名以.un~开头。
" set undodir=~/.vim/.undo// 
"设置操作历史文件的保存位置。
"结尾的//表示生成的文件名带有绝对路径，路径中用%替换目录分隔符
"这样可以防止文件重名
set autochdir
"自动切换工作目录
"这主要用在一个 Vim 会话之中打开多个文件的情况
"默认的工作目录是打开的第一个文件的目录。
"该配置可以将工作目录自动切换到正在编辑的文件的目录。
set noerrorbells
"出错时不要发出响声
"set visualbell
"出错时，发出视觉提示
set history=1000
"vim需要记住1000次历史操作
set autoread
"打开文件监视
"如果在编辑过程中文件发生外部改变（被其他编辑器更改）就会发出提示
set wildmenu
set wildmode=longest:list,full
"命令模式下，底部操作指令按下 Tab 键自动补全
"第一次按下 Tab，会显示所有匹配的操作指令的清单
"第二次按下 Tab，会依次选择各个指令。

set foldcolumn=0
set foldmethod=indent
set foldlevel=10
set foldenable  "允许折叠

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘映射
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>  :TlistUpdate<CR>
imap <F5> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>  :TlistUpdate<CR>

"<F10> 编译
nnoremap <F10> :call Compile()<CR>

func! Compile()
    exec "w"
    if &filetype == 'c'
        exec '!gcc-11 -g % -o %<'
    elseif &filetype == 'cpp'
        exec '!g++-11 -g % -o %<'
	elseif &filetype == 'rust'
		exec '!rustc %'
    endif
endfunc

"<F9> 运行
nnoremap <F9> :call RunFunction()<CR>

func! RunFunction()
    exec '!./%<'
endfunc

"<F8> 调试
nnoremap <F8> :call RunGdb()<CR>

func! RunGdb()
    exec '!gdb -tui ./%<'
endfunc

map <C-a> gg V G
vmap <C-c> "+y
nmap <silent>nh :noh<CR>
nnoremap L g_
nnoremap H 0

imap jj <ESC>
nmap <leader>h <plug>(YCMHover)	
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

noremap J :bp<cr>
noremap K :bn<cr> 
nnoremap <c-o> <c-o>zz


" vim-powered terminal in split window
" map <Leader>t :term ++close<cr>
" tmap <Leader>t <c-w>:term ++close<cr>

" vim-powered terminal in new tab
" map <Leader>T :tab term ++close<cr>
" tmap <Leader>T <c-w>:tab term ++close<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype on

set wildoptions=pum  
" set laststatus=2
" function! GitBranch()
  " return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" endfunction

" function! StatuslineGit()
  " let l:branchname = GitBranch()
  " return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
" endfunction

" set statusline=
" set statusline+=%{StatuslineGit()}
" set statusline+=%#LineNr#
" set statusline+=\ %f
" set statusline+=%m
" set statusline+=%=
" set statusline+=%#CursorColumn#
" set statusline+=\ %y
" set statusline+=\ %l:%c

