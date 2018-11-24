# vim-rbrun

A simple plugin to make run Ruby code on Vim. Inspired by [vim-ruby-run](https://github.com/stjernstrom/vim-ruby-run).

## Features

- Run only ruby code. So, the default keymap is freely available to another use by another buffers with another filetypes
- This plugin run script in four different ways:
  - Run **full ruby script** of the current file
  - Run **just the one line under the cursor**
  - Run **piece of a selected code block**
  - **Paste the output** on current file:
    - Just one line under the cursor
    - Or piece of a selected code block
  - Integration with [vimux](https://github.com/benmills/vimux)
    - This feature requires to install [vimux](https://github.com/benmills/vimux)


> Work in progress (see [TODO](#TODO)).

## Instalation

Use your favorite plugin manager, or try [dein.vim](https://github.com/Shougo/dein.vim).

### With dein.vim

Install [dein.vim](https://github.com/Shougo/dein.vim), and add the following line to your `~/.vimrc`:

    call dein#add('sinetoami/vim-rbrun')

And then execute the following command on to your Vim:

    :call dein#install()

### Manually

If you are not using a package manager, download manually the [zip](https://github.com/sinetoami/vim-rbrun/archive/master.zip) repo and extract the files to `~/.vim`:

    $ cp vim-rbrun-master.zip ~/.vim
    $ cd ~/.vim
    $ unzip vim-rbrun-master.zip -d /destination/plugins/folder
    $ rm vim-rbrun-master.zip


## Documentation

This section will contain a brief documentation.

### Configuration

#### g:rbrun_enable_mappings

`let g:rbrun_enable_mappings = 0`

When this variable is set with `0`, disable default mappings (enabled by default with: `1`).

#### g:rbrun_maps

`let g:rbrun_maps = { 'RunScript': '<A-e>' }`

This variable receive a dictionary in a form of `{'rbrun-command-aliases': 'map'}`.
- _rbrun-command-aliases_ will receive one of a _rbrun_ default command aliases
- _map_ will receive a map that you want

By default, _vim-rbrun_ define the following command aliases with one respective default map:

```vim
let g:rbrun_maps = {
  \'RunScript': '<A-e>',
  \'RunLine': '<C-x>',
  \'RunCodeBlock': '<C-x>',
  \'PasteOutputLine': '<C-A-x>',
  \'PasteOutputBlock': '<C-A-x>'
}
```

If you want to change one of these maps, do something such the following line:

  `let g:rbrun_maps = { 'PasteOutputLine': '<leader>rbl' }`

Set this will just change the map that corresponds with `PasteOutputLine` aliases. This will paste the output of the line under the cursor using `<leader>rbl` shortcut.

#### Default Commands

- `<Plug>RbRunScript` will run the current file
- `<Plug>RbRunLine` will run the line under the cursor
- `<Plug>RbRunPasteOutputLine` will paste output of the line under the cursor
- `<Plug>RbRunCodeBlock` will run a piece of selected code block
- `<Plug>RbRunPasteOutputBlock` will paste output of the selected code block

## TODO

- Do paste output of all current script

## Self-Promotion

Do you like this plugin? Come on:
- Star and follow the repository on [GitHub](https://github.com/sinetoami/vim-rbrun).
- Follow me on
  - [GitHub](https://github.com/sinetoami)

## License
[MIT License](LICENSE)
