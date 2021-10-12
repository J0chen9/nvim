" __  ___   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" ===
" === Auto load for first time uses
" ===
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if empty(glob($HOME.'/.config/nvim/plugged/wildfire.vim/autoload/wildfire.vim'))
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source $HOME/.config/nvim/_machine_specific.vim

" ==============================================================================
" === Normal System  资料：http://www.ruanyifeng.com/blog/2018/09/vimrc.html
" === 在 Vim 中输入“:set all”指令来查询所有可配置项
" ============================================================================== 
set number	" 设置行号
syntax on	" 语法高亮
"set clipboard=unnamed   " 鼠标复制到无名寄存器
" tab默认显示宽度是8个空格，太丑了，要改一下
set autoindent " 自动缩进
set noexpandtab " 编辑输入Tab字符时,自动替换成空格
set shiftwidth=4  " 自动缩进时,缩进长度为4
set tabstop=4 " tab的长度，4个空格表示1个tab
set softtabstop=-1	" 按tab键输入的空格数量，softtabstop的值为负数,会使用shiftwidth的值,两者保持一致,方便统一缩进
set showmatch " 显示当前列匹配括号
set relativenumber " 相对行号
" 让空格和tab可见
"set list
"set listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:←

set pastetoggle=<F6> " F6使用 :set paste和 :set nopaste切换
set hlsearch	" 高亮搜索
set incsearch "auto match targets
set showcmd " 命令模式下显示键入的指令
set wildmenu " 命令行模式显示补全窗口,使用<Tab>和<S-Tab>来回移动进行补全
" set wildmode=list:longest,full "将 显示可能匹配的文件列表，并使用最长的子串进行补全
set foldmethod=indent	" 设置折叠方式
set foldlevel=99	" 折叠等级
set cursorline  "高亮当前行"
set encoding=utf-8
set ignorecase " 忽略大小写	
set smartcase	  " 只能过滤大小写
set wrap  " 自动换行
set linebreak " 只有遇到指定的符号（比如空格、连词号和其他标点符号），才发生折行

set cursorline  " 当前行高亮

set scrolloff=3 " 让屏幕总数能看到上下3行的内容（让编辑行自动位于屏幕中间）
set ttyfast " 快速鼠标滚动
set lazyredraw " to avoid scrolling problems

set mouse=nv
" 解决tmux渲染冲突问题
set t_Co=256 			" terminal Color 指终端支持的颜色数量
" set term=xterm-256color 	"告诉Vim使用哪种终端类型 它控制Vim各个方面的显示/渲染

" 打开文件跳转到上次编辑的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  
set helplang=cn " 设置中文帮助

"set virtualedit=block
" 设置备份文件、交换文件、操作历史文件的保存位置
silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/undo
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.
" 持久性撤销
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.config/nvim/tmp/undo,.
endif
" ==============================================================================
" === Basic Mappings 方便的键位映射（个人喜好）
" ==============================================================================
" 映射leader键位为空格
let mapleader=' '	
let g:mapleader=' '

" Save & quit
noremap Q :q<CR>
" noremap <C-q> :qa<CR>
noremap S :w<CR>

" 在insert模式使用jj进入normal模式
inoremap jj <Esc>

" 输入模式下移动
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" 快速移动
noremap J 5j
noremap K 5k

  
" w!! 用sudo权限保存文件
"cmap w!! %!sudo tee > /dev/null %
  
" Opening a terminal window
noremap <F5> :set splitbelow<CR>:split<CR>:res -12<CR>:term<CR>
" c-\ c-n进入正常模式
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
" ==============================================================================
" === Install Plugins with Vim-Plug
" ==============================================================================
call plug#begin('$HOME/.config/nvim/plugged')
" 安装插件只需要把github后缀地址放这里,重启后在vim命令行模式执行: PlugInstall 就ojbk了
Plug 'mhinz/vim-startify'

" statusline
"Plug 'liuchengxu/eleline.vim'
"Plug 'theniceboy/eleline.vim'
"Plug 'ojroques/vim-scrollstatus'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"display
Plug 'ryanoasis/vim-devicons'
Plug 'luochen1990/rainbow'

" buffe line
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'romgrk/barbar.nvim'

Plug 'yggdroot/indentline'

" colorscheme
Plug 'w0ng/vim-hybrid'  " 不支持真色彩 
Plug 'liuchengxu/space-vim-dark'
Plug 'romgrk/doom-one.vim'

" fzf.vim 文件搜索工具，需要下载命令行搜索工具fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" 批量替换插件
Plug 'brooth/far.vim'
Plug 'easymotion/vim-easymotion'

