" 这是一份适用 MacOS/Ubuntu的配置， 其他环境未测试
set encoding=utf-8

" 判断操作系统
let g:darwin = has('mac')
let g:windows = has('win32') || has('win64')

" 解决maxmempattern的问题
set maxmempattern=20000

"
"==============================================================================
" 处理 Gnome 终端不能使用 alt 快捷键
" 参考：http://landcareweb.com/questions/8623/altjian-kuai-jie-jian-bu-gua-yong-yu-dai-you-vimde-gnomezhong-duan
"==============================================================================
let c='a'
while c <= 'z'
	exec "set <A-".c.">=\e".c
	exec "imap \e".c." <A-".c.">"
	let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50
set backspace=2

"==============================================================================
" vim 内置配置
"==============================================================================

" 设置 vimrc 修改保存后立刻生效，不用在重新打开
" 建议配置完成后将这个关闭，否则配置多了之后会很卡
" autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 关闭兼容模式
set nocompatible

set number " 设置绝对行号
set relativenumber " 设置相对行号
" set cursorcolumn " 突出显示当前列
set showmatch " 显示括号匹配
" 高亮搜索
set hlsearch
" tab 缩进
set tabstop=4 " 设置Tab长度为4空格
set shiftwidth=4 " 设置自动缩进长度为4空格
set autoindent " 继承前一行的缩进方式，适用于多行注释

" 这里设置代码折叠，但是会卡VIM
set foldenable              " 开始折叠
set foldmethod=syntax       " 设置语法折叠
set foldcolumn=0            " 设置折叠区域的宽度
setlocal foldlevel=1        " 设置折叠层数为
set foldlevelstart=99       " 打开文件是默认不折叠代码
set fileencoding=utf-8

" 定义快捷键的前缀，即<Leader>
let mapleader=";"

" 自定义快捷键

" ==== 系统剪切板复制粘贴 ====
" v 模式下复制内容到系统剪切板
vmap <M-c> "+yy
" n 模式下复制一行到系统剪切板
nmap <M-c> "+yy
" n 模式下粘贴系统剪切板的内容
nmap <M-v> "+p

" 修改默认的区域切换如ctrl+w+h 奇幻到左侧， 依次是 左右上下
nmap <M-h> <C-w>h
nmap <M-l> <C-w>l
nmap <M-k> <C-w>k
nmap <M-j> <C-w>j
" 作用和上面一样，只不过是使用的 Leader
nmap <Leader>h <C-w>h
nmap <Leader>l <C-w>l
nmap <Leader>k <C-w>k
nmap <Leader>j <C-w>j

nmap <Leader>nu :set relativenumber<CR>
nmap <Leader>nn :set norelativenumber<CR>

"开启实时搜索
set incsearch
" 搜索时大小写不敏感
set ignorecase
syntax enable
syntax on                    " 开启文件类型侦测
filetype plugin indent on    " 启用自动补全

" 退出插入模式指定类型的文件自动保存
au InsertLeave *.go,*.sh,*.php write


"==============================================================================
" 插件配置
"==============================================================================

" 插件开始的位置
call plug#begin('~/.vim/plugged')

" Vim 中文文档
Plug 'yianwillis/vimcdoc'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" 可以快速对齐的插件
Plug 'junegunn/vim-easy-align'

" 用来提供一个导航目录的侧边栏
Plug 'scrooloose/nerdtree'

" 可以使 nerdtree Tab 标签的名称更友好些
Plug 'jistr/vim-nerdtree-tabs'

" 可以在导航目录中看到 git 版本信息
Plug 'Xuyuanp/nerdtree-git-plugin'

" 查看当前代码文件中的变量和函数列表的插件，
" 可以切换和跳转到代码中对应的变量和函数的位置
" 大纲式导航, Go 需要 https://github.com/jstemmer/gotags 支持
Plug 'majutsushi/tagbar'

" 自动补全括号的插件，包括小括号，中括号，以及花括号
Plug 'jiangmiao/auto-pairs'

" Vim状态栏插件，包括显示行号，列号，文件类型，文件名，以及Git状态
Plug 'vim-airline/vim-airline'

" 有道词典在线翻译
Plug 'ianva/vim-youdao-translater'

