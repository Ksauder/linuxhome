" This is a minimal Vim config that's geared to be useful on new machines.
" All new configs will go into Neovim.

set tabstop=4
" length to use when shifting text (eg. <<, >> and == commands)
" (0 for ‘tabstop’):
set shiftwidth=0
" length to use when editing text (eg. TAB and BS keys)
" (0 for ‘tabstop’, -1 for ‘shiftwidth’):
set softtabstop=0
" expand all tabs to spaces
set expandtab
set autoindent
set number
set relativenumber
set fileformat=unix

set pastetoggle=<F3>
set hlsearch
set noerrorbells
set history=1000

" filetype settings
autocmd FileType sh setlocal tabstop=4 shiftwidth=4

" Maps the F5 key to trim all white space
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" maps ctrl-r when in visual mode to replace highlighted text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
   let @/ = ''
   if exists('#auto_highlight')
     au! auto_highlight
     augroup! auto_highlight
     setl updatetime=4000
     echo 'Highlight current word: off'
     return 0
  else
    augroup auto_highlight
    au!
    au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
  return 1
 endif
endfunction

" enable mouse, and remap left click for selecting word for highlighting
set mouse=a
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>
" ----

" Bootstrap vim-plug.
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load plugins
call plug#begin()
" Let Tim Pope set sensible defaults for us.
Plug 'tpope/vim-sensible'

" Optionally manage fzf here. Neovim does the same.
Plug 'junegunn/fzf', { 'tag': '*',  'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git-release plugins.
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" Cosmetic plugins.
Plug 'vim-airline/vim-airline', { 'tag': 'v0.11' }
Plug 'sheerun/vim-polyglot', { 'tag': 'v4.17.0' }
Plug 'ryanoasis/vim-devicons'
call plug#end()

" Load some standard configs.
set number
set ignorecase
set smartcase
set mouse=a
set hlsearch
set background=dark
syntax on
syntax enable

if executable('fzf')
  " Remap ctrl-P to execute fzf.
  nnoremap <silent> <C-p> :Files<CR>
  " Show previews with fzf window.
  command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
endif

if executable('fd')
  " Use fd for fzf searches.
  let $FZF_DEFAULT_COMMAND = 'fd --type f'
endif

" Source custom configs (not under version control).
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
