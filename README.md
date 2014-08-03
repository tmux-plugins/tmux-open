# Tmux open

Plugin for opening highlighted selection directly from Tmux copy mode.

### Key bindings

In tmux copy mode:

- `o` - "open" a highlighted selection with the system default program. `open`
    for OS X or `xdg-open` for Linux.
- `Ctrl-o` - open a highlighted selection with the `$EDITOR`

### Examples

In copy mode:

- highlight `file.pdf` and press `o` - file will open in the default PDF viewer.
- highlight `file.doc` and press `o` - file will open in system default `.doc`
  file viewer.
- highlight `http://example.com` and press `o` - link will be opened in the
  default browser.
- highlight `file.txt` and press `Ctrl-o` - file will open in `$EDITOR`.

### Screencast

[![screencast screenshot](/video/screencast_img.png)](http://vimeo.com/102455265)

### Other goodies

`tmux-open` works great with:

- [tmux-copycat](https://github.com/tmux-plugins/tmux-copycat) - a plugin for
  regex searches in tmux and fast match selection
- [tmux-yank](https://github.com/tmux-plugins/tmux-yank) - enables copying
  highlighted text to system clipboard

### License

[MIT](LICENSE.md)
