# Ugbi
Ugbi is a Vim plugin that provides critical unimplemented functionally that some people **(only  me)** say is the best plugin ever developed. While
I was perusing the Vim documentation for autocommands, I discovered `UserGettingBored`. I immediately knew something was wrong because it is
impossible for anyone to get bored while using Vim. After many sleepless nights, I attempted to trigger the event by repeating the same key
42 times. The anticipation grew upon each click `llllllllllllllllllllllllllllllllllllllllll` then, as I originally expected, nothing 
happened. This further solidified that it is indeed impossible for a user to get bored in Vim. 

But wait, there was a second line in the
documentation. It said `Just kidding! :-)`. It was at that moment that I realized someone meant to implement Samuel L. Jackson in the
vimaverse. It has been a grueling 46 years, but the hard work has finally paid off. I'd like to thank my sponsor, that random person on Reddit [r/vim](https://www.reddit.com/r/vim).

<pre>

                        UGBI - UserGettingBored Improved

                              by Mike Smith
                    Ugbi is open source and freely distributable

                             Help poor children in Uganda!
             type  :help <a href="https://vimhelp.org/uganda.txt.html#iccf" >iccf</a><Enter>                     for information

             type  :<a href="https://imgflip.com/i/43nrkh" >q</a><Enter>                             to exit
             type  :help <a href="https://vimhelp.org/autocmd.txt.html#UserGettingBored" >UserGettingBored</a><Enter> or &lt;F1&gt; for on-line help
    
    
    
    
                                                        <a href="https://vimhelp.org/autocmd.txt.html#UserGettingBored" >UserGettingBored</a>
UserGettingBored                When the user presses the same key 42 times.
                                Just kidding! :-)
                                
</pre>
## Demo
![ugbi](static/ugbi.gif)

## Setup
### Installation
Install using your favorite package manager, or use Vim's built-in package support:
```bash
mkdir -p ~/.vim/pack/mkesmithgh/start
cd ~/.vim/pack/mkesmithgh/start
git clone https://github.com/mikesmithgh/ugbi.git
vim -u NONE -c "helptags ugbi/doc" -c q
```
Using [vim-plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'mikesmitgh/ugbi.vim'
```
Using [Vundle](https://github.com/VundleVim/Vundle.vim)
```vim
Plugin 'mikesmitgh/ugbi.vim'
```

For the best experience, use VIM version 9.0 or greater compiled with the [+termguicolors](https://vimhelp.org/various.txt.html#%2Btermguicolors) feature.  
Use a terminal that supports truecolor and enable the `termguicolors` option in your Vim configuration.
```vim
set termguicolors
```

## Usage
Only alphanumeric `[a-zA-Z0-9]` keys in insert mode trigger a count that is used by this plugin. This is done by remapping the keys
in insert mode to trigger the plugin. To trigger the plugin, open a buffer and repeat the same character 42 times in insert mode.

## Commands
| Command        | Action                                                                                           |
| ---            | ---                                                                                              |
| `:UgbiEnable`  | Enable the plugin and setup keymappings to intercept alphanumeric characters in insert mode.     |
| `:UgbiDisable` | Disable the plugin and remove keymappings that intercept alphanumeric characters in insert mode. |

## Customization
```vim
" Enable the plugin
" Enabled by default, set to 0 to disable and 1 to enable
" After setting to disabled, you will need to run the comman UgbiDisable or restart Vim
let g:ugbi_enabled = 1

" Show the current number of repeated characters while typing
" Disabled by default, set to 0 to disable and 1 to enable
let g:ugbi_show_count = 0
```

## Ackowledgements
- [Samuel L. Jackson](https://en.wikipedia.org/wiki/Samuel_L._Jackson) - The inspiration, couldn't have done it without you Sammy!
- [Tim Pope](https://github.com/tpope) - Excellent reference for Vim plug-in development.
- [artem](https://github.com/FineFindus/artem) - Used to generate ASCII art in truecolor.
- [text-image.com](https://www.text-image.com/) - Initially used to render ASCII art but size of art was too large to fit in a normal sized screen.
- [baleia.nvim](https://github.com/m00qek/baleia.nvim) - Plugin worked perfectly for highlighting. However, it is only available on Neovim. I was able to reference `nvim_buf_add_highlight()` to discover similar functionaly in Vim `matchaddpos()` to positionally highlight instead of using a regex.
- [Colorizer](https://github.com/chrisbra/Colorizer) - Initially attempted highlighting with this plugin. Although it worked, there was bad lag due to regex matching. 
- [AutoComplPop](https://github.com/vim-scripts/AutoComplPop) - Plugin referenced for intercepting keystrokes.
