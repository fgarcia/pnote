" ------------------------------------------------------------------------------
"
" File: Power Note for Vim
"
" Author: Francisco Garcia Rodriguez <public@francisco-garcia.net>
"
" Licence: Copyright (C) 2010 Francisco Garcia Rodriguez
" This program is free software: you can redistribute it and/or
" modify it under the terms of the GNU General Public License.
" See http://www.gnu.org/licenses/gpl.html
" 
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
" 
" Version:
" History:
"   (see plugin/pnote.vim)
"

if exists ("b:did_ftplugin_pnote")
   finish
endif
let b:did_ftplugin_pnote = 1

setlocal foldexpr=Pnote_getFoldLevel(v:lnum)
setlocal fdm=expr
setlocal fdi=";"
setlocal nowrap
setlocal autoindent
setlocal tw=80
setlocal formatoptions=tcqn
setlocal formatlistpat=^\\s*\\*\\s*
"setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*

" Yank and reformat current line
nmap <Leader>y Y:call Pnote_YankCode()<CR>

" Yank and reformat [current] selection
vmap <Leader>y y:call Pnote_YankCode()<CR>

" Auto completion commands
setlocal completefunc=Pnote_tagAutoComplete
setlocal omnifunc=Pnote_tagAutoComplete
setlocal completeopt=longest,menuone
inoremap @ <C-R>=CleverTagMarker()<CR>

