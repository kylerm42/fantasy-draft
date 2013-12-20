﻿package com.flashspeaks.utils {	import com.flashspeaks.events.CountdownEvent;		import flash.events.EventDispatcher;	import flash.events.TimerEvent;	import flash.utils.Timer;		/**	 * ...	 * @author Angel Romero of Flash Speaks ActionScript Blog	 */		public class CountdownTimer extends EventDispatcher	{				// Private Properties:		private var _countdownTimer:Timer;				// Create your Timer object		private var _endDate:Date;						// Create your Date() object		private var _days:String;						// Stores the remaining days value		private var _hours:String;						// Stores the remaining hours value		private var _minutes:String;					// Stores the remaining minutes value		private var _seconds:String;					// Stores the remaining seconds value		private var _time:String;						// Stores the entire amount of time that is left separated by ":"				// Initialization:		public function CountdownTimer(targetDate:Date) 		{ 			// DEFINE the new timer instance			 _countdownTimer = new Timer(1000);			// SET the target end date			_endDate = targetDate;						// SETUP up any of the object's event listeners			setupListeners();						//Initializing timer object			_countdownTimer.start();		}				/***** Public Methods: *****/				/**		 * Allows for the end date to be updated eaisily by supplying new values 		 * @param year		 * @param month		 * @param day		 * @param hour		 * @param minute		 * @param seconds		 */				public function updateEndDate(targetDate:Date):void		{			_endDate = targetDate;						if(!_countdownTimer.hasEventListener(TimerEvent.TIMER))				_countdownTimer.addEventListener(TimerEvent.TIMER, updateTime);						if(!_countdownTimer.running)				_countdownTimer.start();		}				/***** Private Methods: *****/				/**		 *Event handler that calculates the time remaining as it is being updated 		 * @param e		 */				private function updateTime(e:TimerEvent):void		{			//Current time			var now:Date = new Date();			var timeLeft:Number = _endDate.getTime() - now.getTime();						if(timeLeft <= 0)			{				trace("TIME'S UP");				_countdownTimer.removeEventListener(TimerEvent.TIMER, updateTime);				_countdownTimer.stop();								// DISPATCH an update event				dispatchEvent(new CountdownEvent(CountdownEvent.COUNTDOWN_COMPLETE));				return;			}						//Converting the remaining time into seconds, minutes, hours, and days			var sec:Number = Math.floor(timeLeft / 1000);			var min:Number = Math.floor(sec / 60);			var hrs:Number = Math.floor(min / 60);			var d:Number = Math.floor(hrs / 24);						//Storing the remainder of this division problem			sec %= 60;			min %= 60;			hrs %= 24;						//Converting numerical values into strings so that 			//we string all of these numbers together for the display			_seconds = sec.toString();			_minutes = min.toString();			_hours = hrs.toString();			_days = d.toString();						//Setting up a few restrictions for when the current time reaches a single digit			if (_seconds.length < 2)				_seconds = "0" + _seconds;						if (_minutes.length < 2)				_minutes = "0" + _minutes;						if (_hours.length < 2)				_hours = "0" + _hours;						// DISPATCH an update event			dispatchEvent(new CountdownEvent(CountdownEvent.COUNTDOWN_UPDATE));						//Stringing all of the numbers together for the display			_time = _days + ":" + _hours + ":" + _minutes + ":" + _seconds;					}		/**		 * Setup up any of the object's event listeners 		 */				private function setupListeners():void		{			//Adding an event listener to the timer object			_countdownTimer.addEventListener(TimerEvent.TIMER, updateTime);		}				/***** GETTERs and SETTERs *****/		public function get days():String		{			return _days;		}		public function get hours():String		{			return _hours;		}		public function get seconds():String		{			return _seconds;		}		public function get minutes():String		{			return _minutes;		}		public function get time():String		{			return _time;		}	}}