package entities;

import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxGroup
{
  var sprite:FlxSprite;

  public function new()
  {
    super();

    sprite = new FlxSprite(0, 0);
    sprite.loadGraphic("assets/images/player1.png",true);
    sprite.animation.add("idle",[0,1],7,true);
    sprite.animation.play("idle");

    add(sprite);
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);
  }

  public function setPosition(x:Float, y:Float):Void
  {
    sprite.x = x;
    sprite.y = y;
  }
}