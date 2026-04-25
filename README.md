## Uniformity

This is a mix of my favourite themes with a bit of my custom work  
1. [Colloid](https://github.com/vinceliuice/Colloid-icon-theme) Style Apps 
2. [Papirus}(https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) Style Symbolic Icons
3. Custom Folders based on [Zorin](https://github.com/ZorinOS/zorin-icon-themes) 

A majority of this theme exists because of the hard work of the devs and contributors on the above mentioned repos, I have combined what I like about each and will work on refining what I have created in my way. If you have any icon requests you can create a pr or start a discussion for the same.

![preview](quicklook.svg?raw=true)

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

## Creating New Icons
You can use the `templates` folder provided in the repo to create new app and mimetype icons.

## Disclaimers

This is a relatively new project and there may be some bugs.

1. Currently for schemes only Catppuccin with Blue Color is available.

2. The command `./install.sh -t all` may have some errors in terms of linking please specify each colour theme separately.

## Credits

Handbrake Icon derived from icon by emilrueegg on [macosicons.com](macosicons.com)

Folder Icons derived from [icons.download](icons.download)
