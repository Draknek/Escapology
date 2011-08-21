﻿/*
* Copyright (c) 2006-2007 Erin Catto http://www.gphysics.com
*
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any damages
* arising from the use of this software.
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source distribution.
*/


package{
	
	
	
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
import General.*
import com.greensock.*;
import com.greensock.easing.*;
import flash.display.*;
import flash.text.*;
import net.flashpunk.graphics.*;
import net.flashpunk.*;
	
	
	
	public class Game extends Test{
		public var text:TextField;
		[Embed(source="particle.png")]
		public static var particleGfx: Class;
		
		public var particles: Vector.<Particle> = new Vector.<Particle>();
		
		public var bloodFirst: Particle = null;
		
		public var bloodImages: Vector.<Image> = new Vector.<Image>(8, true);
		
		public var bloodBuffer:BitmapData = new BitmapData(300, 300, true, 0);
		
		public function Game(){
			text = new MyTextField(150, 100, "", TextFieldAutoSize.CENTER, 40);
			
			m_sprite.addChild(text);
			m_sprite.addChild(new Bitmap(bloodBuffer));
			
			var circ:b2CircleShape; 
			var box:b2PolygonShape;
			var bd:b2BodyDef = new b2BodyDef();
			var jd:b2RevoluteJointDef = new b2RevoluteJointDef();
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.filter.groupIndex = 2;
			fixtureDef.filter.categoryBits = 0x2;
			
			// Add 5 ragdolls along the top
			for (var i:int = 0; i < 1; i++){
				var startX:Number = 100;
				var startY:Number = 30;
				
				// BODIES
				// Set these to dynamic bodies
				bd.type = b2Body.b2_dynamicBody;
				bd.linearDamping = 10.0;
				bd.angularDamping = 10.0;
				
				// Head
				circ = new b2CircleShape( 12.5 / m_physScale );
				fixtureDef.shape = circ;
				fixtureDef.density = 1.0;
				fixtureDef.friction = 0.4;
				fixtureDef.restitution = 0.3;
				bd.position.Set(startX / m_physScale, startY / m_physScale);
				var head:b2Body = m_world.CreateBody(bd);
				head.CreateFixture(fixtureDef);
				//if (i == 0){
					//head.ApplyImpulse(new b2Vec2(Math.random() * 100 - 50, Math.random() * 100 - 50), head.GetWorldCenter());
				//}
				
				// Torso1
				box = new b2PolygonShape();
				box.SetAsBox(15 / m_physScale, 10 / m_physScale);
				fixtureDef.shape = box;
				fixtureDef.density = 1.0;
				fixtureDef.friction = 0.4;
				fixtureDef.restitution = 0.1;
				bd.position.Set(startX / m_physScale, (startY + 28) / m_physScale);
				var torso1:b2Body = m_world.CreateBody(bd);
				torso1.CreateFixture(fixtureDef);
				// Torso2
				box = new b2PolygonShape();
				box.SetAsBox(15 / m_physScale, 10 / m_physScale);
				fixtureDef.shape = box;
				bd.position.Set(startX / m_physScale, (startY + 43) / m_physScale);
				var torso2:b2Body = m_world.CreateBody(bd);
				torso2.CreateFixture(fixtureDef);
				// Torso3
				box.SetAsBox(15 / m_physScale, 10 / m_physScale);
				fixtureDef.shape = box;
				bd.position.Set(startX / m_physScale, (startY + 58) / m_physScale);
				var torso3:b2Body = m_world.CreateBody(bd);
				torso3.CreateFixture(fixtureDef);
				
				// UpperArm
				fixtureDef.density = 1.0;
				fixtureDef.friction = 0.4;
				fixtureDef.restitution = 0.1;
				// L
				box = new b2PolygonShape();
				box.SetAsBox(18 / m_physScale, 6.5 / m_physScale);
				fixtureDef.shape = box;
				bd.position.Set((startX - 30) / m_physScale, (startY + 20) / m_physScale);
				var upperArmL:b2Body = m_world.CreateBody(bd);
				upperArmL.CreateFixture(fixtureDef);
				// R
				box = new b2PolygonShape();
				box.SetAsBox(18 / m_physScale, 6.5 / m_physScale);
				fixtureDef.shape = box;
				bd.position.Set((startX + 30) / m_physScale, (startY + 20) / m_physScale);
				var upperArmR:b2Body = m_world.CreateBody(bd);
				upperArmR.CreateFixture(fixtureDef);
				
				// LowerArm
				fixtureDef.density = 1.0;
				fixtureDef.friction = 0.4;
				fixtureDef.restitution = 0.1;
				// L
				box = new b2PolygonShape();
				box.SetAsBox(17 / m_physScale, 6 / m_physScale);
				fixtureDef.shape = box;
				bd.position.Set((startX - 57) / m_physScale, (startY + 20) / m_physScale);
				var lowerArmL:b2Body = m_world.CreateBody(bd);
				lowerArmL.CreateFixture(fixtureDef);
				// R
				box = new b2PolygonShape();
				box.SetAsBox(17 / m_physScale, 6 / m_physScale);
				fixtureDef.shape = box;
				bd.position.Set((startX + 57) / m_physScale, (startY + 20) / m_physScale);
				var lowerArmR:b2Body = m_world.CreateBody(bd);
				lowerArmR.CreateFixture(fixtureDef);
				
				// UpperLeg
				fixtureDef.density = 1.0;
				fixtureDef.friction = 0.4;
				fixtureDef.restitution = 0.1;
				// L
				box = new b2PolygonShape();
				box.SetAsBox(7.5 / m_physScale, 22 / m_physScale);
				fixtureDef.shape = box;
				bd.position.Set((startX - 10) / m_physScale, (startY + 85) / m_physScale);
				var upperLegL:b2Body = m_world.CreateBody(bd);
				upperLegL.CreateFixture(fixtureDef);
				// R
				box = new b2PolygonShape();
				box.SetAsBox(7.5 / m_physScale, 22 / m_physScale);
				fixtureDef.shape = box;
				bd.position.Set((startX + 10) / m_physScale, (startY + 85) / m_physScale);
				var upperLegR:b2Body = m_world.CreateBody(bd);
				upperLegR.CreateFixture(fixtureDef);
				
				// LowerLeg
				fixtureDef.density = 1.0;
				fixtureDef.friction = 0.4;
				fixtureDef.restitution = 0.1;
				// L
				box = new b2PolygonShape();
				box.SetAsBox(6 / m_physScale, 20 / m_physScale);
				fixtureDef.shape = box;
				bd.position.Set((startX - 10) / m_physScale, (startY + 120) / m_physScale);
				var lowerLegL:b2Body = m_world.CreateBody(bd);
				lowerLegL.CreateFixture(fixtureDef);
				// R
				box = new b2PolygonShape();
				box.SetAsBox(6 / m_physScale, 20 / m_physScale);
				fixtureDef.shape = box;
				bd.position.Set((startX + 10) / m_physScale, (startY + 120) / m_physScale);
				var lowerLegR:b2Body = m_world.CreateBody(bd);
				lowerLegR.CreateFixture(fixtureDef);
				
				
				// JOINTS
				jd.enableLimit = true;
				
				// Head to shoulders
				jd.lowerAngle = -40 / (180/Math.PI);
				jd.upperAngle = 40 / (180/Math.PI);
				jd.Initialize(torso1, head, new b2Vec2(startX / m_physScale, (startY + 15) / m_physScale));
				m_world.CreateJoint(jd);
				
				// Upper arm to shoulders
				// L
				jd.lowerAngle = -85 / (180/Math.PI);
				jd.upperAngle = 130 / (180/Math.PI);
				jd.Initialize(torso1, upperArmL, new b2Vec2((startX - 18) / m_physScale, (startY + 20) / m_physScale));
				m_world.CreateJoint(jd);
				// R
				jd.lowerAngle = -130 / (180/Math.PI);
				jd.upperAngle = 85 / (180/Math.PI);
				jd.Initialize(torso1, upperArmR, new b2Vec2((startX + 18) / m_physScale, (startY + 20) / m_physScale));
				m_world.CreateJoint(jd);
				
				// Lower arm to upper arm
				// L
				jd.lowerAngle = -130 / (180/Math.PI);
				jd.upperAngle = 10 / (180/Math.PI);
				jd.Initialize(upperArmL, lowerArmL, new b2Vec2((startX - 45) / m_physScale, (startY + 20) / m_physScale));
				m_world.CreateJoint(jd);
				// R
				jd.lowerAngle = -10 / (180/Math.PI);
				jd.upperAngle = 130 / (180/Math.PI);
				jd.Initialize(upperArmR, lowerArmR, new b2Vec2((startX + 45) / m_physScale, (startY + 20) / m_physScale));
				m_world.CreateJoint(jd);
				
				// Shoulders/stomach
				jd.lowerAngle = -15 / (180/Math.PI);
				jd.upperAngle = 15 / (180/Math.PI);
				jd.Initialize(torso1, torso2, new b2Vec2(startX / m_physScale, (startY + 35) / m_physScale));
				m_world.CreateJoint(jd);
				// Stomach/hips
				jd.Initialize(torso2, torso3, new b2Vec2(startX / m_physScale, (startY + 50) / m_physScale));
				m_world.CreateJoint(jd);
				
				// Torso to upper leg
				// L
				jd.lowerAngle = -25 / (180/Math.PI);
				jd.upperAngle = 45 / (180/Math.PI);
				jd.Initialize(torso3, upperLegL, new b2Vec2((startX - 8) / m_physScale, (startY + 72) / m_physScale));
				m_world.CreateJoint(jd);
				// R
				jd.lowerAngle = -45 / (180/Math.PI);
				jd.upperAngle = 25 / (180/Math.PI);
				jd.Initialize(torso3, upperLegR, new b2Vec2((startX + 8) / m_physScale, (startY + 72) / m_physScale));
				m_world.CreateJoint(jd);
				
				// Upper leg to lower leg
				// L
				jd.lowerAngle = -25 / (180/Math.PI);
				jd.upperAngle = 115 / (180/Math.PI);
				jd.Initialize(upperLegL, lowerLegL, new b2Vec2((startX - 8) / m_physScale, (startY + 105) / m_physScale));
				m_world.CreateJoint(jd);
				// R
				jd.lowerAngle = -115 / (180/Math.PI);
				jd.upperAngle = 25 / (180/Math.PI);
				jd.Initialize(upperLegR, lowerLegR, new b2Vec2((startX + 8) / m_physScale, (startY + 105) / m_physScale));
				m_world.CreateJoint(jd);
				
			}
			
			m_world.SetContactListener(new ContactListener(this));
			
			for (i = 0; i < bloodImages.length; i++) {
				bloodImages[i] = new Image(particleGfx);
				bloodImages[i].color = 0xFF0000;
				bloodImages[i].alpha = 0.2 * (bloodImages.length - i) / Number(bloodImages.length);
				//bloodImages[i].scale = (bloodImages.length - i) / Number(bloodImages.length);
				bloodImages[i].x = bloodImages[i].y = -bloodImages[i].width * 0.5;
			}
		}
		
		public var timer:int = 60;
		
		public var dead:Boolean = false;
		
		public override function Update():void {
			if (dead) {
				text.text = swordCount + "\nR to retry";
				m_world.DrawDebugData();
				return;
			}
			
			super.Update();
			
			if (timer < 0){
				addSword();
				
				timer = 45 + Math.random()*30;
			}
			
			timer--;
			
			
			bloodBuffer.fillRect(bloodBuffer.rect, 0);
			
			for (var i:int = 0; i < 4; i++) {
				bloodFirst = Particle.create(bloodFirst, 150, 150);
				bloodFirst.dx = Math.random()*2-1;
				bloodFirst.dy = Math.random()*2-1;
			}
			
			var p:Particle;
			
			p = bloodFirst;
			while(p) {
				p.age += 1;
				
				p.x += p.dx;
				p.y += p.dy;
				
				if (p.x < -10 || p.x > 310 || p.y < -10 || p.y > 310 || p.age > 199) {
					var next: Particle = p.next;
					
					if (p == bloodFirst) {
						bloodFirst = next;
					}
					
					{
						if (p.previous)
							p.previous.next = p.next;
						
						if (p.next)
							p.next.previous = p.previous;
						
						p.next = Particle.recycleFirst;
						Particle.recycleFirst = p;
						
						p.previous = null;
					}
					
					//Particle.recycle(p);
					
					p = next;
					continue;
				}
				
				//if (p.x < 0 || p.x > 640) { continue; }
				
				/*if (p.y < 240-h[int(p.x*0.1)]) {
					p.dy += 0.5;
				} else {
					p.dx *= 1.0 - Math.min(0.9, 0.01*p.dx*p.dx)*Math.random();
					p.dy *= 1.0 - Math.min(0.9, 0.01*p.dy*p.dy)*Math.random();
				}*/
				
				FP.point.x = p.x //+ waterImage.x;
				FP.point.y = p.y //+ waterImage.y;
				
				//bloodImages[int(p.age / 25)].render(FP.point, FP.camera);
				
				bloodBuffer.copyPixels(bloodImages[int(p.age / 25)]._buffer, bloodImages[int(p.age / 25)]._bufferRect, FP.point, null, null, true);
				
				p = p.next;
			}
		}
		
		public function addSword():void {
			var bd:b2BodyDef;
			var body:b2Body;
			
			bd = new b2BodyDef();
			bd.type = b2Body.b2_kinematicBody;
			
			var i:int = Math.random() * 4;
			
			var p:Number = Math.random() * 8 + 1;
			
			var angle:Number  = 0;
			
			switch (i) {
				case 0: bd.position.Set(0.0, p); break;
				case 1: bd.position.Set(p, 0.0); break;
				case 2: bd.position.Set(10.0, p); break;
				case 3: bd.position.Set(p, 10.0); break;
			}
			
			angle += Math.PI*0.5*i;
			angle += (Math.random() - 0.5);
			
			body = m_world.CreateBody(bd);
			
			var length:Number = 1 + Math.random()*3;
			
			//var polygon:b2PolygonShape = b2PolygonShape.AsOrientedBox(length, 0.1, new b2Vec2(), angle);
			var A:b2Mat22 = b2Mat22.FromAngle(angle);
			
			function v(x:Number, y:Number):b2Vec2{
				return new b2Vec2(A.col1.x * x + A.col2.x * y, A.col1.y * x + A.col2.y * y);
			}
			
			var verts:Array = [v(-length, -0.2), v(length-0.4, -0.2), v(length, 0), v(length-0.4, 0.2), v(-length, 0.2)];
			
			var polygon:b2PolygonShape = b2PolygonShape.AsArray(verts, verts.length);
			var filter:b2FilterData = new b2FilterData;
			filter.categoryBits = 0x0002;
			filter.maskBits = 0x0001;
			filter.groupIndex = -1;
			var fixture:b2Fixture = body.CreateFixture2(polygon);
			fixture.SetFilterData(filter);
			
			TweenLite.delayedCall(4, function ():void {
				if (dead) return;
				m_world.DestroyBody(body);
				
				bd.type = b2Body.b2_staticBody;
				
				var to:b2Vec2 = bd.position.Copy();
				bd.position.x -= Math.cos(angle) * (length + 1);
				bd.position.y -= Math.sin(angle) * (length + 1);
				
				body = m_world.CreateBody(bd);
			
				var fixture:b2Fixture = body.CreateFixture2(polygon);
				
				swords.push(fixture);
				swordCount++;
				
				var t:Object = {p: 0};
				
				var p:b2Vec2 = new b2Vec2;
				var from:b2Vec2 = bd.position.Copy();
				
				function update ():void {
					if (dead) return;
					p.x = from.x + t.p * (to.x - from.x);
					p.y = from.y + t.p * (to.y - from.y);
					body.SetPosition(p);
				}
				
				TweenLite.to(t, 0.5, {p: 1, ease: Quad.easeIn, onUpdate: update, onComplete: function ():void {
					if (dead) return;
					TweenLite.to(t, 2, {p: 0, ease: Quad.easeOut, delay: 10, onUpdate: update, onComplete: function ():void {
						if (dead) return;
						remove(swords, fixture);
						m_world.DestroyBody(body);
					}});
				}});
			});
		}
		
		public static function remove(array:*, toRemove:*):Boolean
		{
			var i:int = array.indexOf(toRemove);
			
			if (i >= 0) {
				array.splice(i, 1);
			
				return true;
			} else {
				return false;
			}
		}
		
		public var swords:Array = [];
		public var swordCount:int = 0;
	}
	
}


