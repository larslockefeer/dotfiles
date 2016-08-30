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
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'vim-ruby/vim-ruby'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'

" Color schemes
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'altercation/vim-colors-solarized'

call plug#end()

" No folding by default for VIM Markdown
let g:vim_markdown_folding_disabled = 1

" http://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
autocmd Filetype ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Don't close NERDTree when opening a file
let NERDTreeQuitOnOpen=0

" Highlight trailing whitespace
match ErrorMsg '\s\+$'

" Removes trailing spaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

" Remove trailing whitespace on writing
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Colors
set background=dark
" set background=light " for the light version
colorscheme deep-space
let g:airline_theme='deep_space'

" More natural Split behaviour
" See: https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright
