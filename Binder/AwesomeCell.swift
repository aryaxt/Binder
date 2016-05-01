//
//  CustomCell.swift
//  Binder
//
//  Created by Aryan Ghassemi on 5/1/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import UIKit

public class AwesomeCell: UITableViewCell {
	
	public func configure(string: String) {
		textLabel?.text = string
	}
	
}