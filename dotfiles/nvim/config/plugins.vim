" -------------------------------------------------------------------------------
" Plugins
" -------------------------------------------------------------------------------

let s:neovim_venv_bin = $NVIM_PY3_VENV_PATH . '/bin'

call plug#begin()



" -------------------------------------------------------------------------------
" Color Scheme
" -------------------------------------------------------------------------------

Plug 'mhartington/oceanic-next'
" Plug 'frankier/neovim-colors-solarized-truecolor-only'  " true-color fork of solarized
" Plug 'trevordmiller/nova-vim'


" -------------------------------------------------------------------------------
" indentline - show indent guides
" -------------------------------------------------------------------------------

" Plug 'Yggdroot/indentLine'


" -------------------------------------------------------------------------------
" vim-unimpaired - handy motions starting with '[' and ']' keys
" -------------------------------------------------------------------------------

Plug 'tpope/vim-unimpaired'


" -------------------------------------------------------------------------------
" vim-commentary - easier commenting
" -------------------------------------------------------------------------------

Plug 'tpope/vim-commentary'


" -------------------------------------------------------------------------------
" vim-surround - easily surround objects with brackets, quotes etc.
" -------------------------------------------------------------------------------

Plug 'tpope/vim-surround'


" -------------------------------------------------------------------------------
" EasyMotion - quickly jump to any location on the screen
" -------------------------------------------------------------------------------

Plug 'easymotion/vim-easymotion'

" Disable default mappings
let g:EasyMotion_do_mapping = 0

" Search like vim's smartcase
let g:EasyMotion_smartcase = 1

" Don't search outside visible screen
let g:EasyMotion_off_screen_search = 0

" 2-char searches across splits
nmap s <Plug>(easymotion-overwin-f2)

nmap s <Plug>(easymotion-s)
nmap w <Plug>(easymotion-w)
nmap b <Plug>(easymotion-b)


" -------------------------------------------------------------------------------
" auto-pairs - Auto-close quotes, brackets while typing
" -------------------------------------------------------------------------------

Plug 'jiangmiao/auto-pairs'


" -------------------------------------------------------------------------------
" Emmet - Shortcuts for xml-based languages, building markup from css-like selectors
" -------------------------------------------------------------------------------

Plug 'mattn/emmet-vim'

" <c-g> as emmet leader key in all modes
let g:user_emmet_leader_key='<c-g>'


" -------------------------------------------------------------------------------
" FZF - Fast searching of files in directory/project/history/etc.
" -------------------------------------------------------------------------------

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

nnoremap <c-p> :Files<cr>
nnoremap <c-o> :GFiles<cr>
nnoremap <c-i> :Buffers<cr>

" Search lines in current buffer
nnoremap <c-t>l :BLines<cr>

" Search all lines in all files
nnoremap <c-t>, :Lines<cr>

" Search repo commits
nnoremap <c-t>h :Commits<cr>

" Search commits for current buffer
nnoremap <c-t>b :BCommits<cr>

" Search normal mode mappings
nnoremap <c-t>m :Maps<cr>

" Search from current dir using `ag` and show results to search in
nnoremap <c-t>/ :execute 'Ag ' . input('Ag/')<cr>


" -------------------------------------------------------------------------------
" Neomake - Async code runner. Primarily for running linters, compilers etc.
" -------------------------------------------------------------------------------

Plug 'neomake/neomake'

" Override default python makers to use only flake8.
" Further, we tell neomake to use the flake8 installed in our dedicated nvim venv. The
" remaining flake8 options are taken as-is from what is specified in the neomake repo.
" (See `plugged/neomake/autoload/neomake/makers/ft/python.vim`)
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_python_flake8_maker = {
  \ 'exe': s:neovim_venv_bin . '/flake8',
  \ 'errorformat':
    \ '%E%f:%l: could not compile,%-Z%p^,' .
    \ '%A%f:%l:%c: %t%n %m,' .
    \ '%A%f:%l: %t%n %m,' .
    \ '%-G%.%#',
  \ 'postprocess': function('neomake#makers#ft#python#Flake8EntryProcess')
\ }

" Run linter on saving/opening file
augroup NeomakeCommands
  autocmd!
  autocmd! BufWritePost,BufRead * Neomake
augroup END


" -------------------------------------------------------------------------------
" Deoplete - Async completion system for neovim
" Ref: https://github.com/Shougo/deoplete.nvim/blob/master/doc%2Fdeoplete.txt
" -------------------------------------------------------------------------------

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

let g:deoplete#enable_at_startup = 1

" Close popup menu when completion is done
augroup DeopleteCommands
  autocmd!
  autocmd CompleteDone * pclose!
augroup END


" -------------------------------------------------------------------------------
" JavaScript syntax - Plugins that provide better syntax and indentation settings for JS
" -------------------------------------------------------------------------------

Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }


" -------------------------------------------------------------------------------
" deoplete-jedi - Jedi wrapper, Python autocompletion and static analysis lib, used with
" deoplete
"
" NOTE: vim startup time seems to be a fraction slower with some of the following plugins.
" Particularly - jedi-vim and tern_for_vim. Probably due to lack of async in these
" heavy plugins.
" -------------------------------------------------------------------------------

Plug 'zchee/deoplete-jedi', { 'for': 'python' }


" -------------------------------------------------------------------------------
" jedi-vim - to be used for python features aside from completion (which is provided by
" deoplete-jedi). Primarily for go-to-definition.
" -------------------------------------------------------------------------------

Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Completions handled by deoplete-jedi
let g:jedi#completions_enabled = 0


" -------------------------------------------------------------------------------
" tern_for_vim - ternjs wrapper, deoplete-ternjs will handle completions, this will
" provide other tern feaures from within vim.
" -------------------------------------------------------------------------------

Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': ['javascript', 'javascript.jsx'] }


" -------------------------------------------------------------------------------
" deoplete-ternjs - ternjs wrapper, JavaScript autocompletion and static analysis lib,
" used with deocomplete
" -------------------------------------------------------------------------------

Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }

" TODO: Can this be a command from some neovim-specific non-global install of tern?
" See deoplete-ternjs source - kind of looks to be configurable.
let g:tern#command = ['tern']

" Disable auto-shutdown of tern server that happens after 5 mins of inactivity
let g:tern#arguments = ['--persistent']

" Shortcuts for tern_for_vim commands
augroup TernCommands
  autocmd!
  autocmd FileType javascript,javascript.jsx nnoremap <leader>d :TernDef<cr>
  autocmd FileType javascript,javascript.jsx nnoremap <leader>D :TernDefTab<cr>
augroup END


" ---------------------------------------------------------------------------
" End Plugins
" ---------------------------------------------------------------------------

call plug#end()
