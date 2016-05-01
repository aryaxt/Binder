//
//  UIControlEventListener.swift
//  Binder
//
//  Created by Aryan Ghassemi on 5/1/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import UIKit

internal class UIControlEventListener {
	
	private typealias Closure = Void->Void
	private var eventListeners = [UIControlEvents: Closure]()
	
	init(control: UIControl) {
		control.addTarget(self, action: #selector(UIControlEventListener.onTouchDownEvent(_:)), forControlEvents: .TouchDown)
		control.addTarget(self, action: #selector(UIControlEventListener.onTouchDownRepeatEvent(_:)), forControlEvents: .TouchDownRepeat)
		control.addTarget(self, action: #selector(UIControlEventListener.onTouchDragInsideEvent(_:)), forControlEvents: .TouchDragInside)
		control.addTarget(self, action: #selector(UIControlEventListener.onTouchDragOutsideEvent(_:)), forControlEvents: .TouchDragOutside)
		control.addTarget(self, action: #selector(UIControlEventListener.onTouchDragEnterEvent(_:)), forControlEvents: .TouchDragEnter)
		control.addTarget(self, action: #selector(UIControlEventListener.onTouchDragExitEvent(_:)), forControlEvents: .TouchDragExit)
		control.addTarget(self, action: #selector(UIControlEventListener.onTouchUpInsideEvent(_:)), forControlEvents: .TouchUpInside)
		control.addTarget(self, action: #selector(UIControlEventListener.onTouchUpOutsideEvent(_:)), forControlEvents: .TouchUpOutside)
		control.addTarget(self, action: #selector(UIControlEventListener.onTouchCancelEvent(_:)), forControlEvents: .TouchCancel)
		control.addTarget(self, action: #selector(UIControlEventListener.onValueChangedEvent(_:)), forControlEvents: .ValueChanged)
		control.addTarget(self, action: #selector(UIControlEventListener.onEditingDidBeginEvent(_:)), forControlEvents: .EditingDidBegin)
		control.addTarget(self, action: #selector(UIControlEventListener.onEditingChangedEvent(_:)), forControlEvents: .EditingChanged)
		control.addTarget(self, action: #selector(UIControlEventListener.onEditingDidEndEvent(_:)), forControlEvents: .EditingDidEnd)
		control.addTarget(self, action: #selector(UIControlEventListener.onEditingDidEndOnExitEvent(_:)), forControlEvents: .EditingDidEndOnExit)
		control.addTarget(self, action: #selector(UIControlEventListener.onAllTouchEventsEvent(_:)), forControlEvents: .AllTouchEvents)
		control.addTarget(self, action: #selector(UIControlEventListener.onAllEditingEventsEvent(_:)), forControlEvents: .AllEditingEvents)
	}
	
	// MARK: - Public -
	
	internal func bindClosureToEvent(event: UIControlEvents, closure: Void->Void) {
		eventListeners[event] = closure
	}
	
	// MARK: - Target Event Listeners -
	
	@objc func onTouchDownEvent(sender: AnyObject) { triggerEventClosure(.TouchDown) }
	@objc func onTouchDownRepeatEvent(sender: AnyObject) { triggerEventClosure(.TouchDownRepeat) }
	@objc func onTouchDragInsideEvent(sender: AnyObject) { triggerEventClosure(.TouchDragInside) }
	@objc func onTouchDragOutsideEvent(sender: AnyObject) { triggerEventClosure(.TouchDragOutside) }
	@objc func onTouchDragEnterEvent(sender: AnyObject) { triggerEventClosure(.TouchDragEnter) }
	@objc func onTouchDragExitEvent(sender: AnyObject) { triggerEventClosure(.TouchDragExit) }
	@objc func onTouchUpInsideEvent(sender: AnyObject) { triggerEventClosure(.TouchUpInside) }
	@objc func onTouchUpOutsideEvent(sender: AnyObject) { triggerEventClosure(.TouchUpOutside) }
	@objc func onTouchCancelEvent(sender: AnyObject) { triggerEventClosure(.TouchCancel) }
	@objc func onValueChangedEvent(sender: AnyObject) { triggerEventClosure(.ValueChanged) }
	@objc func onEditingDidBeginEvent(sender: AnyObject) { triggerEventClosure(.EditingDidBegin) }
	@objc func onEditingChangedEvent(sender: AnyObject) { triggerEventClosure(.EditingChanged) }
	@objc func onEditingDidEndEvent(sender: AnyObject) { triggerEventClosure(.EditingDidEnd) }
	@objc func onEditingDidEndOnExitEvent(sender: AnyObject) { triggerEventClosure(.EditingDidEndOnExit) }
	@objc func onAllTouchEventsEvent(sender: AnyObject) { triggerEventClosure(.AllTouchEvents) }
	@objc func onAllEditingEventsEvent(sender: AnyObject) { triggerEventClosure(.AllEditingEvents) }
	
	// MARK: - Private -
	
	private func triggerEventClosure(event: UIControlEvents) {
		guard let closure = eventListeners[event] else { return }
		closure()
	}
	
}
