package utils;

import flixel.tile.FlxTilemap;
import flixel.FlxG;

typedef AdjacencyWithDirection =
{
	var index:Int;
	var forward:Bool;
}

class BoardGenerator
{
	static inline var TILE_WIDTH:Int = 24;

	static inline var TILE_HEIGHT:Int = 24;

	public var goalTileIndex:Int;
	public var boardAdjacencyList:Array<Array<AdjacencyWithDirection>>;
	public var boardMap:FlxTilemap;
	public var boardData:Array<Array<Int>>;

	public function new()
	{
		boardMap = new FlxTilemap();

		boardData = [];
		boardAdjacencyList = [];

		// var rows:Int = FlxG.random.int(7, 10);
		// var cols:Int = FlxG.random.int(10, 15);

		// for (y in 0...rows)
		// {
		// 	boardData.push([]);
		//   _boardAdjacencyList.push([]);
		// 	for (x in 0...cols)
		// 	{
		// 		boardData[y].push(0);
		//     _boardAdjacencyList[y].push([]);
		// 	}
		// }
	}

	public function generateBoard()
	{
		// //12 x 7 tiles
		var boardData:Array<Array<Int>> = [
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // 0-11
			[0, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0], // 12-23
			[0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0], // 24-35
			[0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0], // 36-47
			[0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0], // 48-59
			[0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0], // 60-71
			[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0], // 72-83
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // 84-95
		];

		goalTileIndex = 13;

		boardAdjacencyList[13] = [{index: 14, forward: true}, {index: 25, forward: false}];

		// for 14 to 21
		for (i in 14...22)
		{
			boardAdjacencyList[i] = [{index: i + 1, forward: true}, {index: i - 1, forward: false}];
		}

		boardAdjacencyList[22] = [{index: 34, forward: true}, {index: 21, forward: false}];

		// for 34 to 70 (step by 12)
		for (i in 34...71)
		{
			if ((i - 34) % 12 == 0)
			{
				boardAdjacencyList[i] = [{index: i + 12, forward: true}, {index: i - 12, forward: false}];
			}
		}

		boardAdjacencyList[82] = [{index: 81, forward: true}, {index: 70, forward: false}];

    //81 to 74
    var i = 81;
    while (i > 73) {
        boardAdjacencyList[i] = [{index: i - 1, forward: true}, {index: i + 1, forward: false}];  
        i--;
    }

    boardAdjacencyList[73] = [{index: 61, forward: true}, {index: 74, forward: false}];

    //61 to 25
    i = 61;
    while (i >= 25) {
        boardAdjacencyList[i] = [{index: i - 12, forward: true}, {index: i + 12, forward: false}];
        i -= 12;
    }

		boardData = boardData.map(row -> row.map(cell -> cell == 1 ? FlxG.random.int(1, 2) : cell));

		var indices:Array<Array<String>> = [];
		for (y in 0...boardData.length)
		{
		  indices.push([]);
		  for (x in 0...boardData[y].length)
		  {
        var thisIndex = x + y * boardData[y].length;
        // trace("thisIndex: " + thisIndex);
        // trace(boardAdjacencyList);
        FlxG.log.add("Index: " + thisIndex + " Adjacents: " + boardAdjacencyList[thisIndex]);
        if (boardAdjacencyList[thisIndex] != null)
        {
          indices[y].push("x");
        }
        else
        {
          indices[y].push("-");
        }
		  }
		}

    // log the indices for reference
    for (row in indices)
    {
      FlxG.log.add(row);
    }

    boardMap = new FlxTilemap();
    boardMap.loadMapFrom2DArray(boardData, "assets/images/tileset1.png", TILE_WIDTH, TILE_HEIGHT);
	}
}
