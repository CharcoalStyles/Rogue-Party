package states;

import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState
{
  var player:entities.Player;
  var gameBoard:entities.GameBoard;

	override public function create()
	{
		super.create();

		gameBoard = new entities.GameBoard();
		add(gameBoard);
    player = new entities.Player();
    player.setPosition(-48, -48);
    add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

    if (FlxG.mouse.justPressed)
    {
      var tile = gameBoard.getTileRootAt(FlxG.mouse.getWorldPosition()); 
      if (tile != null)
      {
        FlxG.log.add(tile);
        player.setPosition(tile.x, tile.y);
      }
    }
	}
}