" 修改成对内容
Plug 'machakann/vim-sandwich'
" 远程遥控 c/d/y i/a(text-obj)
Plug 'wellle/targets.vim'
" 多光标
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" 高亮当前单词 可以给当前光标下的单词增加下划线  
Plug 'itchyny/vim-cursorword'
" 可以使用不同颜色同时高亮多个单词 leader>k 可以高亮当前单词，K取消
Plug 'lfv89/vim-interestingwords'
" 回车键在 Visual mode实现jebarin的<c-w>
Plug 'gcmt/wildfire.vim'

" 补全插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" go
Plug 'fatih/vim-go'
  
" git
" 在侧边栏显示本文件与当前git结点的不同之处
Plug 'airblade/vim-gitgutter'
  
" 注释
Plug '/tyru/caw.vim'

" 浮动窗口  
Plug 'voldikss/vim-floaterm' 

"  代码标签
Plug 'liuchengxu/vista.vim'

Plug 'theniceboy/vim-snippets'
call plug#end()
  
  
" ==============================================================================
" === vim主题
" ==============================================================================
" 背景主题(用插件下载的主题需要在这里配置使用，否则会报错)
set background=dark
"let g:space_vim_dark_background = 234" 背景色深

"colorscheme space-vim-dark
"hi Comment cterm=italic "支持斜体
"hi Comment guifg=#5C6370 ctermfg=59 " 灰色注释

"colorscheme hybrid

colorschem doom-one
let g:doom_one_terminal_colors = v:true

" 真色彩
set termguicolors
" 透明背景
"hi Normal     ctermbg=NONE guibg=NONE
"hi LineNr     ctermbg=NONE guibg=NONE
"hi SignColumn ctermbg=NONE guibg=NONE

" ================================= Plug Config=================================
" ==============================================================================
" === vim-sandwich
" ==============================================================================
runtime macros/sandwich/keymap/surround.vim  " use vim surround keymappings (ys/ds/cs)
" ==============================================================================
" === indentline
" ==============================================================================
let g:indentLine_enabled = 1
let g:indentLine_char='┆'
" 在以下文件不起作用
let g:indentLine_fileTypeExclude = ['defx', 'denite','startify','tagbar','vista_kind','vista','coc-explorer','dashboard','php','go']
let g:indentLine_concealcursor = 'niv'
let g:indentLine_showFirstIndentLevel =1

" ==============================================================================
" === vim-interestingwords
" === 单词高亮
" ==============================================================================
let g:interestingWordsDefaultMappings = 0
nnoremap <silent> ,f :call InterestingWords('n')<cr>
vnoremap <silent> ,f :call InterestingWords('v')<cr>
nnoremap <silent> ,F :call UncolorAllWords()<cr>

nnoremap <silent> n :call WordNavigation(1)<cr>
nnoremap <silent> N :call WordNavigation(0)<cr>

" ==============================================================================
" === vista.vim(在标签里面按p可以预览代码)
" === 更多配置项参考:help vista-options
" ==============================================================================
nnoremap <silent><nowait> <leader>tt :<C-u>Vista!!<cr>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_sidebar_width = 40
let g:vista_disable_statusline = 1
let g:vista_default_executive = 'ctags'
let g:vista_cursor_delay=100
let g:vista_close_on_jump=1
let g:vista_close_on_fzf_select=1
let g:vista_vimwiki_executive = 'markdown'
let g:vista_executive_for = {
  \ 'vimwiki': 'markdown',
  \ 'php': 'coc',
  \ 'yaml': 'coc',
  \ 'typescript': 'coc',
  \ 'go': 'coc',
  \ 'python': 'coc',
  \ }
let g:vista_fzf_preview = ['right:50%']
" / 使用fzf 查找
autocmd FileType vista,vista_kind nnoremap <buffer> <silent> / :<c-u>call vista#finder#fzf#Run()<CR>
" 浮窗颜色
hi VistaFloat ctermbg=237 guibg=#3a3a3a 
" ==============================================================================
" === fzf
" ==============================================================================
nnoremap <silent> <Leader>F :Rg <C-R><C-W><CR>
" 搜索文件
nnoremap <silent> <c-p> :Files<CR>
nnoremap <silent> <c-h> :History<CR>
nnoremap <silent> <c-f> :Lines<CR>

let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))
" 呼出关闭BUFFER的窗口
noremap <leader>d :BD<CR>

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
" ==============================================================================
" === vim-floaterm
" ==============================================================================
let g:floaterm_keymap_kill = '<F4>'
" 推荐这样映射更灵活
nnoremap <silent> <Leader>ot :FloatermToggle<CR>
tnoremap <silent> <Leader>ot <C-\><C-n>:FloatermToggle<CR>
" 打开lazygit
nnoremap <silent> <Leader>og :<C-u>FloatermNew --height=0.85 --width=0.8 lazygit<CR>

