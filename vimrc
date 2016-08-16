" Enable syntax highlighting by default
syntax enable

" Display line numbers
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE<Paste>

" Plugin management
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'junegunn/goyo.vim'
Plug 'keith/swift.vim'
Plug 'plasticboy/vim-markdown'
Plug 'rakr/vim-one'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'vim-ruby/vim-ruby'

call plug#end()

" No folding by default for VIM Markdown
let g:vim_markdown_folding_disabled = 1

set background=dark " for the dark version
" set background=light " for the light version

" http://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
autocmd Filetype ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

