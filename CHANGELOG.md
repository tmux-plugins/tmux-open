# Changelog

### master
- fix a problem where we try to bind `editor` from `@open-editor`

### v3.0.0, Nov 01, 2017
- enable extensibility via search engines (@vasconcelloslf)
- cygwin support
- add support for tmux 2.4 and above (@docwhat)

### v2.0.0, Nov 01, 2014
- 'open editor' command can now open files that have spaces
- system open command can now open files that have spaces
- change "@open-editor" options to use hyphens (bc tmux core uses those too)

### v1.0.0, Aug 03, 2014
- if $EDITOR env var is not set, provide fallback
- increase `open` command reliability by first `cd`-ing to the current PWD
- add links to related plugins to the readme
- add screencast script to the repo
- add screencast video link to the README
- add installation instructions

### v0.0.2, Aug 02, 2014
- add readme
- refactor `command_generator`
- improve open (`o`) command

### v0.0.1, Aug 01, 2014
- started the project
- first working version
