import flash.display.MovieClip;
import flash.geom.Point;

(function(){
    var mX = 300;
	var mY = 150;
	var pOutline =  addImage("markerOutline", mX-10, mY-10);
	var pMarker =  addImage("markerDotted", mX, mY);
	var beginX = pOutline.x + mX-110;
	var beginY =  pOutline.y + mY-120
	var endX = pOutline.x + mX-280
	var endY = pOutline.y + mY+50
	var pMarkerArm = addImage("markerArm", 0, stage.height);
	
	toolbox.bringForward();
		
	pMarker.alpha = 0;
	pOutline.alpha = 0;
	createTween(pMarker, "alpha", None.easeInOut, .3, -1, 100)
	createTween(pOutline, "alpha", None.easeInOut, .7, -1, 100)
	var mousePos = {x: WIDTH, y: HEIGHT};
	var surgeonDialog = function(callback){
		var messages = new Array("Careful! There’s no room for error, make your incision marks as accurate as possible.");
		displayMessages(messages, 50, 60, callback, false, "surgeonFace");
	};
	
	var fadeLines = function(callback){
		var tweens = new Array();
		var waiter = null;
		
		tweens.push(createTween(pMarkerArm, "y", None.easeInOut, HEIGHT, -1, 100));
		//tweens.push(createTween(pOutline, "alpha", None.easeInOut, 0, -1, 100, function(){
		tweens.push(createTween(pMarker, "alpha", None.easeInOut, 0, -1, 100, function(){
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
	
	var createStartPoint = function(){
		var startPt = {};
		/*var startPt:MovieClip = new MovieClip();
		startPt.graphics.beginFill(0xAA00FF00)
		startPt.graphics.drawCircle(0,0, 15);
		startPt.graphics.endFill();*/
		startPt.x = beginX;
		startPt.y = beginY;
		//addChild(startPt);
		return startPt;
	};
	
	var createEndPoint = function(){
		var endPt = {};
		/*var endPt:MovieClip = new MovieClip();
		endPt.graphics.beginFill(0xAAFF0000)
		endPt.graphics.drawCircle(0, 0, 15);
		endPt.graphics.endFill();*/
		
		endPt.x = endX;
		endPt.y = endY;
		//addChild(endPt);
		return endPt;
	}
	var withinBounds = function(x, y){
		//return pOutline.hitTestPoint(x, y, true);
		var bmapData:BitmapData = new BitmapData(pOutline.width, pOutline.height, true, 0x00000000);
		bmapData.draw(pOutline, new Matrix());
		var point = new Point(x,y);
		var returnVal:Boolean = bmapData.hitTest(new Point(0,0), 0, pOutline.globalToLocal(point));
		bmapData.dispose();
		return returnVal;
	}
	
	var startPt = createStartPoint();
	var endPt = createEndPoint();
	var lastPt = {};
	var task = 0;
	var tweenX = null;
	var tweenY = null;
	var startingPt;
	userLine = new MovieClip();
	userLine.x = 0;
	userLine.y = 0;
	addChild(userLine);
	
	var getMousePos = function(){
		mousePos.x = mouseX;
		mousePos.y = mouseY;
	}
	
	stage.addEventListener(MouseEvent.MOUSE_MOVE, getMousePos);
	
	var markerDraw = timer(25, function(){
		var mousex = mousePos.x;
		var mousey = mousePos.y;
		if(tweenX != null){
			tweenX.stop();
		}
		tweenX = createTween(pMarkerArm, "x", None.easeNone, mousex);
		
		if(tweenY != null){
			tweenY.stop();
		}
		tweenY = createTween(pMarkerArm, "y", None.easeNone, mousey-30);
		var firstLoss = true;
		switch(task){
			case 0:
				
				//waiting for user to go to begining
				lastPt.x = pMarkerArm.x+10;
				lastPt.y = pMarkerArm.y+30;
				var dist1 = hypot((startPt.x)-lastPt.x, (startPt.y)-(lastPt.y));
				var dist2 = hypot((endPt.x)-lastPt.x, (endPt.y)-(lastPt.y));
				if((dist1<15 || dist2<15) && withinBounds(lastPt.x, (lastPt.y))){
					if(dist1<15){
						startingPt = true;
					}else{
						startingPt = false;
					}
					//remove(startPt);
					task=1;
					userLine.graphics.lineStyle(10, 0x0000FF);
					userLine.graphics.moveTo(pMarkerArm.x+10, (pMarkerArm.y+30));
				}   
			break;
			case 1:
				if(withinBounds(pMarkerArm.x+10,(pMarkerArm.y+30))){
				   lastPt.x = pMarkerArm.x+10;
				   lastPt.y = pMarkerArm.y+30;
				   userLine.graphics.lineTo(lastPt.x, lastPt.y);
				   var dist;
				   if(startingPt === true){
					   dist = hypot((endPt.x)-lastPt.x, (endPt.y)-(lastPt.y));
				   }else{
					   dist = hypot((startPt.x)-lastPt.x, (startPt.y)-(lastPt.y));
				   }
				   if(dist<15){
						task=-1;
						markerDraw.stop();
						markerDraw = null;
						stage.removeEventListener(MouseEvent.MOUSE_MOVE,getMousePos);
						fadeLines(function(){
							remove(pMarker);
							remove(pOutline);
							remove(pMarkerArm);
							lastFrame = -1;
							gotoAndStop("Scene_SurgeryPatient");
						});
					}   
				}else{
					task = -1;
					surgeonDialog(function(){
						if(firstLoss){
							clock.reduceAngle(20);
							firstLoss = false;
						}
						//userLine.graphics.clear();
						task=0;
						if(startingPt === true){
							startPt.x = lastPt.x; 
							startPt.y = lastPt.y; 
						}else{
							endPt.x = lastPt.x; 
							endPt.y = lastPt.y;
						}
					});
				}
			
			break;
			
		}
		
	}, 0);
	
})();