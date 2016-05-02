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
		delegateProxy.selectionClosure = closure
		return self
	}
	
	public func bindDeselection(closure: NSIndexPath->Void) -> UITableView {
		delegateProxy.deselectionClosure = closure
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
		static var DelegateProxy = "binder_EventListener"
	}
	
	internal var dataSourceProxy: TableViewDataSourceProxy {
		get {
			let proxy: TableViewDataSourceProxy
			
			if let aProxy = objc_getAssociatedObject(self, &AssociatedKeys.DatasourceProxy) as? TableViewDataSourceProxy {
				proxy = aProxy
			}
			else {
				proxy = TableViewDataSourceProxy()
				objc_setAssociatedObject(self, &AssociatedKeys.DatasourceProxy, proxy, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			}
			
			if let aDatasource = dataSource {
				if let _ = aDatasource as? TableViewDataSourceProxy {
					
				}
				else {
					dataSource = TableViewDataSourceProxy(dataSource: aDatasource)
				}
			}
			else {
				dataSource = proxy
			}
			
			return proxy
		}
	}
	
	internal var delegateProxy: TableViewDelegateProxy {
		get {
			let proxy: TableViewDelegateProxy
			
			if let aProxy = objc_getAssociatedObject(self, &AssociatedKeys.DelegateProxy) as? TableViewDelegateProxy {
				proxy = aProxy
			}
			else {
				proxy = TableViewDelegateProxy()
				objc_setAssociatedObject(self, &AssociatedKeys.DelegateProxy, proxy, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			}
			
			if let aDelegate = delegate {
				if let _ = aDelegate as? TableViewDelegateProxy {
					
				}
				else {
					delegate = TableViewDelegateProxy(delegate: aDelegate)
				}
			}
			else {
				delegate = proxy
			}
			
			return proxy
		}
	}
	
}

