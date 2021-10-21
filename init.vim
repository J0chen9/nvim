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
set clipboard=unnamed   " 鼠标复制到无名寄存器
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

set hlsearch	" 高亮搜索
set incsearch "auto match targets
set showcmd " 命令模式下显示键入的指令
set wildmenu " 命令行模式显示补全窗口,使用<Tab>和<S-Tab>来回移动进行补全
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

set mouse=nv
" 解决tmux渲染冲突问题
set t_Co=256 			" terminal Color 指终端支持的颜色数量
" set term=xterm-256color 	"告诉Vim使用哪种终端类型 它控制Vim各个方面的显示/渲染
set virtualedit=block

" 打开文件跳转到上次编辑的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set helplang=cn " 设置中文帮助

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
set pastetoggle=<F6> " F6使用 :set paste和 :set nopaste切换

" Insert Mode Cursor Movement
inoremap <A-a> <ESC>A
" Disable the default s key
noremap s <nop>

" https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
vnoremap <C-C> y
" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap su :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap se :set splitbelow<CR>:split<CR>
noremap sn :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap si :set splitright<CR>:vsplit<CR>
" Spelling Check with <space>sc
noremap <LEADER>sc :set spell!<CR>

" Save & quit
noremap Q :q<CR>
" noremap <C-q> :qa<CR>
noremap S :w<CR>

" 在insert模式使用jj进入normal模式
inoremap jj <Esc>
inoremap kk <Esc>

" 输入模式下移动
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Move around tabs
noremap <A--> :-tabnext<CR>
noremap <A-=> :+tabnext<CR>
" w!! 用sudo权限保存文件
"cmap w!! %!sudo tee > /dev/null %

" Opening a terminal window
noremap <F5> :set splitbelow<CR>:split<CR>:res -12<CR>:term<CR>
" c-\ c-n进入正常模式
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>
" ==============================================================================
" === Install Plugins with Vim-Plug
" ==============================================================================
call plug#begin('$HOME/.config/nvim/plugged')
Plug 'glepnir/dashboard-nvim'

" statusline
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

"display
Plug 'ryanoasis/vim-devicons'
Plug 'luochen1990/rainbow'

" buffe line
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim'

"=== 缩进线
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
" colorscheme
Plug 'w0ng/vim-hybrid'  " 不支持真色彩 
Plug 'romgrk/doom-one.vim'
Plug 'glepnir/zephyr-nvim'
Plug 'nvim-treesitter/nvim-treesitter'
" fuzzy finder 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'airblade/vim-rooter'

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
Plug 'honza/vim-snippets'
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

" tool
Plug 'hrsh7th/vim-eft'  " f t strong
Plug 'rhysd/accelerated-jk' " faster jk

call plug#end()
  
" ==============================================================================
" === vim主题
" ==============================================================================
" 背景主题(用插件下载的主题需要在这里配置使用，否则会报错)
set background=dark


"colorscheme hybrid

"colorschem doom-one
"let g:doom_one_terminal_colors = v:true
"真色彩
set termguicolors
" 设置批注斜体
highlight Comment gui=italic 
" 设置关键字斜体
hi Identifier cterm=italic gui=italic

" 透明背景
"hi Normal     ctermbg=NONE guibg=NONE
"hi LineNr     ctermbg=NONE guibg=NONE
"hi SignColumn ctermbg=NONE guibg=NONE
colorscheme zephyr

"=== 光标设置
autocmd InsertEnter * set guicursor=a:blinkon1,i:ver35-Cursor
autocmd InsertLeave * set guicursor=i:ver35-Cursor
autocmd VimLeave  * set gcr=n-v-c:ver25-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,a:blinkon1a

"== 缩进线
" 背景色
" 前景色
"== 自动清空命令输出
function! s:empty_message(timer)
  if mode() ==# 'n'
    echon ''
  endif
endfunction

