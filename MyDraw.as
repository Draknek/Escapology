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
		
		/**
		* Draw a solid closed polygon provided in CCW order.
		*/
		/*public override function DrawSolidPolygon(vertices:Vector.<b2Vec2>, vertexCount:int, color:b2Color) : void{
			if (vertexCount == 4) {
				super.DrawSolidPolygon(vertices, vertexCount, color)
				return;
			}
			m_sprite.graphics.lineStyle(m_lineThickness, 0xDDDDDD);
			m_sprite.graphics.moveTo(vertices[0].x * m_drawScale, vertices[0].y * m_drawScale);
			m_sprite.graphics.beginFill(0xAAAAAA);
			for (var i:int = 1; i < vertexCount; i++){
					m_sprite.graphics.lineTo(vertices[i].x * m_drawScale, vertices[i].y * m_drawScale);
			}
			m_sprite.graphics.lineTo(vertices[0].x * m_drawScale, vertices[0].y * m_drawScale);
			m_sprite.graphics.endFill();
		
		}*/
	}
}
