import flash.display.MovieClip;
import flash.geom.Point;

(function(){
    var mX = 300;
	var mY = 150;
	var syringeMarks = new MovieClip();
	syringeMarks.x = 0;
	syringeMarks.y = 0;
	addChild(syringeMarks);
	syringeMarks.graphics.lineStyle(5, 0xFF0000);
	
	var pOutline =  addImage("markerOutline", mX-25, mY-25);
	pOutline.alpha = 0;
	var pSyringeArm = addImage("syringeArm", 0, stage.height);
	
	toolbox.bringForward();
		
	var mousePos = {x: WIDTH, y: HEIGHT};
	var surgeonDialog = function(callback){
		var messages = new Array("You need to make 5 injections total, space them out over the entire incision site.");
		displayMessages(messages, 50, 60, callback, false, "surgeonFace");
	};
	
	var surgeonDialogError = function(callback){
		var messages = new Array("Be careful where you inject the anesthetic, stay within the marked areas.");
		displayMessages(messages, 50, 60, callback, false, "surgeonFace");
	};
	
	var surgeonDialogFinished = function(callback){
		var messages;
		var failed = false;
		for(var pt1 in points){
			for(var pt2 in points){
				var dist = hypot(points[pt1].x-points[pt2].x,points[pt1].y-points[pt2].y);
				if(pt1 !== pt2 && dist<60){
					failed = true;
					clock.reduceAngle(20);
				}
			}
		}
		
		messages = new Array("The patient is ready for the first incision,",
								 "there should be a new set of tools for the next phase of surgery,",
								 "check the tray to make sure they are all ready.");
		if(failed){
			messages.unshift("Looks like you need some help with the injections,",
							 "I’ll finish up to make sure they are spread evenly.");
		}
		
		displayMessages(messages, 50, 60, callback, false, "surgeonFace");
	}
	
	var removeArm = function(callback){
		var tweens = new Array();
		var waiter = null;
		
		tweens.push(createTween(syringeMarks, "alpha", None.easeInOut, 0, -1, 40));
		tweens.push(createTween(pSyringeArm, "y", None.easeInOut, HEIGHT, -1, 40, function(){
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
	
	var withinBounds = function(x, y){
		//return pOutline.hitTestPoint(x, y, true);
		var bmapData:BitmapData = new BitmapData(pOutline.width, pOutline.height, true, 0x00000000);
		bmapData.draw(pOutline, new Matrix());
		var point = new Point(x,y);
		var returnVal:Boolean = bmapData.hitTest(new Point(0,0), 0, pOutline.globalToLocal(point));
		bmapData.dispose();
		return returnVal;
	}
	
	var task = 0;
	var tweenX = null;
	var tweenY = null;
	var points = new Array();
	var getMousePos = function(){
		mousePos.x = mouseX;
		mousePos.y = mouseY;
	}
	
	stage.addEventListener(MouseEvent.MOUSE_MOVE, getMousePos);
	surgeonDialog(function(){
		var firstLoss = true;
		var talking = false;
		var firstHack = true;
		var syringeMove = timer(25, function(){
			var mousex = mousePos.x;
			var mousey = mousePos.y;
			if(tweenX != null){
				tweenX.stop();
			}
			tweenX = createTween(pSyringeArm, "x", None.easeNone, mousex);
			
			if(tweenY != null){
				tweenY.stop();
			}
			tweenY = createTween(pSyringeArm, "y", None.easeNone, mousey-350);
		}, 0);
		stage.addEventListener(MouseEvent.CLICK,function(){
			if(talking || firstHack){
				firstHack = false;
				return;
			}
			if(withinBounds(pSyringeArm.x,(pSyringeArm.y+350))){
				syringeMarks.graphics.drawCircle(pSyringeArm.x,(pSyringeArm.y+350), 2);
				points.push({x:pSyringeArm.x,y:pSyringeArm.y+350});
				if(points.length<5){
					return;
				}
				syringeMove.stop();
				syringeMove = null;
				stage.removeEventListener(MouseEvent.CLICK, arguments.callee);
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, getMousePos);
				talking = true;
				firstHack = true;
				surgeonDialogFinished(function(){
					talking = false;
					if(firstHack == false){
						//userLine.alpha = 0;
						gotoAndStop("Scene_SurgeryTray");
					}
				});
				
				removeArm(function(){
					remove(pOutline);
					remove(pSyringeArm);
					remove(syringeMarks);
					firstHack = false;
					if(talking == false){
						gotoAndStop("Scene_SurgeryTray");
					}
				});
			}else{
				talking = true;
				surgeonDialogError(function(){
					if(firstLoss){
						clock.reduceAngle(20);
						firstLoss = false;
					}
					talking = false;
					firstHack = true;
				});
			}
		});
		
	});
})();