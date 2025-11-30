package entities;

import utils.GlobalState;
import utils.BoardGenerator;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxGroup
{
  private var _board:BoardGenerator = GlobalState.instance.currentBoard;

  var sprite:FlxSprite;

  var currentTileIndex:Int;

  public function new()
  {
    super();

    currentTileIndex = -1;

    sprite = new FlxSprite(0, 0);
    sprite.loadGraphic("assets/images/player1.png",true);
    sprite.animation.add("idle",[0,1],7,true);
    sprite.animation.play("idle");

    add(sprite);
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);

    if (FlxG.keys.justPressed.SPACE)
    {
      var adjacents = _board.boardAdjacencyList[currentTileIndex];
    //find the forward tile
      for (adj in adjacents)
      {
        if (adj.forward)
        {
          currentTileIndex = adj.index;
          var tilePos = _board.boardMap.getTilePos(currentTileIndex);
          setPosition(tilePos.x, tilePos.y);
          break;
        }
      }
    }

    if (FlxG.keys.justPressed.BACKSPACE)
    {
      var adjacents = _board.boardAdjacencyList[currentTileIndex];
    //find the backward tile
      for (adj in adjacents)
      {
        if (!adj.forward)
        {
          currentTileIndex = adj.index;
          var tilePos = _board.boardMap.getTilePos(currentTileIndex);
          setPosition(tilePos.x, tilePos.y);
          break;
        }
      }
    }
  }

  public function setPosition(x:Float, y:Float):Void
  {
    sprite.x = x;
    sprite.y = y;
  }

  public function setCurrentTileIndex(index:Int):Void
  {
    currentTileIndex = index;
  }
}