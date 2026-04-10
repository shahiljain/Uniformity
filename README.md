## Uniformity

This is a mix of my favourite themes with a bit of my custom work  (Colloid Style Apps + Papirus Style Symbolic Icons + Custom Folders based on Zorin). I am chaning app icons and adding new ones as I go on using linux. This is mostly a personal project but you may add pull requests and I shall review them as and when I can.

![preview](quicklook.png?raw=true)

## Install tips

Usage:  `./install.sh`  **[OPTIONS...]**

```
-d, --dest DIR          Specify destination directory (Default: $HOME/.local/share/icons)
-n, --name NAME         Specify theme name (Default: Uniformity)
-t, --theme VARIANTS    Specify folder color variant(s) [default|purple|pink|red|orange|yellow|green|teal|grey|all] (Default: blue)
-s, --scheme VARIANTS   Specify folder colorscheme variant(s) [default|catppuccin|all]
-h, --help              Show help
```

For example: install blue catppuccin version -> run: `./install.sh -s catppuccin -t blue`

For more information, run: `./install.sh -h`

## Disclaimers

This is a relatively new project and there may be some bugs.

1. Currently for schemes only Catppuccin with Blue Color is available.

2. The command `./install.sh -t all` may have some errors in terms of linking please specify each colour theme separately.

## Credits

Handbrake Icon derived from icon by emilrueegg on [macosicons.com](macosicons.com)

Folder Icons derived from [icons.download](icons.download)
