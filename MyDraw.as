package {
	
import Box2D.Collision.*;
import Box2D.Collision.Shapes.*;
import Box2D.Dynamics.Contacts.*;
import Box2D.Dynamics.*;
import Box2D.Common.Math.*;
import Box2D.Common.*;

import Box2D.Common.b2internal;
use namespace b2internal;

import flash.display.Sprite;

	public class MyDraw extends b2DebugDraw
	{
		/**
		* Draw a solid circle.
		*/
		public override function DrawSolidCircle(center:b2Vec2, radius:Number, axis:b2Vec2, color:b2Color) : void{
		
			m_sprite.graphics.lineStyle(m_lineThickness, color.color, m_alpha);
			m_sprite.graphics.moveTo(0,0);
			m_sprite.graphics.beginFill(color.color, m_fillAlpha);
			m_sprite.graphics.drawCircle(center.x * m_drawScale, center.y * m_drawScale, radius * m_drawScale);
			m_sprite.graphics.endFill();
		
		}
	}
}
