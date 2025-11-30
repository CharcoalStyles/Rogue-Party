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
    add(player);
    var tile = gameBoard.getTilePoint(gameBoard.getGoalTileIndex());
    player.setCurrentTileIndex(gameBoard.getGoalTileIndex());
    player.setPosition(tile.x, tile.y);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

	}
}