" 代码自动完成，安装完插件还需要额外配置才可以使用
"Plug 'Valloric/YouCompleteMe'
"

" 代码自动补全
" coo-go容易让gopls吃大量内存和CPU，机器打爆
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Plug 'govim/govim'

" 可以在文档中显示 git 信息
Plug 'airblade/vim-gitgutter'


" 下面两个插件要配合使用，可以自动生成代码块
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'github/copilot.vim'

" 配色方案
" colorschem
"Plug 'morhetz/gruvbox'
" colorscheme one
"Plug 'rakr/vim-one'
"Plug 'altercation/vim-colors-solarized'
Plug 'fatih/molokai'

" go 主要插件
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" go 中的代码追踪，输入 gd 就可以自动跳转
Plug 'dgryski/vim-godef'

" markdown 插件
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'

" 自动生成注释的插件
Plug 'scrooloose/nerdcommenter'

" 强大的文件搜索插件
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" 格式化代码插件
" 这个插件特定语言需要额外支持， 比如格式化 json， 需要 js-beautify
" 安装可以 yay -S js-beautify(archlinux) 或者 npm install -g js-beautify
" 更多支持参考： https://github.com/Chiel92/vim-autoformat#default-formatprograms
Plug 'Chiel92/vim-autoformat'

" 自动补全
"Plug 'Shougo/deoplete.nvim'
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'
"let g:deoplete#enable_at_startup = 1


" CSV格式化插件
Plug 'chrisbra/csv.vim'

" 搜索用,ag插件，由于和fzf冲突，命令改为Agg
" 修改方法，将.vim/xx/plugin/ag.vim文件里的Ag命令改为Agg
Plug 'rking/ag.vim'

" git
Plug 'tpope/vim-fugitive'

" 插件结束的位置，插件全部放在此行上面
call plug#end()


"==============================================================================
" 主题配色
"==============================================================================

" 开启24bit的颜色，开启这个颜色会更漂亮一些
set termguicolors
" 配色方案, 可以从上面插件安装中的选择一个使用
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai " 主题
set background=dark " 主题背景 dark-深色; light-浅色


"==============================================================================
" vim-go 插件
"==============================================================================
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
"let g:go_gopls_options = ['-remote=unix;/tmp/gopls-daemon-socket']
"let g:go_gopls_options = ['-remote=172.16.2.132:37374']

let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1

let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_def_mapping_enabled = 1
let g:go_code_completion_enabled = 1
let g:go_implements_mode = 'gopls'

" 直接通过 go run 执行当前文件
autocmd FileType go nmap <leader>r :GoRun %<CR>


"==============================================================================
" NERDTree 插件
"==============================================================================

" 打开和关闭NERDTree快捷键
map <F10> :NERDTreeToggle<CR>
nmap <M-m> :NERDTreeFind<CR>

" 显示行号
let NERDTreeShowLineNumbers=1
" 打开文件时是否显示目录
let NERDTreeAutoCenter=0
" 是否显示隐藏文件
let NERDTreeShowHidden=0
" 设置宽度
" let NERDTreeWinSize=31
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 打开 vim 文件及显示书签列表
let NERDTreeShowBookmarks=2

" 在终端启动vim时，共享NERDTree
" let g:nerdtree_tabs_open_on_console_startup=1


"==============================================================================
"  majutsushi/tagbar 插件
"==============================================================================

" majutsushi/tagbar 插件打开关闭快捷键
nmap <F9> :TagbarToggle<CR>

let g:tagbar_type_go = {
			\ 'ctagstype' : 'go',
			\ 'kinds'     : [
			\ 'p:package',
			\ 'i:imports:1',
			\ 'c:constants',
			\ 'v:variables',
			\ 't:types',
			\ 'n:interfaces',
			\ 'w:fields',
			\ 'e:embedded',
			\ 'm:methods',
			\ 'r:constructor',
			\ 'f:functions'
			\ ],
			\ 'sro' : '.',
			\ 'kind2scope' : {
			\ 't' : 'ctype',
			\ 'n' : 'ntype'
			\ },
			\ 'scope2kind' : {
			\ 'ctype' : 't',
			\ 'ntype' : 'n'
			\ },
			\ 'ctagsbin'  : 'gotags',
			\ 'ctagsargs' : '-sort -silent'
			\ }


