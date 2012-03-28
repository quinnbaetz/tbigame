(function(){
	var pRazor = addImage("razorArm", 0, stage.height);
	
	toolbox.bringForward();
	
	var mousePos = {x:WIDTH, y:HEIGHT};
	
	var cleanup = function(){
		remove(pScalp);
		remove(pHair);
		remove(pRazor);
	}
	
	
	var getMousePos = function(){
		mousePos.x = mouseX;
		mousePos.y = mouseY;
	}
	var drawTimerFunc = function(){
		var lastLeft ={"x" : pRazor.x, "y": pRazor.y+80};
		var lastRight = {"x" : pRazor.x+20, "y": pRazor.y};
		var lastX=0;
		var lastY=0;
		var tweenX = null;
		var tweenY = null;
		return function(){
			
			var mousex = mousePos.x;
			var mousey = mousePos.y;
			var doDraw = false;
			if(lastX != mousex){
				if(tweenX != null){
					tweenX.stop();
				}
				tweenX = createTween(pRazor, "x", None.easeNone, mousex-40);
				lastX = mousex;
				doDraw = true;
			}
			if(lastY != mousey){
				if(tweenY != null){
					tweenY.stop();
				}
				tweenY = createTween(pRazor, "y", None.easeNone, mousey-80);
				lastY = mousey;
				doDraw = true;
			}
			
			
			if(doDraw){
				var xdist = 60;
				var ydist = 80;
				var tempLeft = {"x" : pRazor.x, "y": pRazor.y+125};
				var tempRight = {"x" : tempLeft.x+xdist, "y": tempLeft.y-ydist};
				
				var points = new Vector.<Number>();
				maskObj.graphics.beginFill(0x00000000);
				
				if(tempLeft.x<=lastLeft.x){
					lastLeft = tempLeft;
					lastRight = tempRight;
					return;
				}
				
				points.push(tempLeft.x, tempLeft.y);
				points.push(tempRight.x, tempRight.y);
				points.push(lastRight.x, lastRight.y);
				points.push(lastLeft.x, lastLeft.y);
				points.push(tempLeft.x, tempLeft.y);
					
				/*if(tempLeft.y>lastLeft.y){
					points.push(tempLeft.x, tempLeft.y);
				}else{
					points.push(lastLeft.x, lastLeft.y);
				}
				if(tempRight.y>lastRight.y){
					points.push(tempRight.x, tempRight.y);
					points.push(lastRight.x, lastRight.y);
				}else{
					points.push(lastRight.x, lastRight.y);
					points.push(tempRight.x, tempRight.y);
				}
				if(tempLeft.y>lastLeft.y){
					points.push(lastLeft.x, lastLeft.y);
					points.push(tempLeft.x, tempLeft.y);
				}else{
					points.push(tempLeft.x, tempLeft.y);
					points.push(lastLeft.x, lastLeft.y);
				}*/
				
				
				
				maskObj.graphics.drawPath(Vector.<int>([1,2,2,2,2]), points, GraphicsPathWinding.NON_ZERO);
				
				maskObj.graphics.endFill();
				//maskObj.graphics.drawRect(lastLeft.x, lastLeft.y, (tempRight.x-lastLeft.x), (tempRight.y-lastLeft.y));
				pScalp.mask = maskObj;
				lastLeft = tempLeft;
				lastRight = tempRight;
			}
			
			
		}
	}
	
	var checkDrawFunc = function(callback){
		return function(){
			trace("checkdraw");
			var count = 0;
			//steps over 20 px intervals making sure we've covered enough
			//in a traingle patter
			
			for(var yval = 170; yval<490; yval+=20){
				for(var xval = 530-(yval-170); xval<530; xval+=20){
					var point:Point = new Point(xval, yval);
					if (!pScalp.hitTestPoint(point.x, point.y, true)){
						count++;
						if(count>2){
							return;
						}
					}
				}
			}
			callback();
		}	
	}
	
	var fadeRemainingHair = function(callback){
		var tweens = new Array();
		var waiter = null;
		tweens.push(createTween(pRazor, "y", None.easeNone, HEIGHT));
		tweens.push(createTween(pHair, "alpha", None.easeInOut, 0, -1, 50));
		tweens.push(createTween(pScalp, "alpha", None.easeInOut, 1, -1, 50, function(){
			waiter.kill();
			callback();
		}));
		
		waiter = waitOnUser(function(){
			for(var i in tweens){
				tweens[i].fforward();
				tweens[i] = null;
			}
			tweens = null;
		});
		
	}
	
	var mousex=0;
	var mousey=0;
	
	stage.addEventListener(MouseEvent.MOUSE_MOVE, getMousePos);
	var shaver = timer(25, drawTimerFunc(), 0);
	var checkDraw = timer(500, checkDrawFunc(function(){
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, getMousePos);
			shaver.stop(); 
			shaver=null;
			
			checkDraw.stop(); 
			checkDraw = null;
			fadeRemainingHair(function(){
				cleanup();
				//hack to get it to redo the surgerypatient code
				lastFrame = -1;
				gotoAndStop("Scene_SurgeryPatient");
			});
	}), 0);
})();