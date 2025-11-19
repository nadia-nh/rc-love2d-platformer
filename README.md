## RC LÖVE2D Platformer

<img width="1592" height="956" alt="screenshot" src="screenshot-rc-love-platformer.png" />

Small learning project built at the [Recurse Center](https://www.recurse.com/) with LÖVE2D to explore the engine. It features a player that can jump over platforms in order to collect coins, when the player falls off the map it respawn at the initial position and the coins are reset. This game includes basic gravity and platform collision (landing on top of platforms).

### Running the game

Clone the repo:
```
git clone https://github.com/nadia-nh/rc-love2d-platformer.git
cd rc-love2d-platformer
```

Run with LÖVE:
```
love .
```

You can also point LÖVE at this folder.

Controls:
- Left / Right arrow keys – move
- Up – jump
- Esc – quit

### How the game works

The main callback function in LÖVE are :
- `love.load()`: runs once at the beginning, used for loading images and setting up the world
- `love.update(dt)`: runs every frame, used for moving the player, applying gravity, handling collisions, respawns, and coin pickups
- `love.draw()`: runs every frame after update, used for drawing the background, platforms, coins, and player

The logic is organized into a few small files:
- main.lua: ties everything together, calls module functions, handles the main loop
- player.lua: handles player movement, gravity, jumping, respawn
- platforms.lua: contains the platform list, handles collisions between the player and the platforms
- coins.lua: contains coin positions, handles coin pickup logic
