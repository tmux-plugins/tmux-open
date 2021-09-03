# Tmux open

Plugin for opening highlighted selection directly from Tmux copy mode.

Tested and working on Linux, OSX and Cygwin.

### Key bindings

In tmux copy mode:

- `o` - "open" a highlighted selection with the system default program. `open`
    for OS X or `xdg-open` for Linux.
- `Ctrl-o` - open a highlighted selection with the `$EDITOR`
- `Shift-s` - search the highlighted selection directly inside a search engine (defaults to google).

### Examples

In copy mode:

- highlight `file.pdf` and press `o` - file will open in the default PDF viewer.
- highlight `file.doc` and press `o` - file will open in system default `.doc`
  file viewer.
- highlight `http://example.com` and press `o` - link will be opened in the
  default browser.
- highlight `file.txt` and press `Ctrl-o` - file will open in `$EDITOR`.
- highlight `TypeError: 'undefined' is not a function` and press `Shift-s` - the text snipped will be searched directly inside google by default

### Screencast

[![screencast screenshot](/video/screencast_img.png)](http://vimeo.com/102455265)

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'tmux-plugins/tmux-open'

Hit `prefix + I` to fetch the plugin and source it. You should now be able to
use the plugin.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/tmux-plugins/tmux-open ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/open.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

You should now be able to use the plugin.

### Configuration

> How can I change the default "o" key binding to something else? For example,
> key "x"?

Put `set -g @open 'x'` in `tmux.conf`.

> How can I change the default "Ctrl-o" key binding to "Ctrl-x"?

Put `set -g @open-editor 'C-x'` in `tmux.conf`.

> How can I change the default search engine to "duckduckgo" or any other one?

Put `set -g @open-S 'https://www.duckduckgo.com/?q='` in `tmux.conf`

> How can I use multiple search engines?

Put:

```
set -g @open-B 'https://www.bing.com/search?q='
set -g @open-S 'https://www.google.com/search?q='
```

in `tmux.conf`

### Other goodies

`tmux-open` works great with:

- [tmux-copycat](https://github.com/tmux-plugins/tmux-copycat) - a plugin for
  regex searches in tmux and fast match selection
- [tmux-yank](https://github.com/tmux-plugins/tmux-yank) - enables copying
  highlighted text to system clipboard

### License

[MIT](LICENSE.md)
