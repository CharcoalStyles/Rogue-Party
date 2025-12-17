package entities;

import flixel.text.FlxText;
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
	var isMovingBackward:Bool = false;

	var isMoving:Bool = false;

	var nextAdjacents:utils.AdjacencyWithDirection;

	var debugText:FlxText;

	public function new()
	{
		super();

		currentTileIndex = -1;

		sprite = new FlxSprite(0, 0);
		sprite.loadGraphic("assets/images/player1.png", true);
		sprite.animation.add("idle", [0, 1], 7, true);
		sprite.animation.play("idle");

		add(sprite);

		debugText = new FlxText(0, 0, 200, "");
		debugText.setFormat(null, 8, 0xFFFFFFFF, "left");
		add(debugText);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (isMoving)
		{
			debugText.x = sprite.x;
			debugText.y = sprite.y - 10;
		}

		if (!isMoving)
		{
      if(FlxG.keys.justPressed.SPACE)
      {
        isMovingBackward = !isMovingBackward;
        setAvailableDirections();
      }

			if (FlxG.keys.anyJustPressed([LEFT, RIGHT, UP, DOWN]))
			{
				var workingAdjacents = if (isMovingBackward) nextAdjacents.backwards else nextAdjacents.forwards;
				for (adj in workingAdjacents)
				{
					var pressed:Bool = false;
					switch (adj.direction)
					{
						case Left:
							pressed = FlxG.keys.justPressed.LEFT;
						case Right:
							pressed = FlxG.keys.justPressed.RIGHT;
						case Up:
							pressed = FlxG.keys.justPressed.UP;
						case Down:
							pressed = FlxG.keys.justPressed.DOWN;
					}

					if (pressed)
					{
						setCurrentTileIndex(adj.index);
						var tilePos = _board.boardMap.getTilePos(currentTileIndex);
						setTargetPosition(tilePos.x, tilePos.y);
						break;
					}
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
		isMoving = true;
		targetPosition = FlxPoint.get(x, y);
		var midpoint = FlxPoint.get((sprite.x + targetPosition.x) / 2, (sprite.y + targetPosition.y) / 2 - 8);
		FlxTween.tween(sprite, {x: midpoint.x, y: midpoint.y}, moveTime, {
			ease: FlxEase.quadIn,
			onComplete: function(twn:FlxTween)
			{
				originPosition = midpoint;
				FlxTween.tween(sprite, {x: x, y: y}, moveTime, {
					ease: FlxEase.quadOut,
					onComplete: function(twn2:FlxTween)
					{
						isMoving = false;

						nextAdjacents = _board.boardAdjacencyList[currentTileIndex];
					}
				});
			}
		});
	}

	public function setCurrentTileIndex(index:Int):Void
	{
		currentTileIndex = index;
		nextAdjacents = _board.boardAdjacencyList[currentTileIndex];
    setAvailableDirections();
	}

  function setAvailableDirections():Void
  {
    var workingAdjacents = if (isMovingBackward) nextAdjacents.backwards else nextAdjacents.forwards;
		var nextKeys = [];
		for (adj in workingAdjacents)
		{
      trace(adj);
			switch (adj.direction)
			{
				case Left:
					nextKeys.push("L");
				case Right:
					nextKeys.push("R");
				case Up:
					nextKeys.push("U");
				case Down:
					nextKeys.push("D");
			}
		}
    trace(nextKeys);
    debugText.text = (if (isMovingBackward) "B: " else "F: ") + "(" + nextKeys.join(", ") + ")";
  }
}