import Box2D.Dynamics.*;
import Box2D.Collision.*;
import Box2D.Collision.Shapes.*;
import Box2D.Dynamics.Joints.*;
import Box2D.Dynamics.Contacts.*;
import Box2D.Common.*;
import Box2D.Common.Math.*;

class ContactListener extends b2ContactListener
{
	private var test:Game;
	public function ContactListener(test:Game)
	{
		this.test = test;
	}
	override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void 
	{
		var fixtureA:b2Fixture = contact.GetFixtureA();
		var fixtureB:b2Fixture = contact.GetFixtureB();

		var swords:Array = test.swords;
		
		if (swords.indexOf(fixtureA) == -1 && swords.indexOf(fixtureB) == -1) {
			return;
		}
			

		var manifold:b2WorldManifold = new b2WorldManifold();
		contact.GetWorldManifold(manifold);
		
		var n1:b2Vec2 = manifold.m_normal.Copy();
		var n2:b2Vec2 = manifold.m_normal.Copy();
		
		n1.Multiply(-20);
		n2.Multiply(20);
		
		fixtureA.GetBody().ApplyImpulse(n1, manifold.m_points[0]);
		fixtureB.GetBody().ApplyImpulse(n2, manifold.m_points[0]);
	
		
		if (test.m_mouseJoint) {
			test.m_world.DestroyJoint(test.m_mouseJoint);
			test.m_mouseJoint = null;
			test.m_mouseAllowed = false;
		}
	
		
		test.dead = true;
	}
}
