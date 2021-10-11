Ranger tips:
 1. Type `S` while in a particular directory in ranger to `cd` into that directory
 2. `zh` for toggling hidden files
 3. `cw` to rename file under cursor
 4. `dD<Enter>` to delete file under cursor
 5.  For more, visit [here](https://wiki.josephhyatt.com/ranger/ranger-cheat-sheet)

Donot step on your own foot techniques:
	1. Install packages wisely. All package binaries installed by `pacman` go into `/usr/bin`.
		 All packages installed by other means should(must?) go into `/usr/local/bin`. 
		 Otherwise, a package installed in `usr/bin` by sources other than `pacman` would give 
		 trouble when you sync/upgrade packages with pacman later on.

