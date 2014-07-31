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

### License

[MIT](LICENSE.md)