augroup cmd_msg_cls
    autocmd!
    autocmd CmdlineLeave :  call timer_start(10000, funcref('s:empty_message'))
augroup END

" ================================= Plug Config=================================
" ==============================================================================
" === vim-sandwich
" ==============================================================================
let g:textobj_sandwich_no_default_key_mappings = 1 
" ==============================================================================
" === indentline
" ==============================================================================
lua << EOF
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
	'class',
	'function',
	'method',
	'^if',
	'^while',
	'^typedef',
	'^for',
	'^object',
	'^table',
	'block',
	'arguments',
	'typedef',
	'while',
	'^public',
	'return',
	'if_statement',
	'else_clause',
	'jsx_element',
	'jsx_self_closing_element',
	'try_statement',
	'catch_clause',
	'import_statement'
}
vim.g.indent_blankline_char = '│'
vim.g.indent_blankline_filetype_exclude = {'help','startify','defx', 'denite','startify','tagbar','vista_kind','vista','coc-explorer','dashboard'}
EOF

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
let g:vista_default_executive = 'ctags' " brew install universal-ctags 
let g:vista_cursor_delay=100
let g:vista_close_on_jump=1
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
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "[]",
\  }
" ==============================================================================
" === fzf
" ==============================================================================
" Find files using Telescope command-line sugar.
nnoremap <A-f> <cmd>Telescope find_files<cr>
nnoremap <A-F> <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>ft <cmd>Telescope help_tags<cr>
nnoremap <leader>fh <cmd>Telescope oldfiles<cr>

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
nnoremap <silent> <leader>/ :Farf<cr>
vnoremap <silent> <leader>/ :Farf<cr>
"
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
nmap <silent> <C-b> :call CocActionAsync('jumpDefinition')<CR>
nmap <silent> gd :call CocActionAsync('jumpDefinition','tab drop')<CR>
nmap <silent> <A-t> <Plug>(coc-type-definition) " 跳转到类型定义
nmap <silent> <A-i> <Plug>(coc-implementation)  " 跳转到实现
nmap <silent> <A-r> :call CocActionAsync('jumpReferences')<CR>

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
nmap <Leader>l  <Plug>(coc-format)
xmap <leader>f  <Plug>(coc-format-selected)

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

" 使用leader . 让当前光标所在代码弹出一些选项
" 需要下载coc-actions
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>aw  <Plug>(coc-codeaction-selected)w
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>.  :CocAction<CR>

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

nmap <Leader>1 <Plug>(coc-translator-p)
vmap <Leader>1 <Plug>(coc-translator-pv)
nnoremap <leader>2 :noh<cr>
nnoremap <leader>3 :CocCommand<CR>
nnoremap <silent><nowait> <leader>4  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <leader>5  :<C-u>CocList<cr>          
nmap <leader>6 <Plug>(coc-refactor)
" ==============================================================================
" === https://github.com/akinsho/bufferline.nvim
" ============================================================================== 
nnoremap <silent><A-l> :BufferLineCycleNext<CR>
nnoremap <silent><A-h> :BufferLineCyclePrev<CR>
nnoremap  <silent><A-s> :BufferLinePick <CR>
let g:airline#extensions#tabline#enabled = 0
lua << EOF
require('bufferline').setup {
  options = {
    numbers = "ordinal",
    close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = "coc",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
    end,
    offsets = {{filetype = "coc-explorer", text = "File Explorer", text_align =  " left " ,text_align = "left"}},
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "slant",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    sort_by = 'id'      -- add custom logic
  }
}
EOF

"==============================================================================
"=== vim-go 插件
"==============================================================================
 " disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1

let g:godef_split=2

" ==============================================================================
"=== tool
"==============================================================================
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

nmap ; <Plug>(eft-repeat)
xmap ; <Plug>(eft-repeat)

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


