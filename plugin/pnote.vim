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
" Webpage: 
"   https://github.com/fgarcia/pnote/
"   http://www.vim.org/scripts/script.php?script_id=3098
"
" Files:    
"       plugin/pnote.vim
"       syntax/pnote.vim
"       ftplugin/pnote.vim
"
" Version:  0.2 
"
" History:
"   v0.3  xxx TBR
"       - Do not fold last line if contains vim parameters ($vim:...)
"       - Tag omnicomplete
"
"   v0.2  2011-03-20
"       - Syntax for bibliography nodes
"       - Syntax for command line instructions
"       - Easy copy to command line instructions to the system clipboard
"       - Minor bugfixes
"
"   v0.1  2010-05-23
"       - Initial version
" ------------------------------------------------------------------------------

let s:regex_tag = '\s@\w\+'

" Yank lines into the "+" register removing leading "$". Result will be
" displayed within the status line
fu! Pnote_YankCode()
    " Get array of lines
    let codeLines = split (getreg('0'),"\n")
    " Remove empty space [and code mark]
    call map (codeLines, 'substitute(v:val,''^\s\+\$\=\s*'', "", "")')
    " Convert array into one single string
    let output = join(codeLines,"\n")
    " Copy to clipboard and display result
    call setreg ("+", output)
    echo output
endfu


" Column of the first character for sections
" 
" Sections start with a main section marker (#) or with a subsection (;) 
"
" If neither of them is found, it returns the column of the
" first character. Otherwise returns -1
"
" (Taken from AGTD vim script)
function! Pnote_getSectionColumn(lineNum)
    let lineText = getline (a:lineNum)
    let lineCol = match (lineText,'\S')
    if lineCol == -1
        " No fold level for empty line
        return -1
    endif

    let mainSectionLine = match (lineText,'^#')
    if mainSectionLine == 0
        return lineCol
    endif

    let markerPos = match (lineText,'; ')
    if markerPos == lineCol
        " Line starting with a section marker
        return markerPos
    else
        " Other type of lines
        return -1
    endif
endfu


" FoldLevel for PNOTE files
"
" The fold level is based on the column of the first section marker divided
" by the current tab width. Tab markers are identified by the function
" Pnote_getSectionColumn()
"
" If no section marker is found in the current line, it will look for one in
" the previous lines divided. In such cases it will be assumed that the
" current line is one level deeper (+1) within the first previous section
" line.
"
function! Pnote_getFoldLevel(pos)

    " Do not fold last line if contains vim parameters ($vim:...)
    if a:pos == line("$")
        let txt = getline(line("$"))
        if match( txt, "vim:") == 0
            return 0
        endif
    endif

    " Get section marker position
    let sectionColumn = -1
    let lineNum = a:pos + 1
    while sectionColumn == -1 && lineNum != 1
        let lineNum -= 1
        let sectionColumn = Pnote_getSectionColumn(lineNum)
    endwhile

    if sectionColumn == -1
        " No section found
        return 0
    endif

    let level = sectionColumn / &shiftwidth
    if lineNum != a:pos
        " Section had to be searched in previous lines. Therefore Current line
        " is contained within a section: The fold level is +1 greater than its
        " section
        let level += 1
    endif
    return level
endfu


" List of tag words within the current buffer
fu! Pnote_parseTags()
    let tag_list = []
    let starting_position = getpos ('.')

    call cursor(1,1)
    while (1)
        let [lnum, col] = searchpos(s:regex_tag, 'W')
        if (lnum == 0)
            break
        endif
        normal le
        let tag_end_position = col('.')
        let tag_length = tag_end_position - col
        let found_tag = strpart( getline(lnum), col+1, tag_length)
        if index( tag_list, found_tag ) == -1
            call add( tag_list, found_tag )
        endif
    endwhile
    call setpos ('.', starting_position)
    return tag_list
endfu


" Function replacement when pressing the tag marker '@'
fu! CleverTagMarker()
    if strpart( getline('.'), col('.')-2, 1 ) =~ '\w'
        return "@"
    else
        return "@\<C-X>\<C-U>"
    endif
endfu


" Custom auto-complete function for @tags keywords
fu! Pnote_tagAutoComplete(findstart, base)
    if a:findstart
        " locate start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
          let start -= 1
        endwhile
        return start
    else
        let res = []
        for m in Pnote_parseTags()
            if m =~ '^' . a:base
                call add(res,m)
            endif
        endfor
        return res
    endif
endfu

