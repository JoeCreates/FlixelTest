package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;
import haxe.Timer;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState {
	
	var player:FlxSprite;
	var grp:FlxTypedGroup<FlxSpriteGroup>;
	
	public static inline var SPRITE_SIZE = 40;
	public static inline var SPACING = 20;
	
	override public function create():Void {
		super.create();
		
		player = makeSprite(20, 20, 0xffaa2222);
		
		grp = new FlxTypedGroup<FlxSpriteGroup>();
		for (x in -5...20) {
			for (y in -5...20) {
				grp.add(makeSprite(x * (SPRITE_SIZE + SPACING), y * (SPRITE_SIZE + SPACING)));
			}
		}
		
		add(grp);
		add(player);
		FlxG.camera.follow(player);
		FlxG.camera.style = FlxCamera.STYLE_LOCKON;
	}
	
	public function makeSprite(x:Float, y:Float, color:Int = 0xff888888):FlxSpriteGroup {
		var grp = new FlxSpriteGroup();
		var spr = new FlxSprite();
		var txt = new FlxText(2, 2, 0, x + ", " + y);
		spr.makeGraphic(SPRITE_SIZE, SPRITE_SIZE, color);
		FlxSpriteUtil.drawCircle(spr, 5, 5, 5, 0xff000000);
		grp.add(spr);
		grp.add(txt);
		grp.setPosition(x, y);
		return grp;
	}
	
	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void {
		super.update();
		
		if (FlxG.keys.pressed.UP) player.y -= 2;	
		if (FlxG.keys.pressed.DOWN) player.y += 2;
		if (FlxG.keys.pressed.LEFT) player.x -= 2;	
		if (FlxG.keys.pressed.RIGHT) player.x += 2;
		
		FlxG.overlap(player, grp, function (pl:FlxSprite, spr:FlxSpriteGroup) {
			if (Std.is(spr, FlxSpriteGroup)) {
				cast(spr, FlxSpriteGroup).forEach(function(spr:FlxSprite) {
					if (!Std.is(spr, FlxText)) {
						spr.makeGraphic(SPRITE_SIZE, SPRITE_SIZE, 0xffffffff);
					}
				});
			}
		});
		
	}	
}