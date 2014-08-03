# Screencast script

1. Intro
========
Let's demo tmux-open plugin.

Tmux open defines 2 copy mode key bindings: o and control-o.
- o is a mnemonic for 'open' and it can open various files, directories and
  urls.
- control-o opens files with the default text editor.

2. o - features
===============
Let's first show the 'o' key functionality.

I'm in a git project so I can invoke 'git status'.

I want to open that example directory. I'll quickly highlight it using
tmux copycat.
Now I can press 'o' for opening.

You can see the directory is opened in the OS X Finder app - the default file
manager.


I'm also curious about that 'tmux.pdf' file too.
Again, I'll highlight it.
And then press 'o'.

Oh cool, it's a book about tmux.


Nice thing with 'o' key binding is that it works for url's too.
I'll start a local web-server that serves current project README file.
I'll highlight the url,
- press 'o'
- and the url is opened in the default web browser.

3. ctrl-o - features
====================
Control-o has a more narrow scope: it can open any file in the default text
editor.

I'll invoke git status again.
There I have a text file I want to open. I'll highlight it,
and press ctrl-o.

As you can see, the file is opened in vim, which is my default text editor.

4. Outro
========
That's it for this screencast. I hope you'll find tmux-open plugin useful.
