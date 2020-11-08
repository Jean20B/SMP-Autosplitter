# Super Mario Pandemonium - LiveSplit Autosplitter
This LiveSplit autosplitter for Super Mario Pandemonium has 3 features:
* Starts automatically the timer when the first level is loaded
* Splits when a new level is loaded (and when the ending is loaded)
* Resets when you are on the main menu

## Links

* [Super Mario Pandemonium](https://mfgg.net/index.php?act=resdb&param=02&c=2&id=301)
* [LiveSplit](https://livesplit.org/)
* [Speedrun.com - SMP](https://www.speedrun.com/smp)

## How to activate the autosplitter
Open **LiveSplit** -> **Edit Splits...** -> Set the **game name** (Super Mario Pandemonium) -> Press **Activate**

## How does the script work?
There is an address in the game (`0x2801E`) where a text (a `string`) is located, and this text gives the title of the level or menu that is currently loaded.

So I simply use this text to know when a new level is loaded.

However there are loading times (~ 1-3 seconds), and the timer can start or split before it's done loading, but it doesn't really matter and there's no load removal in this script.
