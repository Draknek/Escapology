package
{
	import flash.display.*;
	import flash.text.*;
	
	import flash.filters.*;
	
	public class MyTextField extends TextField
	{
		[Embed(source="fonts/miama_regular.ttf", fontName='default2', mimeType='application/x-font')]
		public static var FontSrc : Class;
		
		public static var embedFont : Font = new FontSrc();
		
		public function MyTextField (_x: Number, _y: Number, _text: String, _align: String = TextFieldAutoSize.CENTER, textSize: Number = 16, _fontName: String = null)
		{
			x = _x;
			y = _y;
			
			textColor = 0xFF0000;
			
			selectable = false;
			mouseEnabled = false;
			
			if (! _fontName)
			{
				_fontName = embedFont.fontName;
			}
			
			var _textFormat : TextFormat = new TextFormat(_fontName, textSize);
			
			_textFormat.align = _align;
			
			defaultTextFormat = _textFormat;
			
			embedFonts = true;
			
			autoSize = _align;
			
			text = _text;
			
			if (_align == TextFieldAutoSize.CENTER)
			{
				x = _x - textWidth / 2;
			}
			else if (_align == TextFieldAutoSize.RIGHT)
			{
				x = _x - textWidth;
			}
			
			var outline:GlowFilter = new GlowFilter();
			outline.blurX = outline.blurY = 2;
			outline.color = 0xededed;
			outline.quality = BitmapFilterQuality.HIGH;
			outline.strength = 100;

			filters = [outline];

			
		}
		
	}
}

