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

import Box2D.Dynamics.*
import Box2D.Collision.*
import Box2D.Collision.Shapes.*
import Box2D.Dynamics.Joints.*
import Box2D.Dynamics.Contacts.*
import Box2D.Common.Math.*
import flash.events.Event;
import flash.display.*;
import flash.text.*;
import General.*

import flash.display.MovieClip;
	[SWF(width='300', height='300', backgroundColor='#ededed', frameRate='30')]
	public class Main extends MovieClip{
		[Embed(source="images/bg.png")]
		public static var BG: Class;
		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		public function onStage(e:Event):void{
			sitelock(["draknek.org", "flashgamelicense.com"]);
			
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
			
			m_fpsCounter.x = 7;
			m_fpsCounter.y = 5;
			addChildAt(m_fpsCounter, 0);
			
			//addChild(new BG);
			
			var s:Sprite = new Sprite;
			s.graphics.beginFill(0xededed);
			s.graphics.drawRect(0, 0, 300, 300);
			
			addChild(s);
			
			m_sprite = new Sprite();
			addChild(m_sprite);
			// input
			m_input = new Input(m_sprite);
		}
		
		public function update(e:Event):void{
			// clear for rendering
			m_sprite.graphics.clear()
			
			if (Input.isKeyPressed(82)){ // R
				m_currTest = null
			}
			
			// if null, set new test
			if (!m_currTest){
				removeChildrenOf(m_sprite);
				m_currTest = new Game();
			}
			
			// update current test
			m_currTest.Update();
			
			// Update input (last)
			Input.update();
			
			// update counter and limit framerate
			m_fpsCounter.update();
			FRateLimiter.limitFrame(30);
			
		}
public function removeChildrenOf(mc:*):void{
	if(mc.numChildren!=0){
		var k:int = mc.numChildren;
		while( k -- )
		{
			mc.removeChildAt( k );
		}
	}
}
		
		public function sitelock (allowed:*):Boolean
		{
			var url:String = Preloader.stage.loaderInfo.url;
			var startCheck:int = url.indexOf('://' ) + 3;
			
			if (url.substr(0, startCheck) == 'file://') return true;
			
			var domainLen:int = url.indexOf('/', startCheck) - startCheck;
			var host:String = url.substr(startCheck, domainLen);
			
			if (allowed is String) allowed = [allowed];
			for each (var d:String in allowed)
			{
				if (host.substr(-d.length, d.length) == d) return true;
			}
			
			parent.removeChild(this);
			throw new Error("Error: this game is sitelocked");
			
			return false;
		}

		
		
		//======================
		// Member data
		//======================
		static public var m_fpsCounter:FpsCounter = new FpsCounter();
		public var m_currId:int = 0;
		static public var m_currTest:Test;
		static public var m_sprite:Sprite;
		// input
		public var m_input:Input;
	}
}
