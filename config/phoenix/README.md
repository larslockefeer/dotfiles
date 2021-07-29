# Phoenix configuration
## Keyboard shortcuts
### Window management
<kbd>⇪ + \</kbd> Move window to next screen<br/>
<kbd>⇪ + \</kbd> Move window to previous screen<br/>

<kbd>⇪ + ↑</kbd> Move window to top half<br/>
<kbd>⇪ + →</kbd> Move window to right half<br/>
<kbd>⇪ + ↓</kbd> Move window to bottom half<br/>
<kbd>⇪ + ←</kbd> Move window to left half<br/>

<kbd>⇪ + ␣</kbd> Expand window to full width and height<br/>

## Key legend
```
⎋: escape)
⇥: tab
⇪: caps lock
⇧: shift
⌃: control
⌥: option
: Apple
⌘: command
␣: space
⏎: return
⌫: backspace
⌦: delete
⇱: home
⇲: end
⇞: page up
⇟: page down
↑: up arrow
↓: down arrow
←: left arrow
→: right arrow
⌧: clear
⇭: num lock
⌤: enter
⏏: eject
⌽: power
```

## Prerequisites
This configuration uses a remap of the Caps Lock key to something more useful: the Hyper key <kbd>⇪</kbd> (basically just <kbd>ctrl + alt + cmd + shift</kbd> combined into one key) if used in combination with other keys, otherwise it gets mapped to <kbd>F18</kbd>, which is used to trigger the space switcher. If you prefer you may skip these remap steps while you try the configuration, but if you usually have many spaces opened I highly recommend you not to miss out the awesome space switcher, for which this hack is a requirement.

1. Install [Phoenix](https://github.com/kasper/phoenix#install)
2. Install [Karabiner Elements](https://github.com/tekezo/Karabiner-Elements) via its [dmg](https://pqrs.org/latest/karabiner-elements-latest.dmg)
3. Replace Caps Lock with Hyper/F18 using [this](http://tinyurl.com/yc8m5qe8) Karabiner Elements configuration (if the link doesn't work copy and paste this in a browser: `karabiner://karabiner/assets/complex_modifications/import?url=https%3A%2F%2Fraw.githubusercontent.com%2Ffabiospampinato%2Fphoenix%2Fmaster%2Fconfig%2Fkarabiner.json`)
4. `$ mkdir ~/.config`
5. `$ cd ~/.config`
6. `$ git clone git@github.com:fabiospampinato/phoenix.git`
7. Restart Phoenix
8. Enjoy!

## TODO

- [ ] Move windows between spaces
- [ ] More screen configurations (quarters, thirds, center)
- [ ] Restore last known position (undo)
- [ ] Two most recent windows (of an application) side by side
- [ ] [Window selector](https://github.com/kgrossjo/phoenix-config/#window-selector)?

## Acknowledgements
* https://github.com/fabiospampinato/phoenix.git for structure and some basic window manipulations
* https://gist.github.com/danshan/a2039396cfa19ec2379a19feacf05dc0 for moving windows between screens
