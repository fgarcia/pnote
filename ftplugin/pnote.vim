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
" History:
"   0.x     Auto-completion Commands
"	    Making "@" part of a word to avoid mixing @tag and tag with "*"
"

if exists ("b:did_ftplugin_pnote")
   finish
endif
let b:did_ftplugin_pnote = 1

" Screen formating
setlocal nowrap
setlocal autoindent
setlocal tw=80
setlocal formatoptions=tcqn
setlocal formatlistpat=^\\s*\\*\\s*
"setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*

" symbols that are part of a word (for searching with '*')
setlocal iskeyword-=@

" Yank and reformat current line
nmap <Leader>y Y:call Pnote_YankCode()<CR>
" Yank and reformat [current] selection
vmap <Leader>y y:call Pnote_YankCode()<CR>

" Auto-completion
setlocal completefunc=Pnote_tagAutoComplete
setlocal omnifunc=Pnote_tagAutoComplete
setlocal completeopt=longest,menuone
inoremap <buffer> @ <C-R>=Pnote_CleverTagMarker()<CR>

" Folding
setlocal foldexpr=Pnote_getFoldLevel(v:lnum)
setlocal fdm=expr
setlocal fdi=";"

