//
//  TableViewDelegateProxy.swift
//  Binder
//
//  Created by Aryan Ghassemi on 5/1/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import UIKit

internal class TableViewDelegateProxy: NSObject, UITableViewDelegate {
	
	private weak var delegate: UITableViewDelegate?
	internal var selectionClosure: (NSIndexPath->Void)?
	internal var deselectionClosure: (NSIndexPath->Void)?
	
	// MARK: - Initialization -
	
	override init() {
		super.init()
	}
	
	init(delegate: UITableViewDelegate) {
		self.delegate = delegate
	}
	
//	init(anotherProxy: TableViewDelegateProxy, delegate: UITableViewDelegate) {
//		super.init()
//		self.delegate = delegate
//		self.selectionClosure = anotherProxy.selectionClosure
//		self.deselectionClosure = anotherProxy.deselectionClosure
//	}
	
	// MARK: - NSObject -
	
	override func respondsToSelector(aSelector: Selector) -> Bool {
		print("==============")
		print(String(aSelector))
		
		if let delegate = delegate where delegate.respondsToSelector(aSelector) {
			print("delegate true")
			return true
		}
		
		let res = super.respondsToSelector(aSelector)
		print("self \(res)")
		return res
	}
	
	override func forwardingTargetForSelector(aSelector: Selector) -> AnyObject? {
		if let delegate = delegate where delegate.respondsToSelector(aSelector) {
			return delegate
		}
		
		return super.forwardingTargetForSelector(aSelector)
	}
	
	// MARK: - UITableViewDelegate -

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		selectionClosure?(indexPath)
	}
	
	func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
		deselectionClosure?(indexPath)
	}
	
}
