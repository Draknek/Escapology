package
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.SharedObject;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import net.flashpunk.utils.Key;
	import net.flashpunk.*;
	
	public class Audio
	{
		[Embed(source="audio/mp3/die1.mp3")] public static var Die1Sfx:Class;
		[Embed(source="audio/mp3/die2.mp3")] public static var Die2Sfx:Class;
		[Embed(source="audio/mp3/die3.mp3")] public static var Die3Sfx:Class;
		[Embed(source="audio/mp3/die4.mp3")] public static var Die4Sfx:Class;
		[Embed(source="audio/mp3/die5.mp3")] public static var Die5Sfx:Class;
		[Embed(source="audio/mp3/die6.mp3")] public static var Die6Sfx:Class;
		[Embed(source="audio/mp3/die7.mp3")] public static var Die7Sfx:Class;
		[Embed(source="audio/mp3/die8.mp3")] public static var Die8Sfx:Class;
		[Embed(source="audio/mp3/die9.mp3")] public static var Die9Sfx:Class;
		[Embed(source="audio/mp3/die10.mp3")] public static var Die10Sfx:Class;
		[Embed(source="audio/mp3/die11.mp3")] public static var Die11Sfx:Class;
		[Embed(source="audio/mp3/scrape.mp3")] public static var ScrapeSfx:Class;
		
		private static var sounds:Object = {};
		
		private static var _mute:Boolean = false;
		private static var so:SharedObject;
		private static var menuItem:ContextMenuItem;
		
		private static var dieShuffle:Array = [];
		
		public static function init (o:InteractiveObject):void
		{
			FP.randomizeSeed();
			// Setup
			
			so = SharedObject.getLocal("audio");
			
			_mute = so.data.mute;
			
			addContextMenu(o);
			
			if (o.stage) {
				addKeyListener(o.stage);
			} else {
				o.addEventListener(Event.ADDED_TO_STAGE, stageAdd);
			}
			
			// Create sounds
			
			for (var i:int = 1; i <= 11; i++) {
				sounds["die" + i] = new Sfx(Audio["Die"+i+"Sfx"]);
			}
			
			sounds["scrape"] = new Sfx(ScrapeSfx);
		}
		
		public static function play (sound:String):void
		{
			if (_mute) return;
			
			if (sound == "die") {
				if (dieShuffle.length == 0) {
					dieShuffle.push(1,2,3,4,5,6,7,8,9,10,11);
					FP.shuffle(dieShuffle);
				}
				
				sound = "die" + dieShuffle.pop();
			}
			
			if (sounds[sound]) {
				var volume:Number = 1.0;
				
				if (sound == "scrape") {
					volume = 0.5 + Math.random()*0.1;
				}
				
				sounds[sound].play(volume);
			}
		}
		
		// Getter and setter for mute property
		
		public static function get mute (): Boolean { return _mute; }
		
		public static function set mute (newValue:Boolean): void
		{
			if (_mute == newValue) return;
			
			_mute = newValue;
			
			menuItem.caption = _mute ? "Unmute" : "Mute";
			
			so.data.mute = _mute;
			so.flush();
		}
		
		// Implementation details
		
		private static function stageAdd (e:Event):void
		{
			addKeyListener(e.target.stage);
		}
		
		private static function addContextMenu (o:InteractiveObject):void
		{
			var menu:ContextMenu = o.contextMenu || new ContextMenu;
			
			menu.hideBuiltInItems();
			
			menuItem = new ContextMenuItem(_mute ? "Unmute" : "Mute");
			
			menuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuListener);
			
			menu.customItems.push(menuItem);
			
			o.contextMenu = menu;
		}
		
		private static function addKeyListener (stage:Stage):void
		{
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, keyListener);
		}
		
		private static function keyListener (e:KeyboardEvent):void
		{
			if (e.keyCode == Key.M) {
				mute = ! mute;
			}
		}
		
		private static function menuListener (e:ContextMenuEvent):void
		{
			mute = ! mute;
		}
	}
}

