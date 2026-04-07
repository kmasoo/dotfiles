" ============================================================
" 1. 基本設定
" ============================================================
set encoding=utf-8
scriptencoding utf-8
set number              " 行番号を表示
set relativenumber      " 相対行番号を表示
set termguicolors       " 24bitカラー有効 [cite: 5]
set mouse=a             " マウス操作有効
set signcolumn=yes      " 画面のガタつき防止
set laststatus=2        " ステータスラインを常に表示
" set cursorline          " 現在行を強調
set showmatch           " 対応する括弧を表示
set title               " タイトルをファイル名に [cite: 6]

" ============================================================
" 2. インデント設定
" ============================================================
set expandtab           " タブをスペースに変換
set tabstop=4           " タブ幅を4に設定
set shiftwidth=4        " 自動インデント時の幅を4に設定
set softtabstop=4       " タブキー入力時の幅を4に設定
set autoindent          " 改行時に前の行のインデントを継続
set smartindent         " コードに合わせて賢くインデント

filetype plugin indent on
augroup filetype_indent
    autocmd!
    autocmd FileType ruby,eruby,html,css setlocal sw=2 ts=2 sts=2 [cite: 7]
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
" 4. プラグイン管理
" ============================================================
call plug#begin('~/.vim/plugged')

" カラースキーム
Plug 'morhetz/gruvbox'

" 外観・操作
Plug 'itchyny/lightline.vim'
Plug 'lambdalisue/fern.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tyru/eskk.vim'

" ファジーファインダー
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" 言語サポート・整形
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'rust-lang/rust.vim'

call plug#end()

" ============================================================
" 5. 配色設定 (Gruvbox)
" ============================================================
" ★重要: colorscheme適用前にオプションを設定します
set background=dark

" コントラストの設定 ('soft', 'medium', 'hard')
" 黒背景を際立たせるために 'hard' を使用 
let g:gruvbox_contrast_dark = 'hard'

" オプション設定の後にカラースキームを適用
" autocmd vimenter * colorscheme gruvbox
colorscheme gruvbox

" lightline（ステータスバー）のテーマ設定
let g:lightline = { 'colorscheme': 'gruvbox' }

" ============================================================
" 6. 自動整形・Lint設定 (ALE)
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
" 7. Diff / 便利設定
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