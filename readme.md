# obs-source-controller: Show and hide sources with a single keypress

The purpose of this program is simple. When the window running this program has
focus, pressing any of the letter or number keys will show or hide an OBS source
which has its name set to that letter or number.

For example, pressing '1' will show a source called '1' if it was hidden, or
hide it if it was visible.

### Prerequisites:

- Ensure you have the [OBS Websocket Plugin](https://obsproject.com/forum/resources/obs-websocket-remote-control-obs-studio-from-websockets.466/) enabled and using
  the default port. (You can change the port in the code but you will need to compile it yourself.)

- You will also need a binary version of this program, It is available for Linux in the Releases tab. You can compile it yourself from source using the [Haskell platform](https://haskell.org/platform).

### How to use:

- Name some of your OBS sources single-character names, either letters or digits. Make sure the letters are lowercase.

- Run this program in a terminal or console and give it focus. Pressing the keys will show and hide the elements.

### Why not just use keyboard shortcuts in OBS?

- Most of the time that will be easier. There are a couple of use cases where this might be preferable:

  - You don't want to keep OBS in focus the whole time for some reason
  - OBS is running on a different computer
  - You have a lot of sources which you need to rearrange and reorder on the fly
  - You don't want to pollute your obs settings with super shorthand keyboard shortcus.