" 窗口的设置
let g:floaterm_position = 'center'
let g:floaterm_wintype = 'floating'
" Set floaterm window's background to black
"hi Floaterm guibg=black
" Set floating window border line color to cyan, and background to orange
hi FloatermBorder guibg=none guifg=cyan

" ==============================================================================
" == GitGutter
" ==============================================================================
" 自定义符号
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
autocmd BufWritePost * GitGutter " 保存文件时更新符号
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap <LEADER>gh :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>

" ==============================================================================
" === far.vim
" ==============================================================================
" shortcut for far.vim find
nnoremap <silent> <leader>/ :Farf<cr>
vnoremap <silent> <leader>/ :Farf<cr>

" shortcut for far.vim replace
nnoremap <silent> <leader>r :Farr<cr>
vnoremap <silent> <leader>r :Farr<cr>
"==============================================================================
" === esay-motion
"==============================================================================
" 使用递归映射是因为<Plug>(easymotion-s2)本身也是个映射，如果不用递归就会被覆盖掉
nmap ss <Plug>(easymotion-s2)

" ==============================================================================
" === commentary.vim 代码注释  https://github.com/tyru/caw.vim
" === gci/a/o注释
" ============================================================================== 


" ==============================================================================
" === coc.nvim
" ==============================================================================
let g:coc_status_error_sign = '•'
let g:coc_status_warning_sign = '•'
let g:coc_global_extensions = [
			\ 'coc-marketplace',
			\ 'coc-json',
			\ 'coc-vimlsp',
			\ 'coc-json',
			\ 'coc-protobuf',
			\ 'coc-go',
			\ 'coc-phpls',
			\ 'coc-python',
			\ 'coc-actions',
			\ 'coc-diagnostic',
		    \ 'coc-lists',
     		\ 'coc-git',
    		\ 'coc-emoji',
    		\ 'coc-explorer',
			\ 'coc-translator',
  			\ 'coc-pairs',
  			\ 'coc-syntax',
			\ 'coc-snippets']

"Translator设置 popup
nmap <Leader>ts <Plug>(coc-translator-p)
vmap <Leader>ts <Plug>(coc-translator-pv)

" 代码跳转时,如果没有保存文件，vim进行跳转时不允许的，是把打开一个缓冲区的操作
" 该项就是设置把跳转文件放到缓冲区
set hidden

"拥有更长的更新时间（默认为4000毫秒= 4秒）补全的响应速度
set updatetime=100

" 补全的时候信息栏少打出一些缺少参数和匹配个数等没用的信息
set shortmess+=c

" 让json可以正确显示注释颜色
autocmd FileType json syntax match Comment +\/\/.\+$+

"Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'  
" 使用 <c- > 调出补全
inoremap <silent><expr> <c-space> coc#refresh()
  
"使 <CR> 自动选择第一个完成项并在输入时通知 coc.nvim 进行格式化（即补全括号展开代码片段之类的）
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  
" 使用 ` +` 和 ` =` 前后跳转到错误行  <space>+d显示所有诊断信息
" 使用 `:CocDiagnostics` 获取位置列表中当前缓冲区的所有诊断的错误信息
nmap <silent> <leader>- <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>= <Plug>(coc-diagnostic-next)
  
" 代码跳转，必备 跳转后你可以使用<C-o>跳回来
nmap <silent> <C-b> :call CocAction('jumpDefinition', 'tab drop')<CR>
"nmap <silent> gd <Plug>(coc-definition)		" 跳转到定义
nmap <silent> gy <Plug>(coc-type-definition) " 跳转到类型定义
nmap <silent> gi <Plug>(coc-implementation)  " 跳转到实现
nmap <silent> gr <Plug>(coc-references)		" 跳转到引用

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" 使用 leader h 在预览窗口中看类型，方法文档
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

" F2进行重命名
nmap <F2> <Plug>(coc-rename)
" Formatting selected code.
nmap <Leader>l 	<Plug>(coc-format)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
      
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Text Objects 块映射和可视模式映射
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)        

        
" Remap <C-d> and <C-u> for scroll float windows/popups.
" 重映射<Cd>和<Cu>处理为滚动浮动窗口/弹出窗口
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
          
" 使用leader a 让当前光标所在代码弹出一些选项
" 需要下载coc-actions
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>aw  <Plug>(coc-codeaction-selected)w

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
          
" CoCList的映射，其是coc自带一个列表管理器，可以认为是开个小窗口做搜索，查询等功能的
" Show all diagnostics. 在coclist显示所有诊断
nnoremap <silent><nowait> ,a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> ,l  :<C-u>CocList<cr>          
nnoremap ,c :CocCommand<CR>

