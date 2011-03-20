This tiny script provides the syntax, folding function and other minor
functionality that I need for my notes.

I try to keep al my notes in simple plain ASCII text files. However I admit
that some formating and folding is nice. Hence I came up with a very simple
syntax based on some markers and indentation rules, wrap all that together into
this Vim script and Voilà! Now I can keep my text notes within a compressed
style and smart folding along the power of Vim to ease the access to my notes.

![screen shot](https://github.com/FGarcia/pnote/raw/master/screenshot.png)

I am too lazy to write the documentation, but the syntax is so simple that you
can get an idea by playing with the [sample
file](https://github.com/FGarcia/pnote/blob/master/git-pnote-example.txt). You
just need to move around with the basic folding commands (zo, zc, zM)


Install
-------
The easiest way is just to get the Vimball file from the
[webpage](http://www.vim.org/scripts/script.php?script_id=3098) and follow the
instructions.


Bugs
---------

During the development of this script I might have overlooked some environment
issues. For example, most of the time I use the GUI version of Vim with the
'dark-blue' color schema (:colorscheme darkblue). I would not be surprised if
things look ugly with light backgrounds and/or the command line.


License
---------
Copyright © 2011 Francisco García Rodríguez. 

GNU General Public License - Version 3
See `License.txt` in this directory
