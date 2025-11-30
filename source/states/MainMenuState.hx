package states;

import csHxUtils.entities.CsMenu;
import csHxUtils.entities.SplitText;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import utils.GlobalState;

class MainMenuState extends FlxState
{
	var gameName:String = "Rogue Party";
	var globalState:GlobalState;

	override public function create()
	{
		super.create();
		globalState = new GlobalState();
		FlxG.plugins.addPlugin(globalState);

		FlxG.mouse.visible = true;

		var text = generateTitle();
		add(text);
		text.x = (FlxG.width - text.width) / 2;
		text.y = 96;

		var menu = new CsMenu(FlxG.width / 2, FlxG.height / 2, FlxTextAlign.CENTER, {
			keyboard: true,
			mouse: true,
			gamepad: true,
			gamepadId: 0
		});
		var mainPage = menu.createPage("Main");

		mainPage.addItem("New Battle", () ->
		{
			FlxG.switchState(PlayState.new);
		});
		mainPage.addItem("Toggle Fullscreen", () -> FlxG.fullscreen = !FlxG.fullscreen);

		add(menu);
	}

	function generateTitle()
	{
		var text = new SplitText(0, 0, gameName, SplitText.naiieveScaleDefaultOptions(2.5));
		text.color = 0xff000000;
		text.borderColor = 0xffffffff;
		text.borderQuality = 4;
		text.borderSize = 4;
		text.borderStyle = OUTLINE;
		text.animateWave(5, 0.1, 1.5, false);
		text.animateColourByArray([0xffff8888, 0xff88ff88, 0xff8888ff], 0.075, 0.6,);

		return text;
	}
}