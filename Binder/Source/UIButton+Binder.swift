//
//  UIButton+Binder.swift
//  Binder
//
//  Created by Aryan Ghassemi on 5/1/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import UIKit

public extension UIButton {
	
	public func bindTap(closure: Void->Void) {
		bindControlEvent(.TouchUpInside, closure: closure)
	}
	
}