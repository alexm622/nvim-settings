" pecify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/autoload/plug.vim')


"dracula
Plug 'dracula/vim', { 'as': 'dracula' }

" Make sure you use single quotes

" nerdtree stuff
Plug 'preservim/nerdtree'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'Xuyuanp/nerdtree-git-plugin' 
Plug 'wakatime/vim-wakatime'
Plug 'ryanoasis/vim-devicons'
"Plug 'kyazdani42/nvim-web-devicons'

"code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'

"Tabline
Plug 'itchyny/lightline.vim'

" fuzzyfind
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'andweeb/presence.nvim'

" Initialize plugin system
call plug#end()

if (has("termguicolors"))
 set termguicolors
endif
set background=dark
colorscheme dracula

" ALE (Asynchronous Lint Engine)
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1
" COC
" " COC extension
let g:coc_user_config = {}
let g:coc_global_extensions = [
      \ 'coc-emmet', 
      \ 'coc-css', 
      \ 'coc-html', 
      \ 'coc-json', 
      \ 'coc-prettier', 
      \ 'coc-tsserver', 
      \ 'coc-snippets', 
      \ 'coc-eslint']
" " To go back to previous state use Ctrl+O
nmap <silent><leader>gd <Plug>(coc-definition)
nmap <silent><leader>gy <Plug>(coc-type-definition)
nmap <silent><leader>gi <Plug>(coc-implementation)
nmap <silent><leader>gr <Plug>(coc-references)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
let g:coc_lobal_config="$HOME/.config/coc/coc-settings.json"
" " Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh() 

" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" " position. Coc only does snippet and additional edit on confirm.
" " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" " Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" " Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" " Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected

augroup mygroup
  autocmd!
  " " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" " Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" " Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

set encoding=UTF-8
set guifont=DroidSansMono\ Nerd\ Font\ 11

set mouse+=a

autocmd VimEnter * NERDTree

