//
//  UITableView+Binder.swift
//  Binder
//
//  Created by Aryan Ghassemi on 5/1/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import UIKit

public extension UITableView {
	
	public func bindNumberOfSections(closure: Void->Int) -> UITableView {
		dataSourceProxy.numberOfSectionsClusre = closure
		return self
	}
	
	public func bindNumberOfRowsForSection(closure: Int->Int) -> UITableView {
		dataSourceProxy.numberOfRowsClusre = closure
		return self
	}
	
	public func bindCellIdentifier(closure: NSIndexPath->String) -> UITableView {
		dataSourceProxy.cellIdentifierClosure = closure
		return self
	}
	
	public func bindCell<T: UITableViewCell>(type: T.Type, closure: (NSIndexPath, T)->Void) -> UITableView {
		dataSourceProxy.cellClassName = String(T)
		dataSourceProxy.cellClosure = { (indexPath, cell) in
			guard let customCell = cell as? T else { fatalError("Invalid cell type \(cell.dynamicType)") }
			closure(indexPath, customCell)
		}
		return self
	}
	
	public func bindSelection(closure: NSIndexPath->Void) -> UITableView {
		dataSourceProxy.selectionClosure = closure
		return self
	}
	
	public func bindDeselection(closure: NSIndexPath->Void) -> UITableView {
		dataSourceProxy.deselectionClosure = closure
		return self
	}
	
	public func bindDelegate(delegate: UITableViewDelegate) -> UITableView {
		return self
	}
	
	public func bindDataSource(dataSrouce: UITableViewDataSource) -> UITableView {
		return self
	}
	
}


internal class TableDataSourceProxy: NSObject, UITableViewDataSource {
	
	private weak var dataSource: UITableViewDataSource?
	internal var numberOfSectionsClusre: (Void->Int)?
	internal var numberOfRowsClusre: (Int->Int)?
	internal var cellIdentifierClosure: (NSIndexPath->String)?
	internal var cellClosure: ((NSIndexPath, UITableViewCell)->Void)?
	internal var selectionClosure: (NSIndexPath->Void)?
	internal var deselectionClosure: (NSIndexPath->Void)?
	internal var cellClassName: String?
	
	override init() {
		super.init()
	}
	
	init(dataSource: UITableViewDataSource) {
		self.dataSource = dataSource
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return numberOfSectionsClusre?() ?? 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return numberOfRowsClusre?(section) ?? 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let identifier = cellIdentifierClosure?(indexPath) ?? cellClassName
		guard let cellIdentifier = identifier else { fatalError("no cell identifier was provided") }
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
		cellClosure?(indexPath, cell)
		return cell
	}
	
	func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return dataSource?.tableView?(tableView, titleForHeaderInSection: section)
	}
	
	func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		return dataSource?.tableView?(tableView, titleForFooterInSection: section)
	}
	
	func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return dataSource?.tableView?(tableView, canEditRowAtIndexPath: indexPath) ?? false
	}
	
	func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return dataSource?.tableView?(tableView, canMoveRowAtIndexPath: indexPath) ?? false
	}
	
	func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
		return dataSource?.sectionIndexTitlesForTableView?(tableView)
	}
	
	func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
		return dataSource?.tableView?(tableView, sectionForSectionIndexTitle: title, atIndex: index) ?? 0
	}
	
	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		dataSource?.tableView?(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
	}
	
	func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
		dataSource?.tableView?(tableView, moveRowAtIndexPath: sourceIndexPath, toIndexPath: destinationIndexPath)
	}
	
}

internal extension UITableView {
	
	private struct AssociatedKeys {
		static var DatasourceProxy = "binder_EventListener"
	}
	
	internal var dataSourceProxy: TableDataSourceProxy {
		get {
			let proxy: TableDataSourceProxy
			
			if let aProxy = objc_getAssociatedObject(self, &AssociatedKeys.DatasourceProxy) as? TableDataSourceProxy {
				proxy = aProxy
			}
			else {
				proxy = TableDataSourceProxy()
				objc_setAssociatedObject(self, &AssociatedKeys.DatasourceProxy, proxy, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			}
			
			if let aDatasource = dataSource {
				if let _ = aDatasource as? TableDataSourceProxy {
					
				}
				else {
					dataSource = TableDataSourceProxy(dataSource: proxy)
				}
			}
			else {
				dataSource = proxy
			}
			
			return proxy
		}
	}
	
}

