//
//  ViewController.swift
//  Binder
//
//  Created by Aryan Ghassemi on 5/1/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet private var button: UIButton!
	@IBOutlet private var textField: UITextField!
	@IBOutlet private var textView: UITextView!
	@IBOutlet private var segmentedControl: UISegmentedControl!
	@IBOutlet private var tableview: UITableView!
	private var tableData = ["This", "Is", "A", "Test"]

	override func viewDidLoad() {
		super.viewDidLoad()
		
		button.bindTap { print("tap on button") }
		segmentedControl.bindValueChange { print($0) }
		
		textField.bindTextChange { print($0) }
//		textView.bindTextChange { print($0) }
		
		tableview
			.bindNumberOfRowsForSection { _ in self.tableData.count }
			.bindCell(AwesomeCell.self) { indexPath, cell in cell.configure(self.tableData[indexPath.row]) }
			.bindSelection { indexPath in print("selected row: \(self.tableData[indexPath.row]))") }
		
	}

}

