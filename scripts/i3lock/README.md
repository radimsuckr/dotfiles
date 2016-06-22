# i3lock

Originally created by [meskarune](https://github.com/meskarune).

Script that takes a screenshot of the desktop, blurs the background and adds a lock icon and text.

## Dependencies:
- [i3lock-color-git](https://github.com/eBrnd/i3lock-color)
- imagemagick
- maim
- Roboto Fonts

You can use this with `xautolock` to automatically lock the screen after some time.

Systemd Unit file (edit for your own use):

	[Unit]
	Description=Lock the screen automatically after a timeout

	[Service]
	Type=simple
	User=meskarune
	Environment=DISPLAY=:0
	ExecStart=/usr/bin/xautolock -time 5 -locker /usr/local/bin/lock/lock -detectsleep

	[Install]
	WantedBy=graphical.target
