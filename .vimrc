" ============================================================
" 1. 基本設定
" ============================================================
set encoding=utf-8
scriptencoding utf-8
set number              " 行番号を表示
set relativenumber      " 相対行番号を表示
set termguicolors       " 24bitカラー有効
set mouse=a             " マウス操作有効
set signcolumn=yes      " 画面のガタつき防止
set laststatus=2        " ステータスラインを常に表示
set cursorline          " 現在行を強調
set showmatch           " 対応する括弧を表示
set title               " タイトルをファイル名に

" ============================================================
" 2. インデント設定
" ============================================================
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

filetype plugin indent on
augroup filetype_indent
    autocmd!
    autocmd FileType ruby,eruby,html,css setlocal sw=2 ts=2 sts=2
    autocmd FileType python,c,cpp,rust,java setlocal sw=4 ts=4 sts=4
augroup END

" ============================================================
" 3. クリップボード連携
" ============================================================
if executable('wl-copy')
    vnoremap <silent> y :w !wl-copy<CR><CR>
    nnoremap <silent> p :r !wl-paste --no-newline<CR>
elseif executable('xclip')
    vnoremap <silent> y :w !xclip -selection clipboard<CR><CR>
    nnoremap <silent> p :r !xclip -selection clipboard -o<CR>
endif

" ============================================================
" 4. プラグイン管理 (エラー箇所を修正)
" ============================================================
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'lambdalisue/fern.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tyru/eskk.vim'

" エラー原因のラムダ式を避け、標準的な文字列形式に修正しました
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'rust-lang/rust.vim'

call plug#end()

" ============================================================
" 5. 自動整形・Lint設定 (ALE)
" ============================================================
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'rust': ['rustfmt'],
\   'python': ['black', 'isort'],
\   'ruby': ['rubocop'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'java': ['google-java-format'],
\}
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:rustfmt_autosave = 1

" ============================================================
" 6. Diff / 便利設定
" ============================================================
if &diff
    set cursorline
    set diffopt+=filler,context:3
endif

let mapleader = "\<Space>"
autocmd BufWritePre * :%s/\s\+$//e
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch<Return>

" Diff操作
nnoremap <Leader>dg :diffget<CR>
nnoremap <Leader>dp :diffput<CR>
nnoremap <Leader>du :diffupdate<CR>

