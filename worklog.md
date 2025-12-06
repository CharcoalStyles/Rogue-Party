#2025-12-06 23:52:03

I told you the next thing would be some animation for moving between tiles!

#2025-11-30 21:36:10

Put the board into the GlobalState so other things can access it. TBH, this goes against most of my programming principles, but I think that's just because I haven't made games for a loooooong time. Also, I did dabble with it in Questing Puzzles. It means instead of passing references to the board around, I can just get it from GlobalState. This *will* cause some headaches later when I change something in one place and something else changes a similar thing and the board is different to what my mental model expects. BUT it could lead to some cool bugs/unexpected behaviour, and isn't that part of the fun of roguelikes? Also, if it's good I can claim it was intentional. :D

I'm using a two way linked list to represent the board connections. Each tile has a list of tiles it connects to, and whether the connection is forward or backward. Currently, the board is linear,  but this structure will allow for branching paths later on, as well as loops! Then decision points can be added where players can choose which way to go, like in Mario Party. Right now it is tied to the landing spots being tiles, but I could take hte movement and stuff out of a tile map and just have nodes. Or keep it in the map, but have tiles be non-contiguous. Lots of options. Right now I'm just focusing on getting something basic working, so I can play with all these ideas later.

Currently there's one player and they are placed on the start tile. Pressing space moves them forward one tile and pressing backspace moves them back one tile. Next should be dice/spinner and multiple players with turns. BUT I know i'll want to do a little animation for moving between tiles. Possibly with a little particle effect for when they land. #priorities

# 2025-11-30 18:06:39

Fixed up some stuff the my libs for menu stuff with mouse.

Set up the most basic of basics of a board and player.

It's *a* start...

# 2025-11-30 16:38:40

And here we are again!

A new project, a new beginning. Or is this just more procrastination?

I think we all know the answer to that :D

Anyway, I've set up a new repository for my Rogue-Party project. Think Mario Party x Billion Road x Vamprire Survivors? It's early days yet, but I've got a bunch of ideas brewing and positive vibes form friends.

Time to setup a generic board, player and turn system. Then I get to play with the fun stuff.