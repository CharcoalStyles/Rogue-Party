package entities;

import flixel.tweens.FlxEase;
import flixel.math.FlxPoint;
import utils.GlobalState;
import utils.BoardGenerator;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;

class Player extends FlxGroup
{
	private var _board:BoardGenerator = GlobalState.instance.currentBoard;

	var sprite:FlxSprite;

	var currentTileIndex:Int;

	var originPosition:Null<FlxPoint>;
	var targetPosition:Null<FlxPoint>;
	var moveTime:Float = 0.25;

	public function new()
	{
		super();

		currentTileIndex = -1;

		sprite = new FlxSprite(0, 0);
		sprite.loadGraphic("assets/images/player1.png", true);
		sprite.animation.add("idle", [0, 1], 7, true);
		sprite.animation.play("idle");

		add(sprite);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.SPACE)
		{
			var adjacents = _board.boardAdjacencyList[currentTileIndex];
			// find the forward tile
			for (adj in adjacents)
			{
				if (adj.forward)
				{
					currentTileIndex = adj.index;
					var tilePos = _board.boardMap.getTilePos(currentTileIndex);
					setTargetPosition(tilePos.x, tilePos.y);
					break;
				}
			}
		}

		if (FlxG.keys.justPressed.BACKSPACE)
		{
			var adjacents = _board.boardAdjacencyList[currentTileIndex];
			// find the backward tile
			for (adj in adjacents)
			{
				if (!adj.forward)
				{
					currentTileIndex = adj.index;
					var tilePos = _board.boardMap.getTilePos(currentTileIndex);
					setTargetPosition(tilePos.x, tilePos.y);
					break;
				}
			}
		}
	}

  public function forcePosition(x:Float, y:Float):Void
  {
    sprite.x = x;
    sprite.y = y;
  }

	public function setTargetPosition(x:Float, y:Float):Void
	{
		targetPosition = FlxPoint.get(x, y);
    var midpoint = FlxPoint.get(
      (sprite.x + targetPosition.x) / 2,
      (sprite.y + targetPosition.y) / 2 - 8
    );
		FlxTween.tween(sprite, {x: midpoint.x, y: midpoint.y}, moveTime, {
			ease: FlxEase.quadIn,
			onComplete: function(twn:FlxTween)
			{
				originPosition = midpoint;
        FlxTween.tween(sprite, {x: x, y: y}, moveTime, {
          ease: FlxEase.quadOut,
          onComplete: function(twn2:FlxTween)
          {
            // on move finish
          }
        });
			}
		});
	}

	public function setCurrentTileIndex(index:Int):Void
	{
		currentTileIndex = index;
	}
}
