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
		dataSourceProxy.numberOfSectionsClosure = closure
		return self
	}
	
	public func bindNumberOfRowsForSection(closure: Int->Int) -> UITableView {
		dataSourceProxy.numberOfRowsClosure = closure
		return self
	}
	
	public func bindCellIdentifier(closure: NSIndexPath->String) -> UITableView {
		dataSourceProxy.cellIdentifierClosure = closure
		return self
	}
	
	public func bindCell<T: UITableViewCell>(type: T.Type, closure: (NSIndexPath, T)->Void) -> UITableView {
		dataSourceProxy.cellClassName = String(T)
		dataSourceProxy.cellClosure = { indexPath, cell in
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