"==============================================================================
"  nerdtree-git-plugin 插件
"==============================================================================
let g:NERDTreeGitStatusIndicatorMapCustom = {
			\ "Modified"  : "✹",
			\ "Staged"    : "✚",
			\ "Untracked" : "✭",
			\ "Renamed"   : "➜",
			\ "Unmerged"  : "═",
			\ "Deleted"   : "✖",
			\ "Dirty"     : "✗",
			\ "Clean"     : "✔︎",
			\ 'Ignored'   : '☒',
			\ "Unknown"   : "?"
			\ }

let g:NERDTreeGitStatusShowIgnored = 1
nmap <Leader>pwd :NERDTreeCWD<CR>

"==============================================================================
"  Valloric/YouCompleteMe 插件
"==============================================================================

" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['<M-j>', '<DOWN>']
"let g:ycm_key_list_previous_completion = ['<M-k>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<M-j>'

" 关闭了提示再次触发的快捷键
"let g:ycm_key_invoke_completion = '<Leader>,'

"let g:ycm_language_server =
"  \ [
"  \   {
"  \     'name': 'gopls',
"  \     'cmdline': [ 'gopls' , "-rpc.trace" ],
"  \     'filetypes': [ 'go' ],
"  \     "project_root_files": [ "MakeFile" ]
"  \   }
"  \ ]


"==============================================================================
" UltiSnips 插件
"==============================================================================
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"==============================================================================
"  其他插件配置
"==============================================================================

" markdwon 的快捷键
map <silent> <F5> <Plug>MarkdownPreview
map <silent> <F6> <Plug>StopMarkdownPreview

" tab 标签页切换快捷键
:nn <Leader>1 1gt
:nn <Leader>2 2gt
:nn <Leader>3 3gt
:nn <Leader>4 4gt
:nn <Leader>5 5gt
:nn <Leader>6 6gt
:nn <Leader>7 7gt
:nn <Leader>8 8gt
:nn <Leader>9 8gt
:nn <Leader>0 :tablast<CR>

:nn <M-1> 1gt
:nn <M-2> 2gt
:nn <M-3> 3gt
:nn <M-4> 4gt
:nn <M-5> 5gt
:nn <M-6> 6gt
:nn <M-7> 7gt
:nn <M-8> 8gt
:nn <M-9> 9gt
:nn <M-0> :tablast<CR>

" 自动注释的时候添加空格
let g:NERDSpaceDelims=1


"==============================================================================
" 光标随着插入模式改变形状
" 参考： https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
"==============================================================================
if has("autocmd")
	au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
	au InsertEnter,InsertChange *
				\ if v:insertmode == 'i' |
				\   silent execute '!echo -ne "\e[6 q"' | redraw! |
				\ elseif v:insertmode == 'r' |
				\   silent execute '!echo -ne "\e[4 q"' | redraw! |
				\ endif
endif


"==============================================================================
" 自定义的额外配置
"==============================================================================
"
" 自动保存 session
autocmd VimLeave * mks! ~/.vim/session.vim
"autocmd VimEnter *.go GoMetaLinter
" 加载 session 的快捷键
nmap <Leader>his :source ~/.vim/session.vim<CR>

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-e> :Buffers<CR>
nnoremap <silent> <C-S-i> :Autoformat<CR>

" 有道词典插件
map <M-t> :Ydc<CR>

" 自动切换到当前文件所在的目录 cdpath
map <Leader>cd :cd %:h<CR>

" 退出
map <Leader>q :q<CR>
map <Leader>wq :wq<CR>

" 指定CSV文件分隔符
let g:csv_delim=','

" go折叠
let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']

let g:go_metalinter_command = "golangci-lint"
"let g:go_metalinter_autosave = 1
"
"let g:go_gopls_settings = {'build.directoryFilters': ['-common/pb/message_1.pb.go']}
let g:go_build_tags = "stub"
"let g:syntastic_go_go_build_args = '-tags="stub"'
"

" 设置自动保存
set autowrite

" 手动设置gopls目录
"let g:ycm_gopls_binary_path='/home/tangwei/go/bin/gopls'
let g:coc_disable_startup_warning = 1




" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" SymbolionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" SymbolionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" SymbolionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" SymbolionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

