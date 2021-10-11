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