" coc-git 状态栏还是用gitgutter的
" navigate chunks of current buffer
"nmap <LEADER>g- <Plug>(coc-git-prevchunk)
"nmap <LEADER>g= <Plug>(coc-git-nextchunk)
" 查看当前行具体更改信息
"nmap <LEADER>gh <Plug>(coc-git-chunkinfo)
" show commit contains current position
" nmap <LEADER>gc <Plug>(coc-git-commit)
" 折叠所有未更改的行
"nnoremap <LEADER>gf :CocCommand git.foldUnchanged<CR>
autocmd User CocGitStatusChange {command}              

" coc-explorer
nnoremap <space>e :CocCommand explorer<CR>
              
" ==============================================================================
" === barbar.nvim   下面这两个nvim的buffer插件都很好
" === https://github.com/romgrk/barbar.nvim
" === https://github.com/akinsho/bufferline.nvim
" ============================================================================== 
"================key mapping==================
" Move to previous/next
nnoremap <silent>    <A--> :BufferPrevious<CR>
nnoremap <silent>    <A-=> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-p> :BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout<CR>
" Close commands
nnoremap <silent> <Space>bw :BufferCloseAllButCurrent<CR>
"                          :BufferCloseAllButPinned<CR>
"                          :BufferCloseBuffersLeft<CR>
"                          :BufferCloseBuffersRight<CR>
" Magic buffer-picking mode
nnoremap <silent> <<Space>bs   :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bb :BufferOrderByBufferNumber<CR>
"nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
"nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
"nnoremap <silent> <Space>bw :BufferOrderByWindowNumber<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used

"==============option=================== 
" NOTE: If barbar's option dict isn't created yet, create it
let bufferline = get(g:, 'bufferline', {})

" New tabs are opened next to the currently selected tab.
" Enable to insert them in buffer number order.
let bufferline.add_in_buffer_number_order = v:false

" Enable/disable animations
let bufferline.animation = v:true

" Enable/disable auto-hiding the tab bar when there is a single buffer
let bufferline.auto_hide = v:false

" Enable/disable current/total tabpages indicator (top right corner)
let bufferline.tabpages = v:true

" Enable/disable close button
let bufferline.closable = v:true

" Enables/disable clickable tabs
"  - left-click: go to buffer
"  - middle-click: delete buffer
let bufferline.clickable = v:true

" Excludes buffers from the tabline
let bufferline.exclude_ft = ['javascript']
let bufferline.exclude_name = ['package.json']

" Enable/disable icons
" if set to 'buffer_number', will show buffer number in the tabline
" if set to 'numbers', will show buffer index in the tabline
" if set to 'both', will show buffer index and icons in the tabline
let bufferline.icons = v:true

" Sets the icon's highlight group.
" If false, will use nvim-web-devicons colors
let bufferline.icon_custom_colors = v:false

" Configure icons on the bufferline.
let bufferline.icon_separator_active = '▎'
let bufferline.icon_separator_inactive = '▎'
let bufferline.icon_close_tab = ''
let bufferline.icon_close_tab_modified = '●'
let bufferline.icon_pinned = '車'

" If true, new buffers will be inserted at the start/end of the list.
" Default is to insert after current buffer.
let bufferline.insert_at_start = v:false
let bufferline.insert_at_end = v:false

" Sets the maximum padding width with which to surround each tab.
let bufferline.maximum_padding = 3

" Sets the maximum buffer name length.
let bufferline.maximum_length = 30

" If set, the letters for each buffer in buffer-pick mode will be
" assigned based on their name. Otherwise or in case all letters are
" already assigned, the behavior is to assign letters in order of
" usability (see order below)
let bufferline.semantic_letters = v:true

" New buffer letters are assigned in this order. This order is
" optimal for the qwerty keyboard layout but might need adjustement
" for other layouts.
let bufferline.letters =
  \ 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP'

" Sets the name of unnamed buffers. By default format is "[Buffer X]"
" where X is the buffer number. But only a static string is accepted here.
let bufferline.no_name_title = v:null

               
" ==============================================================================
" === eleline.vim/ airline
" === https://github.com/liuchengxu/eleline.vim
" ==============================================================================
set laststatus=2
"let g:airline_section_a = ''   " 模式
" 使用coc-git的分支信息 g:coc_git_status including git branch and current project status.
let g:airline_section_b = "%{get(g:,'coc_git_status','')}"   " 分支
"let g:airline_section_c = ''		" 文件
"let g:airline_section_x = ''		" 文件类型
"let g:airline_section_y = ''		" 编码
"let g:airline_section_z = ''		" 文本行信息
let g:airline_section_error = ''
let g:airline_section_warning  = ''

" 美化
let g:airline_powerline_fonts=1
"let g:airline_theme = 'lucius' 
let g:airline_theme = 'tomorrow' 

" vim-go 插件
"==============================================================================
 " disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
          
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1

let g:godef_split=2
