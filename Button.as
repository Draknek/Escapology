package
{
	import flash.display.*;
	import flash.text.*;
	import flash.events.MouseEvent;
	
	public class Button extends Sprite
	{
		public var textField: MyTextField;
		
		public function Button (_text: String, _textSize: Number = 16, _width: Number = 0)
		{
			textField = new MyTextField(10, 5, _text, "left", _textSize, "default2");
			
			var _height: Number = textField.height + 10;
			
			_width = Math.max(_width, textField.width + 20);
			
			textField.x = _width / 2 - textField.width / 2;
			
			addChild(textField);
			
			buttonMode = true;
			mouseChildren = false;
			
			textField.textColor = 0x000000;
			
			addEventListener(MouseEvent.ROLL_OVER, function (param: * = 0) : void {textField.textColor = 0xFF0000});
			addEventListener(MouseEvent.ROLL_OUT, function (param: * = 0) : void {textField.textColor = 0x000000});
		}
		
	}
}

