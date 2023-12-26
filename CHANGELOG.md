# v0.2.0-dev.0

Performance improvements and assets optimization.

## Features :sparkles:
- Added loading screen
- Preload assets to improve performance

## Bug Fixes :bug:
- Fixed bug where screen freezes while playing likely due to assets loading

# v0.1.1

Fixed tap gesture for better gameplay.

## Bug Fixes :bug:
- Changed `onTap` to `onTapDown` to improve gameplay


# v0.1.0

Improved version of the game submitted to [Flame Jam 3](https://itch.io/jam/flame-jam-3) focusing on mobile supoort.

## Features :sparkles:
- Changed input to use tap instead of space bar to make it easier to play on mobile
- Added restart functionality
- Used `SpawnComponent` instead of manually spawning the fire
- Added game states

## Bug Fixes :bug:
- Made game responsive to screen size


# v0.1.0.flame-jam3.0

Initial version of the game submitted to [Flame Jam 3](https://itch.io/jam/flame-jam-3)

## Features :sparkles:
- Contains a simple game with a player (fire truck) and a fire
- Fire truck moves left and right while the fire appears at random positions
- The player has to extinguish the fire by spraying water on it by pressing the space bar
- A heat meter shows the current heat level of the fire
- The player has to put out the fire before the heat meter reaches 100%