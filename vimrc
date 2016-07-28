" Enable syntax highlighting by default
syntax enable

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

call plug#end()

" No folding by default for VIM Markdown
let g:vim_markdown_folding_disabled = 1

set background=dark " for the dark version
" set background=light " for the light version
