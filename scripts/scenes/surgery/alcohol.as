(function(){
	var maskObj:MovieClip = new MovieClip();
	maskObj.graphics.beginFill(0x00000000);
	pScalp.mask = maskObj;
	
	toolbox.bringForward();
	
	var pSwab = addImage("swabArm", 0, stage.height);
	
	toolbox.bringForward();
		
	var mousePos = {x:WIDTH, y:HEIGHT};
	
	var cleanup = function(){
		remove(pScalp);
		remove(pSwab);
	}
	
	var getMousePos = function(){
		mousePos.x = mouseX;
		mousePos.y = mouseY;
	}
	var drawTimerFunc = function(){
		var tweenX = null;
		var tweenY = null;
		return function(){
			var mousex = mousePos.x;
			var mousey = mousePos.y;
			if(tweenX != null){
				tweenX.stop();
			}
			tweenX = createTween(pSwab, "x", None.easeNone, mousex-100);
			
			if(tweenY != null){
				tweenY.stop();
			}
			tweenY = createTween(pSwab, "y", None.easeNone, mousey-80);
				
			var swabPos ={"x" : mouseX, "y":mouseY};
			
			var rad = 80;
			if(DEBUG){
				rad = 100;
			}
			//need to update these graphics based o
			maskObj.graphics.drawCircle(pSwab.x+80, pSwab.y+85, rad);
			pScalp.mask = maskObj;
		}
	}
	
	var checkDrawFunc = function(callback){
		return function(){
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
	
	var fadeAlcohol = function(callback){
		var tweens = new Array();
		var waiter = null;
		
		maskObj.graphics.drawCircle(WIDTH/2, HEIGHT/2, WIDTH);
		pScalp.mask = maskObj;
		
		tweens.push(createTween(pSwab, "y", None.easeInOut, HEIGHT, -1, 100));
		tweens.push(createTween(pScalp, "alpha", None.easeInOut, 0, -1, 100, function(){
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
			fadeAlcohol(function(){
				cleanup();
				//hack to get it to redo the surgerypatient code
				lastFrame = -1;
				gotoAndStop("Scene_SurgeryPatient");
			});
	}), 0);
	
})();