let g:dashboard_default_executive ="telescope"
let g:dashboard_custom_header = [
      \'     ⠀⠀⠀⠀⠀⠀⠀⡴⠞⠉⢉⣭⣿⣿⠿⣳⣤⠴⠖⠛⣛⣿⣿⡷⠖⣶⣤⡀⠀⠀⠀  ',
      \'   ⠀⠀⠀⠀⠀⠀⠀⣼⠁⢀⣶⢻⡟⠿⠋⣴⠿⢻⣧⡴⠟⠋⠿⠛⠠⠾⢛⣵⣿⠀⠀⠀⠀  ',
      \'   ⣼⣿⡿⢶⣄⠀⢀⡇⢀⡿⠁⠈⠀⠀⣀⣉⣀⠘⣿⠀⠀⣀⣀⠀⠀⠀⠛⡹⠋⠀⠀⠀⠀  ',
      \'   ⣭⣤⡈⢑⣼⣻⣿⣧⡌⠁⠀⢀⣴⠟⠋⠉⠉⠛⣿⣴⠟⠋⠙⠻⣦⡰⣞⠁⢀⣤⣦⣤⠀  ',
      \'   ⠀⠀⣰⢫⣾⠋⣽⠟⠑⠛⢠⡟⠁⠀⠀⠀⠀⠀⠈⢻⡄⠀⠀⠀⠘⣷⡈⠻⣍⠤⢤⣌⣀  ',
      \'   ⢀⡞⣡⡌⠁⠀⠀⠀⠀⢀⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⢿⡀⠀⠀⠀⠸⣇⠀⢾⣷⢤⣬⣉  ',
      \'   ⡞⣼⣿⣤⣄⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⣿⠀⠸⣿⣇⠈⠻  ',
      \'   ⢰⣿⡿⢹⠃⠀⣠⠤⠶⣼⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⣿⠀⠀⣿⠛⡄⠀  ',
      \'   ⠈⠉⠁⠀⠀⠀⡟⡀⠀⠈⡗⠲⠶⠦⢤⣤⣤⣄⣀⣀⣸⣧⣤⣤⠤⠤⣿⣀⡀⠉⣼⡇⠀  ',
      \'   ⣿⣴⣴⡆⠀⠀⠻⣄⠀⠀⠡⠀⠀⠀⠈⠛⠋⠀⠀⠀⡈⠀⠻⠟⠀⢀⠋⠉⠙⢷⡿⡇⠀  ',
      \'   ⣻⡿⠏⠁⠀⠀⢠⡟⠀⠀⠀⠣⡀⠀⠀⠀⠀⠀⢀⣄⠀⠀⠀⠀⢀⠈⠀⢀⣀⡾⣴⠃⠀  ',
      \'   ⢿⠛⠀⠀⠀⠀⢸⠁⠀⠀⠀⠀⠈⠢⠄⣀⠠⠼⣁⠀⡱⠤⠤⠐⠁⠀⠀⣸⠋⢻⡟⠀⠀  ',
      \'   ⠈⢧⣀⣤⣶⡄⠘⣆⠀⠀⠀⠀⠀⠀⠀⢀⣤⠖⠛⠻⣄⠀⠀⠀⢀⣠⡾⠋⢀⡞⠀⠀⠀  ',
      \'   ⠀⠀⠻⣿⣿⡇⠀⠈⠓⢦⣤⣤⣤⡤⠞⠉⠀⠀⠀⠀⠈⠛⠒⠚⢩⡅⣠⡴⠋⠀⠀⠀⠀  ',
      \'   ⠀⠀⠀⠈⠻⢧⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⣻⠿⠋⠀⠀⠀⠀⠀⠀  ',
      \'   ⠀⠀⠀⠀⠀⠀⠉⠓⠶⣤⣄⣀⡀⠀⠀⠀⠀⠀⢀⣀⣠⡴⠖⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀  ',
      \ ]


lua<< EOF
require('line')
-- 代码高亮
require('treesitter')
EOF


