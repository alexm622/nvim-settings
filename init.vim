set clipboard+=unnamedplus

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'


let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

"dracula
Plug 'dracula/vim', { 'as': 'dracula' }

" nerdtree stuff
Plug 'preservim/nerdtree'

" nerdtree addons

"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'Xuyuanp/nerdtree-git-plugin'

" wakatime integration
"Plug 'wakatime/vim-wakatime'

" icons
Plug 'ryanoasis/vim-devicons'

" web icons
"Plug 'kyazdani42/nvim-web-devicons'

"code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'

" cool line at the bottom
Plug 'itchyny/lightline.vim'

" fuzzyfind
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" discord presence
Plug 'andweeb/presence.nvim'

" formatting
" TODO needs some more customization
" Plug 'mhartington/formatter.nvim'
" Plug 'sbdchd/neoformat'

" auto add closing parentheses,quotes,brackets, etc.
Plug 'Raimondi/delimitMate'

" make missing dirs when using :e
Plug 'pbrisbin/vim-mkdir'

" markdown editor & viewer
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" html live redering
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}

" r support
Plug  'jalvesaq/Nvim-R'

" easier window swapping
Plug 'wesQ3/vim-windowswap'

" debugger
Plug 'puremourning/vimspector'

" startup view
Plug 'mhinz/vim-startify'

" keep layout open
Plug 'famiu/bufdelete.nvim'


" Cheatsheet for vim
Plug 'sudormrfbin/cheatsheet.nvim'

" basic requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Initialize plugin system
call plug#end()


" enable colors & theme
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
      \ 'coc-eslint',
      \ 'coc-pyright',
      \ 'coc-rust-analyzer',
      \ 'coc-java',
      \ 'coc-java-vimspector',
      \ 'coc-r-lsp',
      \ 'coc-sh',
      \ 'coc-fsharp']
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
nmap <leader>f  <Plug>(coc-format-selected)

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
set guifont=DroidSansMono\ Nerd\ Font

set mouse+=a

" auto start commands

autocmd VimEnter * Startify

autocmd VimEnter * NERDTree

let NERDTreeShowHidden=1

" coc tab for autocomplete
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

" markdown settings
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 1


" vimspector

let g:vimspector_enable_mappings = 'HUMAN'

" telescope hotkeys
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
