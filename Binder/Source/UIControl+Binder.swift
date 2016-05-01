//
//  UIControl+Binder.swift
//  Binder
//
//  Created by Aryan Ghassemi on 5/1/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import UIKit

public extension UIControl {
	
	public func bindControlEvent(event: UIControlEvents, closure: Void->Void) {
		eventListener?.addClosureForEvent(event, closure: closure)
	}
	
}

internal extension UIControl {
	
	private struct AssociatedKeys {
		static var EventListener = "binder_EventListener"
	}
	
	internal var eventListener: UIControlEventListener? {
		get {
			if let listener = objc_getAssociatedObject(self, &AssociatedKeys.EventListener) as? UIControlEventListener {
				return listener
			}
			else {
				let listener = UIControlEventListener(control: self)
				objc_setAssociatedObject(self, &AssociatedKeys.EventListener, listener, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
				return listener
			}
		}
	}
	
}
