package
{
	import org.flixel.*;
	import com.newgrounds.*;
	
	public class PlayState extends FlxState
	{
		private var background:FlxSprite;
		private var map:FlxTilemap;
		private var player:Player;
		private var trophy:FlxSprite;
		private var treasure:FlxSprite;
		private var platforms:FlxGroup;
		private var gotKey:Boolean = false;
		
		public function PlayState():void
		{
		
		}
		
		override public function create():void
		{
			//STARTING THE GAME...
			FlxG.flash(0);
			FlxG.playMusic(Sources.Mp3Soundtrack, 0.7);
			FlxG.music.fadeIn(3);
			FlxG.framerate = 60;
			FlxG.flashFramerate = 60;
			
			background = new FlxSprite(0, 0, Sources.ImgBackground); //CREATE BACKGROUND
			add(background); //ADDING BACKGROUND TO THE STAGE AND MAKING IT VISIBLE
			
			map = new FlxTilemap(); //CREATING MAP
			map.loadMap(new Sources.TxtMap, Sources.ImgMap, 16, 16); //LOADING MAP
			add(map); //ADDING MAP TO THE STAGE AND MAKING IT VISIBLE
			
			player = new Player(); //CREATING PLAYER
			player.x = FlxG.width / 2;
			player.y = FlxG.height - 31; //SETTING POSITION OF THE PLAYER
			add(player); //ADDING PLAYER TO THE STAGE AND MAKING HIM VISIBLE
			
			trophy = new FlxSprite(FlxG.width / 2, 16, Sources.ImgTrophy);
			add(trophy);
			
			treasure = new FlxSprite(FlxG.width / 2, 180, Sources.ImgTreasure);
			add(treasure);
			
			platforms = new FlxGroup;
			add(platforms);
			addPlatform(3, 2, 9, 2);
			addPlatform(12, 2, 17, 2);			
		}
		
		override public function update():void
		{
			FlxG.collide(player, map); //MAKE BOTH COLLIDE
			FlxG.overlap(player, trophy, gotTrophy);
			FlxG.collide(player, platforms);			
			FlxG.overlap(treasure, player, getChest);			
			super.update();
		}
		
		private function gotTrophy(a:Player, b:FlxSprite):void
		{
			API.unlockMedal("The Trophy");
			FlxG.flash();
			FlxG.play(Sources.Mp3Powerup, 0.7);
			remove(trophy);
			trophy = null;
			gotKey = true;
		}
		
		private function addPlatform(startX:int, startY:int, endX:int, endY:int):void {
			var platform:FlxSprite = new FlxSprite(startX * 16, startY * 16, Sources.ImgPlatform);
			platform.immovable = true;
			platforms.add(platform);
			platform.followPath(new FlxPath([new FlxPoint(startX * 16 + 8, startY * 16 + 8), new FlxPoint(endX * 16 - 8, endY * 16 - 8)]), 50, FlxObject.PATH_YOYO);			
		}
		
		private function getChest(a:FlxSprite, b:FlxSprite):void {
			if (gotKey == true) {
				API.getMedal("The Chest");
			} else {
				
			}
		}
	}
}