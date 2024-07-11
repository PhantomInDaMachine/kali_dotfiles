" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')


" Declare the list of plugins." 
" Plug 'catppuccin/nvim', { 'as': 'catppuccin' } "
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-eunuch'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'ryanoasis/vim-devicons'
Plug 'mhartington/oceanic-next'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Plug 'vim-pandoc/vim-pandoc' "
" Plug 'vim-pandoc/vim-pandoc-syntax' 



" List ends here. Plugins become visible to Vim after this call.
call plug#end()

if !has('gui_running')
  set t_Co=256
endif

map <C-n> :NERDTreeToggle<CR>
