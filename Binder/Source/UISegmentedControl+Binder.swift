//
//  UISegmentedControl+Binder.swift
//  Binder
//
//  Created by Aryan Ghassemi on 5/1/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import UIKit

public extension UISegmentedControl {
	
	public func bindValueChange(closure: Int->Void) {
		bindControlEvent(.ValueChanged) {
			closure(self.selectedSegmentIndex)
		}
	}
	
}
