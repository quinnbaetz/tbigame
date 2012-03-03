package tbigame.scripts{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import fl.transitions.Tween;
		import fl.transitions.easing.*;
		import fl.transitions.TweenEvent;
		
		
	public class Clock extends MovieClip
	{
		
		private function setProps(obj:Object, ...args):void{
			if(args.length%2==1)
				 throw new Error();
			for(var i = 0; i<args.length; i+=2){
				obj[args[i]] = args[i+1];
			}
		}
		var angle = 360;
		var theStage = null;
		var clockHand = null;
		var clockBack;
		var listener = null;
		
		public function myAddEventListener(listener, callback){
			clockHand.addEventListener(listener, callback);
			clockBack.addEventListener(listener, callback);
		
		}
		function Clock(theStage, xLoc=0, yLoc=0){
			
			
			clockBack = new ClockBack();
			clockHand = new ClockHand();
			clockBack.buttonMode = true;
			clockBack.useHandCursor = true;
			clockHand.buttonMode = true;
			clockHand.useHandCursor = true;
			setProps(clockHand, "x", xLoc,
					 			 "y", yLoc);
			setProps(clockBack, "x", xLoc,
					 			 "y", yLoc);
			theStage.addChild(clockBack);
			theStage.addChild(clockHand);
			
			this.theStage = theStage;
		}
		
		public function hide(){
			clockBack.alpha = 0;
			clockHand.alpha = 0;
			clockBack.buttonMode = false;
			clockBack.useHandCursor = false;
			clockHand.buttonMode = false;
			clockHand.useHandCursor = false;
		}
		public function show(){
			clockBack.alpha = 1;
			clockHand.alpha = 1;
			clockBack.buttonMode = true;
			clockBack.useHandCursor = true;
			clockHand.buttonMode = true;
			clockHand.useHandCursor = true;
		}
		public function reduceAngle(angle){
			var oldAngle = this.angle;
			createTween(clockHand, "alpha", None.easeInOut, 0, -1, 30, function(){
				updateAngle(oldAngle-angle);
				createTween(clockHand, "alpha", None.easeInOut, 1, -1, 30);
			});
			
		
		}
		public function updateAngle(angle){
			this.angle = angle;
			if(listener!=null){
				theStage.removeEventListener(Event.ENTER_FRAME, listener);
			}
			listener = function(){
				theStage.setChildIndex(theStage.getChildByName(clockBack.name), theStage.numChildren-2);
				theStage.setChildIndex(theStage.getChildByName(clockHand.name), theStage.numChildren-1);
				drawSlice(angle);
			}
			theStage.addEventListener(Event.ENTER_FRAME, listener);
			listener();
		}
		
		public function drawSlice(angle){
			var startAngle = 90;
			var graphics = clockHand.graphics;
		 	graphics.clear();
			graphics.beginFill(0x69c2e5);
            var x = clockHand.width/2;
			var y= clockHand.height/2+10;
			var radius = 25;
            // based on mc.drawWedge() - by Ric Ewing (ric@formequalsfunction.com) - version 1.3 - 6.12.2002
            // adapted for AS3 Juan Ospina (piterwilson@gmail.com) - version 1.0 - 22.8.2008
            var segAngle, theta, radangle, angleMid, segs, ax, ay, bx, by, cx, cy;
	       graphics.moveTo(x, y);
	       // Flash uses 8 segments per circle, to match that, we draw in a maximum
	       // of 45 degree segments. First we calculate how many segments are needed
	       // for our _arc.
	       segs = Math.ceil(Math.abs(angle)/45);
	       // Now calculate the sweep of each segment.
	       segAngle = angle/segs;
	       // The math requires radians rather than degrees. To convert from degrees
	       // use the formula (degrees/180)*Math.PI to get radians.
		   theta = -(segAngle/180)*Math.PI;
		   
	       // convert angle _startAngle to radians
	       radangle = -(startAngle/180)*Math.PI;
		
	       // draw the curve in segments no larger than 45 degrees.
	       if (segs>0) {
		      ax = Math.cos(startAngle/180*Math.PI)*radius;
		      ay = Math.sin(-startAngle/180*Math.PI)*radius;
			  
		      graphics.lineTo(x+ax, y+ay);
		      for (var i:int = 0; i<segs; i++) {
			     radangle += theta;
			     angleMid = radangle-(theta/2);
			     bx = Math.cos(radangle)*radius;
			     by = Math.sin(radangle)*radius;
			     cx = Math.cos(angleMid)*(radius/Math.cos(theta/2));
			     cy = Math.sin(angleMid)*(radius/Math.cos(theta/2));
				graphics.curveTo(x+cx, y+cy, x+bx, y+by);
		      }
		  graphics.lineTo(x, y);	      }
		}
		
		var tweens:Array = new Array();
		private function createTween(obj:Object, prop:String, type, endVal:int, startVal:int = -1, numFrames = 10, callBack:Function = null, useTime:Boolean = false):Tween{
			if(startVal == -1)
				startVal = obj[prop];
			
			var tempTween:Tween = new Tween(obj, prop, type, startVal, endVal, numFrames, useTime);
			tweens.push(tempTween);
			tempTween.addEventListener(TweenEvent.MOTION_FINISH, tweenEnd);
			
			function tweenEnd(e:TweenEvent):void{
				tempTween.removeEventListener(TweenEvent.MOTION_FINISH, tweenEnd);
				tweens.splice(tweens.indexOf(e.target), 1);
				obj[prop] = endVal;
				if(callBack!=null)
					callBack(e);
			
			}
			
			return tempTween;
		}
	}
}