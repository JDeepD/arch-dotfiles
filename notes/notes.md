## Ranger tips:
 1. Type `S` while in a particular directory in ranger to `cd` into that directory
 2. `zh` for toggling hidden files
 3. `cw` to rename file under cursor
 4. `dD<Enter>` to delete file under cursor
 5.  For more, visit [here](https://wiki.josephhyatt.com/ranger/ranger-cheat-sheet)

## Donot step on your own foot techniques:

 1.  Install packages wisely. All package binaries installed by `pacman` go into `/usr/bin`.
		 All packages installed by other means should(must?) go into `/usr/local/bin`. 
		 Otherwise, a package installed in `usr/bin` by sources other than `pacman` would give 
		 trouble when you sync/upgrade packages with pacman later on.

## Display Keystrokes on Screen:

Install [Screenkey](https://gitlab.com/screenkey/screenkey) and [slop](https://github.com/naelstrof/slop). 
Run `slop -n -g '%g'`. A crosshair should appear. Using that crosshair, select the area in which you want 
Screenkey to display the keystrokes. Get the geometry data(eg:`778x81+514+983%`). Now run Screenkey with these
data : `screenkey -p fixed -g <geometry data>`. In my case, its `screenkey -p fixed -g 744x67+623+1010`.

Pro Tip: Use a Keybinding manager like [XBindkeys](https://wiki.archlinux.org/title/Xbindkeys) to bind these commands
to specific keypresses. Gnome comes with an inbuilt Keybinding Shortcut manager(Under Settings>Keyboard>Shortcut). 
*Donot forget to map a kill switch for Screenkey(Otherwise you will have multiple overlaying instances which can be annoying)*

I have mapped `<F10>` to `screenkey -p fixed -g 744x67+623+1010` and `<F9>` to `pkill -f screenkey`.

Want to change fonts? , Run `screenkey --show-settings` and configure the settings accordingly. It has an inbuilt area-selector
but the disadvantage of using it is that if you map this command to a keypress, then you need to select the area every time you 
press that key.

## Use buffers and bookmarks in vim.
Buffers can be created easily by opening a file in vim using telescope/nerdtree or by just `:e file`.
You can list all buffers using `:ls` and to switch to a particular buffer, just `:b<buffer no.>`. Alternatively,
after installing telescope, you can map `:Telescope buffer` to `<leader>fb` to get a quick and interactive access to all the buffers.
Pro tip : Map `C-l` to `:bn`(buffer-next) and `C-h` to `:bp`(buffer-previous) to get super fast buffer toggling.

Bookmarks can be created to mark specific points in a codebase to fast toggle between them. Bookmarks can be made by `m<character>` in normal
mode to bookmark that point with the id as `<character>`. To list all bookmarks, `:marks` can be used. To move to a specific bookmark,
`'<character>`(tick character) can be used.
Also use the plugin [vim-bookmarks](https://github.com/MattesGroeger/vim-bookmarks) for better bookmark switching.
See [usage](https://github.com/MattesGroeger/vim-bookmarks/blob/master/README.md#usage)

## Use surround.vim for super fast editing
Keys:
y(yank); s(surround); i(in); w(word); d(delete); c(change); t(tag); a(around);

##### Examples
Hello --`ysiw"` (yank surround in word with ")---> "Hello"
Hello --`ysiw*` (yank surround in word with *)---> *Hello*
"hello world" --`cs")` change surround " with ) -------> (hello world)
"hello world" --`cs"<q>` change surround " with <q> tag --> <q>hello world</q>
<q>hello world</q> --`cst"` change surround tag --> "hello world"
"hello world" --`ds"` delete surround " ----------> hello world

Multiple words surround(using Visual mode)

Go in visual mode and select the words which you want to surround.
Then use `S<surround character>` to surround the words with that character.

Lorem Ipsum is simply dummy text of the printing 

With cursor on L, `ys2aw"` (yank surround 2 around words with ") => "Lorem Ipsum" is simply dummy text of the printing 
