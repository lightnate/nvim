" ===
" === vim setting
" ===
set encoding=utf-8
set number
set relativenumber
set ignorecase
set hidden
set updatetime=150
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shortmess+=c
set autowrite

" ===
" === vim map
" ===

" map leader to space 
let mapleader=" "

" Save & quit
nnoremap Q :q<CR>
nnoremap S :w<CR>

" map Esc
inoremap ;; <Esc>
vnoremap ;; <Esc>

" map copy
nnoremap <leader>qp "+p
nnoremap <leader>qP "+P
nnoremap <leader>qy "+y

" map start & end
nnoremap <C-h> ^
nnoremap <C-l> $
inoremap <C-g> <Esc>I
inoremap <C-l> <Esc>A
vnoremap <C-h> ^
vnoremap <C-l> $

" window size
noremap <up> :resize +5<CR>
noremap <down> :resize -5<CR>
noremap <left> :vertical resize -5<CR>
noremap <right> :vertical resize +5<CR>

" buffer
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>

" ===
" === vim-plug
" ===
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'akinsho/toggleterm.nvim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" commenter
Plug 'tomtom/tcomment_vim'

" vim theme
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'

" vue
Plug 'posva/vim-vue', { 'for': ['vue'] }

Plug 'easymotion/vim-easymotion'

" https://github.com/tpope/vim-surround/wiki/%E4%B8%AD%E6%96%87-wiki
" ysiw" 添加""
" yss' 为整行添加''
" cs'" 修改'' 为 ""
" ds' 删除''
" VS<p class="flex"> 进入可视模式为选择范围上下添加p标签
Plug 'tpope/vim-surround'

call plug#end()

" ===
" === toggleterm
" ===
" 打开默认终端
noremap <leader>` :ToggleTerm direction=float<CR>
" 使用 1<leader>` 打开 1终端
autocmd TermEnter term://*toggleterm#*
	\ tnoremap <silent><leader>` <Cmd>exe v:count1 . "ToggleTerm"<CR>
" 从终端插入模式恢复到普通模式
tnoremap ;; <C-\><C-n>
" 隐藏终端
tnoremap <Esc> <C-\><C-n>:q<CR>

" ===
" === airline
" ===
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '🐼'
let g:airline_detect_modified=1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme = 'codedark'
let g:airline_section_b = "%{get(g:,'coc_git_status')}"

" ===
" === coc-git
" ===
" navigate chunks of current buffer
nmap <leader>gp <Plug>(coc-git-prevchunk)
nmap <leader>gn <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap <leader>gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap <leader>gc <Plug>(coc-git-commit)

" ===
" === FZF
" === Rg: brew install ripgrep
" ===
" fzf file fuzzy search that respects .gitignore
" If in git directory, show only files that are committed, staged, or unstaged
" else use regular :Files
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
" nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Rg<CR>
nnoremap <leader><TAB> :History<CR>
" command! -bang -nargs=? -complete=dir Files
"   \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--hidden=1', '--preview', 'cat {}']}, <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-file .ignore --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" ===
" === coc-explorer
" ===
nnoremap <leader>e :CocCommand explorer<CR>

" ===
" === vim config
" ===
colorscheme codedark

" ===
" === commenter
" ===
let g:tcomment_opleader1 = '<leader>c' " use <leader>cc to toggle comment

" ===
" ===  coc.nvim
" ===

let g:coc_global_extensions = [
	\ 'coc-git',
	\ 'coc-css',
	\ 'coc-go',
	\ 'coc-sql',
	\ 'coc-actions',
	\ 'coc-diagnostic',
	\ 'coc-eslint',
	\ 'coc-explorer',
	\ 'coc-gitignore',
	\ 'coc-html',
	\ 'coc-import-cost',
	\ 'coc-jest',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-prettier',
	\ 'coc-stylelint',
	\ 'coc-syntax',
	\ 'coc-tasks',
	\ 'coc-translator',
	\ 'coc-tsserver',
	\ 'coc-vetur',
	\ 'coc-vimlsp',
	\ 'coc-yaml']

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

" Use ;o to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> ;o coc#refresh()
" else
"   inoremap <silent><expr> ;@ coc#refresh()
" end

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>y <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

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
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" ===
" ===  move code
" ===
noremap <silent> <C-k> :call <SID>moveup_line()<CR>
noremap <silent> <C-j> :call <SID>movedown_line()<CR>
inoremap <silent> <C-k> <ESC>:call <SID>moveup_line()<CR>a
inoremap <silent> <C-j> <ESC>:call <SID>movedown_line()<CR>a
vnoremap <silent> <C-k> :call <SID>moveup_multlines()<CR>gv
vnoremap <silent> <C-j> :call <SID>movedown_multlines()<CR>gv

function! s:moveup_line()
	let cur_pos = getpos('.')	
	
	if cur_pos[1] == 1
		return
	endif
	let tgt_line = cur_pos[1] - 1	
	let tmp = getline(tgt_line)		
	call setline(tgt_line,getline(cur_pos[1]))	
	call setline(cur_pos[1],tmp)	
	let cur_pos[1] -= 1	
	call setpos('.',cur_pos)	
endfunction

function! s:movedown_line()
	let cur_pos = getpos('.')	
	
	if cur_pos[1] == line('$')
		return
	endif
	let tgt_line = cur_pos[1] + 1	
	let tmp = getline(tgt_line)		
	call setline(tgt_line,getline(cur_pos[1]))	
	call setline(cur_pos[1],tmp)	
	let cur_pos[1] += 1	
	call setpos('.',cur_pos)	
endfunction

function! s:moveup_multlines() range
	
	let start_mark = getpos("'<")
	let end_mark = getpos("'>")
	
	if start_mark[1] == 1
		return
	endif
	
	let save_curpos = getpos('.')
	let buffer_lines = getline(start_mark[1],end_mark[1])
	call add(buffer_lines, getline(start_mark[1] - 1))
	call setline(start_mark[1]-1,buffer_lines)
	
	let start_mark[1] -= 1
	let end_mark[1] -= 1
	let save_curpos[1] -= 1
	call setpos("'<",start_mark)
	call setpos("'>",end_mark)
	call setpos('.',save_curpos)
endfunction

function! s:movedown_multlines() range
	
	let start_mark = getpos("'<")
	let end_mark = getpos("'>")
	
	if end_mark[1] == line('$')
		return
	endif
	
	let save_curpos = getpos('.')
	let buffer_lines = [getline(end_mark[1] + 1)]
	call extend(buffer_lines, getline(start_mark[1],end_mark[1]) )
	call setline(start_mark[1],buffer_lines)
	
	let start_mark[1] += 1
	let end_mark[1] += 1
	let save_curpos[1] += 1
		call setpos("'<",start_mark)
	call setpos("'>",end_mark)
	call setpos('.',save_curpos)
endfunction
