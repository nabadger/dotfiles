execute pathogen#infect()
syntax on
filetype plugin indent on

map <ESC>[5D <C-Left>
map <ESC>[5C <C-Right>
map! <ESC>[5D <C-Left>
map! <ESC>[5C <C-Right>

autocmd FileType sh setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType bash setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType zsh setlocal ts=2 sts=2 sw=2 expandtab

