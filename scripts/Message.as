﻿package tbigame.scripts {	import flash.display.MovieClip;	import fl.transitions.Tween;	import fl.transitions.easing.*;	import fl.transitions.TweenEvent;	import flash.text.TextField;	import flash.text.TextFormat;	import flash.text.TextFieldAutoSize;	import flash.display.Sprite;	import flash.display.Bitmap;	import flash.utils.getDefinitionByName;	import flash.filters.GlowFilter;	import flash.events.MouseEvent;	public class Message extends MovieClip	{				var theStage;		var msgBox;  		var speakerFace = false;		var speakerBorder = false;		var maskObject:MovieClip;		var textMsg:TextField;		var advImage;		var prevImage;		var advCallback;		var prevCallback;		var ignoreArrow;		var options = {};		/*		 * Displays a message		 * clouds/Options :				hideClose = false; //true doesn't show the close button on last frame		 */		function Message(myStage, x, y, str="", clouds=false, image=false, forward=null, backward=null, ignoreRightArrow=false){			if(typeof(x) !== "Number"){				x = 50;			}			if(typeof(y) !== "Number"){				y = 10;			}						if(typeof(clouds) === "object"){				options = clouds;			}			theStage = myStage;			advCallback = forward;			prevCallback = backward;			ignoreArrow = ignoreRightArrow;			//should add in word wrap			//create text			msgBox = new message();		    msgBox.stop();						if(image){				msgBox.gotoAndStop(2);								speakerFace = createImage(image, x+5, y+10, 110, 90);				//speakerBorder = new Canvas();				//speakerBorder.graphics.lineStyle(2, 0x2a3037);				//speakerBorder.graphics.beginFill(0x6b6c68, .8);								maskObject = new MovieClip();				maskObject.graphics.beginFill(0xFF0000);				maskObject.graphics.drawRoundRect(x+15, y+10, 90, 90, 25, 25);				//speakerBorder.graphics.drawRoundRect(x+23, y+3, 84, 64, 25, 25);				maskObject.graphics.endFill();				//speakerBorder.graphics.endFill();				speakerFace.mask = maskObject;							}						msgBox.next.visible = false;			advImage = msgBox.exit;								if(typeof advCallback === "function"){				if(!ignoreArrow){					msgBox.next.visible = true;					msgBox.exit.visible = false;					advImage = msgBox.next;				}			}						if(options.hideClose){				if(ignoreArrow){					advImage = false;				}				msgBox.exit.visible = false;			}						msgBox.prev.visible = false;			if(typeof prevCallback === "function"){				msgBox.prev.visible = true;				prevImage = msgBox.prev;			}										msgBox.x=x;			msgBox.y=y;			msgBox.text.text = str;						theStage.addChild(msgBox); 						if(speakerFace){				//theStage.addChild(speakerBorder);				theStage.addChild(maskObject);				theStage.addChild(speakerFace);			}			if(typeof advCallback === "function"){				if(advImage){					advImage.addEventListener(MouseEvent.MOUSE_DOWN, advCallback);				}								//dissabling click to advance per request				/*msgBox.addEventListener(MouseEvent.MOUSE_DOWN, advCallback);				textMsg.addEventListener(MouseEvent.MOUSE_DOWN, advCallback);								if(speakerFace){					speakerBorder.addEventListener(MouseEvent.MOUSE_DOWN, advCallback);					maskObject.addEventListener(MouseEvent.MOUSE_DOWN, advCallback);					speakerFace.addEventListener(MouseEvent.MOUSE_DOWN, advCallback);				}*/			}			if(typeof prevCallback === "function"){				prevImage.addEventListener(MouseEvent.MOUSE_DOWN, prevCallback);			}			this.theStage = theStage;		}				public function remove(){			if(typeof advCallback === "function"){				if(advImage){					advImage.removeEventListener(MouseEvent.MOUSE_DOWN, advCallback);				}				/*msgBox.removeEventListener(MouseEvent.MOUSE_DOWN, advCallback);				textMsg.removeEventListener(MouseEvent.MOUSE_DOWN, advCallback);				if(speakerFace){					speakerBorder.removeEventListener(MouseEvent.MOUSE_DOWN, advCallback);					maskObject.removeEventListener(MouseEvent.MOUSE_DOWN, advCallback);					speakerFace.removeEventListener(MouseEvent.MOUSE_DOWN, advCallback);				}*/			}			if(typeof prevCallback === "function"){				prevImage.removeEventListener(MouseEvent.MOUSE_DOWN, prevCallback);			}			theStage.removeChild(msgBox);			if(speakerFace){				theStage.removeChild(maskObject);				theStage.removeChild(speakerFace);				//theStage.removeChild(speakerBorder);								speakerFace = false;			}		}		public function bringForward(){			var myStage = theStage;			myStage.setChildIndex(myStage.getChildByName(msgBox.name), myStage.numChildren-1);			trace("here1");			if(speakerFace){				//theStage.addChild(speakerBorder);				myStage.setChildIndex(myStage.getChildByName(maskObject.name), myStage.numChildren-1);				trace("here2");				myStage.setChildIndex(myStage.getChildByName(speakerFace.name), myStage.numChildren-1);				trace("here3");			}		}				function createImage(className,x ,y, width, height){			var ClassReference:Class = getDefinitionByName(className) as Class;			var instance:* = new ClassReference();			var myImage:Bitmap = new Bitmap(instance);			var sprite:Sprite = new Sprite();			sprite.x = x;			sprite.y = y;			sprite.addChild(myImage);			sprite.width = width;			sprite.height = height;			return sprite;		}	}}