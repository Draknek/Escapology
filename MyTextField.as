package
{
	import flash.display.*;
	import flash.text.*;
	
	public class MyTextField extends TextField
	{
		[Embed(source="fonts/pixelhugger.ttf", fontName='pixelhugger', mimeType='application/x-font')]
		public static var PixelHuggerFontSrc : Class;
		
		public static var pixelHuggerFont : Font = new PixelHuggerFontSrc();
		
		public function MyTextField (_x: Number, _y: Number, _text: String, _align: String = TextFieldAutoSize.CENTER, textSize: Number = 16, _fontName: String = null)
		{
			x = _x;
			y = _y;
			
			textColor = 0xFFFFFF;
			
			selectable = false;
			mouseEnabled = false;
			
			if (! _fontName)
			{
				_fontName = pixelHuggerFont.fontName;
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
			
		}
		
	}
}

