﻿import flash.display.MovieClip;import flash.geom.Point;(function(){ 	var mX = 350;	var mY = 183;	var duraOpenH =  addImage("duraOpenHealed", mX-55, mY-69);		var hematoma = new Hematoma();	hematoma.x = 424;	hematoma.y = 187;	stage.addChild(hematoma);	hematoma.stop();	 	var pIrrigationArm = addImage("irrigationArm", WIDTH, HEIGHT);	var pSuctionArm = addImage("suctionArm", -WIDTH, HEIGHT);		toolbox.bringForward();		var count = 2;		var sugeonDialogWrong = function(callback){		var messages = new Array("We want to disturb the brain as little as possible, stay focused on the hematoma");		var msgs = displayMessages(messages, null, null, callback, false, "surgeonFace");	}	createTween(pSuctionArm, "x", None.easeInOut, 200-pSuctionArm.width);	createTween(pSuctionArm, "y", None.easeInOut, HEIGHT-300);		var tweenX = null;	var tweenY = null;	var mousePos = {x: mouseX, y: mouseY};	var getMousePos = function(){		mousePos.x = mouseX;		mousePos.y = mouseY;	}		var removeArms = function(callback){		var tweens = new Array();		var waiter = null;				tweens.push(createTween(pIrrigationArm, "y", None.easeInOut, HEIGHT, -1, 40));		tweens.push(createTween(pSuctionArm, "y", None.easeInOut, HEIGHT, -1, 40, function(){			waiter.kill();			callback();		}));				waiter = waitOnUser(function(){			for(var i in tweens){				tweens[i].fforward();				tweens[i] = null;			}			tweens = null;		});			}		stage.addEventListener(MouseEvent.MOUSE_MOVE, getMousePos);	var phase = 0;	var clipHandMove = timer(25, function(){				var mousex = mousePos.x;		var mousey = mousePos.y;		if(tweenX != null){			tweenX.stop();		}		if(tweenY != null){			tweenY.stop();		}		if(phase == 0){			tweenX = createTween(pIrrigationArm, "x", None.easeInOut, mousex-5);			tweenY = createTween(pIrrigationArm, "y", None.easeInOut, mousey-163);		}else{			tweenX = createTween(pSuctionArm, "x", None.easeInOut, mousex-760);			tweenY = createTween(pSuctionArm, "y", None.easeInOut, mousey-160);		}	}, 0);			var talking = false;	stage.addEventListener(MouseEvent.CLICK,function(){			if(talking){				return;			}			var myFun = arguments.callee;			if(mouseX<550 && mouseX>430 && mouseY > 180 && mouseY < 350){				if(phase === 0){					phase = 1;					createTween(pIrrigationArm, "x", None.easeInOut, WIDTH-200);					createTween(pIrrigationArm, "y", None.easeInOut, HEIGHT-300);					hematoma.gotoAndStop(count++);				}else{					if(count<9){												stage.removeEventListener(MouseEvent.CLICK,arguments.callee);						var tween = createTween(hematoma.top, "alpha", None.easeInOut, 0, -1, 40, function(){							phase = 0;							stage.addEventListener(MouseEvent.CLICK,myFun);							createTween(pSuctionArm, "x", None.easeInOut, 200-pSuctionArm.width);							createTween(pSuctionArm, "y", None.easeInOut, HEIGHT-300);						});												stage.addEventListener(MouseEvent.CLICK,function(){							tween.fforward();							phase = 0;							stage.removeEventListener(MouseEvent.CLICK,arguments.callee);							stage.addEventListener(MouseEvent.CLICK,myFun);						});					}else{						createTween(hematoma, "alpha", None.easeInOut, 0, -1, 40, function(){							stage.removeEventListener(MouseEvent.CLICK,myFun);							if(clipHandMove){								clipHandMove.stop();								trace("hand stop moving");							}							clipHandMove = null;														tweenX.stop();							tweenY.stop();							stage.removeEventListener(MouseEvent.MOUSE_MOVE,getMousePos);							removeArms(function(){								remove(pSuctionArm);								remove(pIrrigationArm);								remove(hematoma);								remove(duraOpen);								lastFrame = -1;								remove(duraOpenH);								gotoAndStop("Scene_SurgeryPatient");							});						});					}									}			}else{				talking = true;				sugeonDialogWrong(function(){						talking = false;  				});			}	});					})();