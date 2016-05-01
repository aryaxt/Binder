//
//  UIControlEvents+Hashable.swift
//  Binder
//
//  Created by Aryan Ghassemi on 5/1/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import UIKit

extension UIControlEvents: Hashable {
	
	public var hashValue: Int {
		return Int(rawValue)
	}
	
}
