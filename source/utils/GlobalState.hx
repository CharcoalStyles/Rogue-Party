package utils;

import flixel.FlxBasic;

class GlobalState extends FlxBasic
{
  public static var instance:GlobalState = new GlobalState();

  public var currentBoard:BoardGenerator;

	public function new()
	{
		super();
    currentBoard = new BoardGenerator();
	}
}