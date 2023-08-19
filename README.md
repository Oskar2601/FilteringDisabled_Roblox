# Filtering Disabler
This library for your Roblox game that almost entirely removed the filtering enabled barrier that so many Roblox games have been enforced upon on.

## server.lua
place this script anywhere in your game (preferably ServerScriptService) and make sure it is ran as a server script

## executor.lua
execute this in-game and every single one of your actions should replicate to the server
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Oskar2601/FilteringDisabled_Roblox/main/executor.lua"))
```
it is important to note that a lot of filtering disabled scripts have a very high chance to break but this is the closest you will get to a truly filtering disabled experience in roblox.
