# -*- coding: utf-8 -*-

import functools
import operator
import re
import string
from xkeysnail.transform import *

# Change modifier keys
define_modmap({
    Key.RIGHT_CTRL: Key.LEFT_META,  # Swap Super and RCtrl
    Key.LEFT_META: Key.RIGHT_CTRL,
    #Key.CAPSLOCK: Key.LEFT_META,
    #Key.RIGHT_META: Key.LEFT_META,
    #Key.LEFT_META: Key.RIGHT_META,  # to disable overview
    #Key.BTN_MIDDLE: Key.LEFT_META,  # middle click to overview
})

# Rofi
define_keymap(None, {
    K("RCtrl-space"): K("Super-space"),
}, "Rofi")

# Keybindings for Chrome
define_keymap(re.compile("Google-chrome"), {
    # Ctrl+Alt+j/k to switch next/previous tab
    K("C-M-j"): K("C-TAB"),
    K("C-M-k"): K("C-Shift-TAB"),
    # Search tabs
    K("Super-Shift-A"): K("C-Shift-A"),
    #K("C-x"): {
    #    K("C-b"): K("C-Shift-A"),
    #},
}, "Chrome")

# Emacs-like keybindings
define_keymap(lambda wm_class: wm_class not in ("Emacs", "Gnome-terminal", "Alacritty", "kitty"), {
    # Cursor
    K("C-b"): with_mark(K("left")),
    K("C-f"): with_mark(K("right")),
    K("C-p"): with_mark(K("up")),
    K("C-n"): with_mark(K("down")),
    K("C-h"): with_mark(K("backspace")),
    # Forward/Backward word
    K("M-b"): with_mark(K("C-left")),
    K("M-f"): with_mark(K("C-right")),
    # Beginning/End of line
    K("C-a"): with_mark(K("home")),
    K("C-e"): with_mark(K("end")),
    # Page up/down
    K("M-v"): with_mark(K("page_up")),
    K("C-v"): with_mark(K("page_down")),
    # Beginning/End of file
    K("M-Shift-comma"): with_mark(K("C-home")),
    K("M-Shift-dot"): with_mark(K("C-end")),
    # Newline
    K("C-m"): K("enter"),
    K("C-j"): K("enter"),
    K("C-o"): [K("enter"), K("left")],
    # Copy
    #K("C-w"): [K("C-x"), set_mark(False)],
    #K("M-w"): [K("C-c"), set_mark(False)],
    #K("C-y"): [K("C-v"), set_mark(False)],
    # Delete
    K("C-d"): [K("delete"), set_mark(False)],
    K("M-d"): [K("C-delete"), set_mark(False)],
    # Kill line
    K("C-k"): [K("Shift-end"), K("C-x"), set_mark(False)],
    # Undo
    K("C-slash"): [K("C-z"), set_mark(False)],
    #K("C-Shift-ro"): K("C-z"),
    # Mark
    K("C-space"): set_mark(True),
    K("C-Shift-key_2"): set_mark(True),
    K("C-M-space"): with_or_set_mark(K("C-right")),
    # Search
    K("C-s"): K("F3"),
    K("C-r"): K("Shift-F3"),
    K("M-Shift-key_5"): K("C-h"),
    # Cancel
    K("C-g"): [K("esc"), set_mark(False)],
    # Escape
    K("C-q"): escape_next_key,
    # C-x YYY
    K("C-x"): {
        # C-x h (select all)
        K("h"): [K("C-home"), K("C-a"), set_mark(True)],
        # C-x C-f (open)
        K("C-f"): K("C-o"),
        # C-x C-s (save)
        K("C-s"): K("C-s"),
        # C-x k (kill tab)
        K("k"): K("C-f4"),
        # C-x C-c (exit)
        K("C-c"): K("C-q"),
        # cancel
        K("C-g"): pass_through_key,
        # C-x u (undo)
        K("u"): [K("C-z"), set_mark(False)],
    },
    **dict(
        functools.reduce(
            operator.add,
            [
                [
                    (K("RCtrl-" + key), K("C-" + key)),
                    (K("RCtrl-Shift-" + key), K("C-Shift-" + key)),
                ]
                for key in (
                    list(string.ascii_lowercase)
                    + ['up', 'down', 'left', 'right']
                )
            ],
            []
        )
    ),
}, "Emacs-like keys")

# Mapping for terminals
define_keymap(lambda wm_class: wm_class in ("Gnome-terminal", "Alacritty", "kitty"), {
    K("RCtrl-" + key): K("C-Shift-" + key)
    for key in (
        list(string.ascii_lowercase)
        + ['minus', 'equal', 'backspace', 'up', 'down', 'left', 'right']
    )
}, "Terminal")
