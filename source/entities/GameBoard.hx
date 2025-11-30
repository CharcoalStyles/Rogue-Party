package entities;

import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.tile.FlxTilemap;

class GameBoard extends FlxGroup
{
	static inline var TILE_WIDTH:Int = 24;

	static inline var TILE_HEIGHT:Int = 24;

	/**
	 * The FlxTilemap we're using
	 */
	var _boardMap:FlxTilemap;
  var _goalTileIndex:Int;

	public function new()
	{
		super();

		_boardMap = new FlxTilemap();

    var boardData:Array<Array<Int>> = [
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
			[0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
			[0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
			[0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
			[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		];

    boardData = boardData.map(row -> row.map(cell -> cell == 1 ? FlxG.random.int(1, 2): cell));

    _goalTileIndex = -1;

    for (y in 0...boardData.length)
    {
      for (x in 0...boardData[y].length)
      {
        if (boardData[y][x] == 1 && _goalTileIndex < 0)
        {
          boardData[y][x] = 3;
          _goalTileIndex = y * boardData[y].length + x;
          break;
        }
      }
      if (_goalTileIndex >= 0) break;
    }

		_boardMap.loadMapFrom2DArray(boardData, "assets/images/tileset1.png", TILE_WIDTH, TILE_HEIGHT);

		add(_boardMap);
	}

  public function getTileRootAt(point:FlxPoint):Null<FlxPoint>
  {
    //check the point is in the board
    if (point.x < 0 || point.y < 0 || point.x >= _boardMap.width || point.y >= _boardMap.height) {
      return null;
    }

    var tile =  _boardMap.getTilePosAt(point.x, point.y);
    if (tile != null)
    {
      FlxG.log.add(tile);
      return new FlxPoint(tile.x, tile.y);
    }
    return null;
  }

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
