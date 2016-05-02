//
//  TableDataSourceProxy.swift
//  Binder
//
//  Created by Aryan Ghassemi on 5/1/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import UIKit

internal class TableViewDataSourceProxy: NSObject, UITableViewDataSource {
	
	private weak var dataSource: UITableViewDataSource?
	internal var numberOfSectionsClosure: (Void->Int)?
	internal var numberOfRowsClosure: (Int->Int)?
	internal var cellIdentifierClosure: (NSIndexPath->String)?
	internal var cellClosure: ((NSIndexPath, UITableViewCell)->Void)?
	internal var cellClassName: String?
	
	// MARK: - Initialization -
	
	override init() {
		super.init()
	}
	
	init(dataSource: UITableViewDataSource) {
		self.dataSource = dataSource
	}
	
	// MARK: - NSObject -
	
	override func respondsToSelector(aSelector: Selector) -> Bool {
		if let dataSource = dataSource where dataSource.respondsToSelector(aSelector) {
			return true
		}
		
		return super.respondsToSelector(aSelector)
	}
	
	override func forwardingTargetForSelector(aSelector: Selector) -> AnyObject? {
		if let dataSource = dataSource where dataSource.respondsToSelector(aSelector) {
			return dataSource
		}
		
		return super.forwardingTargetForSelector(aSelector)
	}
	
	// MARK: - UITableViewDataSource -
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return numberOfSectionsClosure?() ?? 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return numberOfRowsClosure?(section) ?? 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let identifier = cellIdentifierClosure?(indexPath) ?? cellClassName
		guard let cellIdentifier = identifier else { fatalError("no cell identifier was provided") }
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
		cellClosure?(indexPath, cell)
		return cell
	}
	
}
