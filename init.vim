"设置行数       
set number      
""显示括号匹配
set showmatch
""打开文件类型检测
filetype plugin indent on
"总是显示状态栏
set laststatus=2
""显示光标当前位置
set ruler
"置Tab长度为4空格'
set tabstop=4
""设置自动缩进长度为4空格'
set shiftwidth=4
""突出显示当前行
set cursorline
"突出显示当前列
set cursorcolumn
"
"inoremap ( ()<ESC>i  
"设置（自动补全
"inoremap [ []<ESC>i  
"设置[自动补全
"inoremap { {}<ESC>i  
"设置{自动补全
"inoremap < <><ESC>i  
"设置<自动补全
"inoremap ' ''<ESC>i  
"设置'自动补全
"inoremap " ""<ESC>i  
"设置"自动补全
set autoindent       
"设置自动缩进（与上一行的缩进相同）


"防止退出的输入问题
nnoremap ： :
cnoremap Q! q!
command Wq wq
command Q q
command WQ wq


"自动启动NERDTree
""autocmd VimEnter * NERDTree
call plug#begin()
    Plug 'scrooloose/nerdtree'
    ""vim开始菜单
    Plug 'mhinz/vim-startify'
    "自动补全插件 
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
	"状态栏美化
	Plug 'vim-airline/vim-airline'
	"渐近线
	Plug 'yggdroot/indentline'
	"括号等符号的自动补齐
	Plug 'chun-yang/auto-pairs'
	"cpp
	Plug 'vim-jp/vim-cpp'
	"主题颜色
	Plug 'jpo/vim-railscasts-theme'
	Plug 'w0ng/vim-hybrid'
call plug#end()
"设置主题
colorscheme hybrid

"为cpp设置初始代码
map <F9> ms:call XYY()<cr>'s 
autocmd BufNewFile *.cpp exec ":call XYY()"
function XYY()
call append(0,"#include <iostream>")
call append(1,"using namespace std;") 
call append(2,"int main(){")
call append(3,"    ")
call append(4,"    return 0;")
call append(5,"}")
endfunction

"coc
"自动安装coc插件
let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-diagnostic',
	\ 'coc-docker',
	\ 'coc-eslint',
	\ 'coc-explorer',
	\ 'coc-flutter-tools',
	\ 'coc-gitignore',
	\ 'coc-html',
	\ 'coc-import-cost',
	\ 'coc-java',
	\ 'coc-jest',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-omnisharp',
	\ 'coc-prettier',
	\ 'coc-prisma',
	\ 'coc-pyright',
	\ 'coc-snippets',
	\ 'coc-sourcekit',
	\ 'coc-stylelint',
	\ 'coc-syntax',
	\ 'coc-tailwindcss',
	\ 'coc-tasks',
	\ 'coc-translator',
	\ 'coc-tsserver',
	\ 'coc-vetur',
	\ 'coc-vimlsp',
	\ 'coc-yaml',
	\ 'coc-yank']

" Set internal encoding of vim, not needed on neovim, since coc.nvim using
" some
" " unicode characters in the file autoload/float.vim
" set encoding=utf-8
"
"不保存跳转
 set hidden
"关闭备份
" set nobackup
" set nowritebackup
"我也不知道是啥 反正没用
" set cmdheight=2
"使vim响应更快
set updatetime=100
"补全的时候信息栏少打一些没用的
set shortmess+=c
"把行号合成一个数列
" if has("nvim-0.5.0") || has("patch-8.1.1564")
"     set signcolumn=number
" else
"     set signcolumn=yes
" endif

"TAB自动补全
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"按<c-space>调出自动补全
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion
" item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() \:"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"使用空格+ +/- 来上下查找代码报错  非常好用
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)

"让vim来查看当前函数在那里定义/调用
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"使用K来查看文档
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if(index(['vim','help'],&filetype)>= 0)
        execute'h'.expand('<cword>')
	elseif(coc#rpc#ready())
    	call CocActionAsync('doHover')
    else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

"高亮同一词
autocmd CursorHold * silent call CocActionAsync('highlight')

"用<leader> rn 将变量重命名
nmap <leader>rn <Plug>(coc-rename)

"代码调整格式
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

"右键代码对代码进行自动更改
function! s:cocActionsOpenFromSelected(type) abort
	execute 'CocCommand actions.open ' . a:type
endfunction
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

