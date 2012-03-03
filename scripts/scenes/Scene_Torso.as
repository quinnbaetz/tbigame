import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.MouseEvent;

trace("---", timeline);
switch(timeline){
	case 3:
		trace("about to do stethascope animation");
		var msgAir;
		var img = addImage("stethoscopeCheck", 75, stage.height);
		toolbox.bringForward();
		var tweenX;
		var tweenY;
		var tweens = new Array();
		var wrongMsg;
		var delayTimer;
		Mouse.cursor="button";
		var onMove = function(){
			if(tweenX != null){
				tweenX.stop();
				tweenY.stop();
			}
			tweenX = createTween(img, "x", None.easeInOut, mouseX-210);
			tweenY = createTween(img, "y", None.easeInOut, Math.max(40,mouseY-50));
		};
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		stage.addEventListener(MouseEvent.CLICK, function(){
			 if(wrongMsg != null){
				wrongMsg.remove();
			 	wrongMsg = null;
			 }
			 if(delayTimer != null){
				delayTimer.stop();
				delayTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
				delayTimer = null;
				return;
			 }
			 while(tweens.length > 0){
				 var temp = tweens.pop();
				 temp.fforward();
				 if(tweens.length == 0){
					return;
				 }
			 }
			 if(mouseY<100 || mouseY>300 || mouseX < 270 || mouseX > 550){
				 wrongMsg = new Message(stage, 550, 220, "Make sure to place the stethoscope where we can clearly hear the patient’s lungs.", false, "emtFace");
				 return;
			 }
			 Mouse.cursor="auto";
			 stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
			 var tempFunc = arguments.callee;
			 var temp = createTween(img, "scaleY", None.easeInOut, .9, -1, 30);
			 tweens.push(temp);
			 temp = createTween(img, "scaleX", None.easeInOut, .9, -1, 30, function(){
			 	tweens = new Array();
				
				sounds['breath'] = playSound("sound_breath", 3);
				
				delayTimer = timer(8000, function(){
					 sounds['breath'].stop();
					 sounds['breath'] = null;
					 delayTimer = null;
					 msgAir = new Message(stage, 550, 220, "The airway sounds clear.", true);
					//toolbox.addNote("Breathing: Normal");
					toolbox.makeVisible("lungs");
					
					tween = createTween(img, "y", None.easeInOut, stage.height, -1, 100, function(){
						stage.removeEventListener(MouseEvent.CLICK, tempFunc);
						stage.addEventListener(MouseEvent.CLICK, function(){
							stage.removeEventListener(MouseEvent.CLICK, arguments.callee);
							msgAir.remove();
							remove(img);
							gotoAndStop("Scene_Heli2");
						});
					});
					tweens.push(tween);
					tweens.push(createTween(img, "scaleX", None.easeInOut, 1, -1, 50));
					tweens.push(createTween(img, "scaleY", None.easeInOut, 1, -1, 50));
				});
			});  
			tweens.push(temp);
							   
		});
		timeline++;
		break
	case 5:
		
		trace("about to do cuff animation");
		
		var firstRun = true;
		var skipAhead = function(){
			if(firstRun){
				firstRun = false;
				return;
			}
			if(pumpTimer != null){
				pumpTimer.stop();
				pumpTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE));
				pumpTimer = null;
				needle.rotation = -165;
				return
			}
			if(animationTimers.length>0){
				for each(var aTimer in animationTimers){
					if(aTimer  != null){
						aTimer.stop();
						aTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
						aTimer = null;
					}
				}
				animationTimers = new Array();
				return;
			}
			if(tweens.length>0){
				for each(var tween in tweens){
					if(tween != null){
						tween.fforward();
					}
				}
				tweens = new Array();
				return
			}
		}
		
		var cuff = null;
		
		for each(tool in toolbox.tools){
			if(tool.toolName == "cuff"){
				var cuffTool = tool.tool;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, function(){
					cuffTool.x = mouseX-cuffTool.parent.x;
					cuffTool.y = mouseY-cuffTool.parent.y-20;
					if(cuff != null){
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, arguments.callee);
						createTween(cuffTool, "x", Regular.easeInOut, 3);
						createTween(cuffTool, "y", Regular.easeInOut, 3);
					}
				});
			}
		}
		
		var pump = new handPump();
		var guage = new pumpGuage();
		var pumpingTimer = null;
		var pumpTimer = null;
		var animationTimers = new Array();
		var goDownTimer = null;	
		var tweens = new Array();
		var needle = guage.needle;
		var releasing = false;
		var armChoice = function(right){
			if(right){
				cuff = addImage("cuffedArmLeft", 0, 218);
			}else{
				cuff = addImage("cuffedArmRight", 568, 217);
			}
			pump.x = WIDTH - pump.width;
			pump.y = stage.height;
			pump.gotoAndStop("release");
			guage.x = 0;
			guage.y = stage.height;
			cuff.alpha = 0;
			stage.addChild(pump);
			stage.addChild(guage);
			toolbox.bringForward();
			var finished = false;
			
			var fixAudio = function(){
				var toUse = needle.rotation;
				if(needle.rotation < -100){
					toUse = 360+needle.rotation;
				}
				
				if(releasing){
					if(toUse< 70){
						var someTransform = new SoundTransform(2);
						sounds['heartBeat'].soundTransform = someTransform;
					}
				}else{
					if(toUse<100){
					toUse = 100
					}
					toUse -= 100;
					if(toUse > 100){
						toUse = 100;
					}
					
					var someTransform = new SoundTransform((1-(toUse/100))*4);
					sounds['heartBeat'].soundTransform = someTransform;
				}
			}
			var pumpUp = function(){
				needle.rotation += 1.1;
				fixAudio();
			}
			var goDown = function(){
				if(needle.rotation>=0 && needle.rotation<1){
					needle.rotation = 0;
				}else{
					var toUse = needle.rotation;
					if(needle.rotation < -100){
						toUse = 360+needle.rotation;
					}
					needle.rotation -= 1;//Math.max(1, (toUse/50));
				}
				fixAudio();
			}
			
			var pumpCuff = function(){
				pump.gotoAndStop("squeeze");
				pumpingTimer = timer(15, pumpUp, 10, false, function(){pump.gotoAndStop("release");});
			}
			
			var afterPump = function(){
				pumpTimer = null;
				var msg = "";
				//animationTimers[0] = timer(3000, function(){
					msg = new Message(stage, 550, 220, "His blood pressure is a little low we’ll keep an eye on it.", true);
					//toolbox.addNote("Blood Pressure: '90/60'");
					toolbox.makeVisible("bp");
				//});
				animationTimers[0] = timer(1500, function(){
					  animationTimers[0] = null;
					  tweens[0] = createTween(pump, "y", None.easeInOut, stage.height, -1, 80);
					  tweens[1] = createTween(guage, "y", None.easeInOut, stage.height, -1, 80, function(){
							  tweens = new Array();
							  tweenSound(sounds['heartBeat'], 0, 4, 40);
							  tweens[0] = createTween(cuff, "alpha", None.easeInOut, 0, -1, 40, function(){
									tweens = new Array();
							  		sounds['heartBeat'].stop();
									sounds['heartBeat'] = null;
									stage.removeEventListener(MouseEvent.CLICK, skipAhead);
									//goDownTimer.stop();
									//goDownTimer = null;
									stage.addEventListener(MouseEvent.CLICK, function(){
										stage.removeEventListener(MouseEvent.CLICK, arguments.callee);
										remove(cuff);
										remove(pump);
										remove(guage);
										msg.remove();
										gotoAndStop("Scene_Heli2");
									});
							  
							  });
					   });
				});
				finished=true;
			}
			stage.addEventListener(MouseEvent.CLICK, skipAhead);
			
			sounds['heartBeat'] = playSound("sound_heartbeat", int.MAX_VALUE);
			tweenSound(sounds['heartBeat'], 4, 0, 60);
			
			tweens[0] = createTween(cuff, "alpha", None.easeInOut, 1, -1, 60, function(){
				tweens[0] = createTween(pump, "y", None.easeInOut, 145, -1, 80);
				tweens[1] = createTween(guage, "y", None.easeInOut, 145, -1, 80, function(){
					var pumpRegion:ClickRegion = new ClickRegion(stage, 240, 60, 250, 250);
					var pumpMsg = new Message(stage, 50, 20, "Pump up the cuff until you can no longer hear a pulse.", false, "emtFace");
					
					pumpRegion.addEventListener(MouseEvent.MOUSE_DOWN, function(){
						pump.gotoAndStop("squeeze");
						 playSound("sound_squeezePump");
						//var pumpMsg = new Message(stage, 550, 220, "Pump up the cuff until you can\nno longer hear a pulse.", false);
						
						timer(15, pumpUp, 10, false, function(){
							if((needle.rotation > -160  && needle.rotation < -100) /*|| (DEBUG && needle.rotation > 80 && needle.rotation < 100)*/){
								if(goDownTimer !=null){
									goDownTimer.stop();
									pumpMsg.remove();
									goDownTimer = null;
									pumpRegion.remove();
									var releaseMsg = new Message(stage, 50, 20, "Now release the pressure until you can hear the pulse again.", false, "emtFace");
									releasing = true;
									var releaseRegion:ClickRegion = new ClickRegion(stage, 270, 200, 100, 50);
									sounds['releaseAir'] = new sound_releaseAir();
									var releaseChannel;
									var releasePosition = 0;
									releaseRegion.addEventListener(MouseEvent.MOUSE_DOWN, function(){
										releaseChannel = sounds['releaseAir'].play(releasePosition);
										goDownTimer = timer(20, function(){
											goDown();
											if(needle.rotation>60 && needle.rotation<70){
												if(goDownTimer != null){
													releaseMsg.remove();
													releaseChannel.stop();
													sounds['releaseAir'] = null;
													goDownTimer.stop();
													goDownTimer = null;
													firstRun = true;
													afterPump();
												}
											}
										}, 0);
									});
									releaseRegion.addEventListener(MouseEvent.MOUSE_UP, function(){
										releasePosition = releaseChannel.position;
										releaseChannel.stop();
										if(goDownTimer != null){
											goDownTimer.stop();
											goDownTimer = null;
										}
									});
									
								}
							}
							  
						});
					});
					pumpRegion.addEventListener(MouseEvent.MOUSE_UP, function(){
						playSound("sound_releasePump");
						pump.gotoAndStop("release");
					});
					
					//450 750
					//pumpTimer = timer(250, pumpCuff, 35, false, afterPump);
					
					
					
					goDownTimer = timer(50, goDown, 0);
				});
			});
			timeline++;
		};
		var leftArm:ClickRegion = new ClickRegion(stage, 40, 50, 200, 350, function(evt){
			leftArm.remove();
			rightArm.remove();
			armChoice(true);
		});
		var rightArm:ClickRegion = new ClickRegion(stage, 250, 50, 200, 350, function(evt){
			leftArm.remove();
			rightArm.remove();
			armChoice(false);		
		});
		//70 250     //100 450
		//550 750
		
		
		
		break
	case 7:
		var waitTime;
		var tween;
		var gauze = addImage("guaze", 457, 334);
		var maskObject:MovieClip = new MovieClip();
		maskObject.graphics.beginFill(0xFF0000);
		gauze.mask = maskObject;
		var msg = new Message(stage, 50, 20, "Don’t wrap the wound too tightly…", false, "emtFace");
								
		for each(tool in toolbox.tools){
			if(tool.toolName == "gauze"){
				var gauzeTool = tool.tool;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, function(){
					gauzeTool.x = mouseX-gauzeTool.parent.x;
					gauzeTool.y = mouseY-gauzeTool.parent.y-20;
					if(msg == null){
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, arguments.callee);
						createTween(gauzeTool, "x", Regular.easeInOut, 3);
						createTween(gauzeTool, "y", Regular.easeInOut, 3);
					}
				});
			}
		}
		
		toolbox.bringForward();
		forceToFront(gauzeTool)
		stage.addEventListener(MouseEvent.MOUSE_MOVE, function(){
			maskObject.graphics.drawCircle(mouseX, mouseY, 10);   
			gauze.mask = maskObject;
			//trace(mouseX, mouseY);
			var count = 0;
			//steps over 20 px intervals making sure we've covered enough
			for(var xval = 470; xval<600; xval+=20){
				for(var yval = 350; yval<400; yval+=20){
					//trace(maskObject.hitTestPoint(xval, yval, true));
					var point:Point = new Point(xval, yval);
					if (!gauze.hitTestPoint(point.x, point.y, true)){
						count++;
						if(count>2){
							return;
						}
					}
				}
			}
			//uncovered the whole thing!
			maskObject.graphics.drawCircle(WIDTH/2, HEIGHT/2, WIDTH);
			gauze.mask = maskObject;
			if(msg!=null){
				
				msg.remove();
				msg = null;
				var msg2 = new Message(stage, 50, 20, "That looks good", false, "emtFace");
				stage.addEventListener(MouseEvent.CLICK, function(){
					stage.removeEventListener(MouseEvent.CLICK, arguments.callee);
					remove(gauze);
					msg2.remove();
					msg2 = null;
					gotoAndStop("Scene_Heli2");
				});
			}
		});
		
	
		
		
		
		
		timeline++;
		break;
	
}