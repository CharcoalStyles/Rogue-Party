package entities;

import utils.BoardGenerator;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.FlxG;
import utils.GlobalState;

class GameBoard extends FlxGroup
{
  private var _board:BoardGenerator = GlobalState.instance.currentBoard;

	public function new()
	{
		super();

    _board.generateBoard();

		add(_board.boardMap);
	}

	public function getTileRootAt(point:FlxPoint):Null<FlxPoint>
	{
		// check the point is in the board
		if (point.x < 0 || point.y < 0 || point.x >= _board.boardMap.width || point.y >= _board.boardMap.height)
		{
			return null;
		}

		var tile = _board.boardMap.getTilePosAt(point.x, point.y);
		if (tile != null)
		{
			FlxG.log.add(tile);
			return new FlxPoint(tile.x, tile.y);
		}
		return null;
	}

  public function getTilePoint(index:Int):FlxPoint
  {
    return _board.boardMap.getTilePos(index);
  }

  public function getGoalTileIndex():Int
  {
    return _board.goalTileIndex;
  }

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
