#!/usr/bin/env python3

from i3ipc import Connection
from sys import argv, exit

if len(argv) < 2:
    exit()

i3 = Connection()

focused = i3.get_tree().find_focused()

if focused.type != "workspace":
    windows = focused.workspace().leaves()
    windows[-1].command("focus")
    i3.command("split " + ("horizontal" if len(windows) % 2 else "vertical"))

i3.command("exec " + argv[1])
