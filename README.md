# Binder
[![Build Status](https://api.travis-ci.org/aryaxt/Binder.svg)](https://api.travis-ci.org/aryaxt/Binder)
[![Version](http://cocoapod-badges.herokuapp.com/v/Binder/badge.png)](http://cocoadocs.org/docsets/Binder)

A simaple UI Binder for swift 
*** Still in development, DO NOT USE ***

#### UIControl
Bind to any existing UIControlEvents
```swift
anyUiControl.bindControlEvent(.AllEvents) { print("Any Event") }
```
#### UIButton
```swift
button.bindTap { print("tap on button") }
```
#### UITxtField
```swift
textField.bindTextChange { print("text value: \($0)") }
```
#### UISegmentedControle
```swift
segmentedControl.bindValueChange { print("selected index \($0)") }
```
#### UITableView
Populate a table, this will use the class name as the cell identifier
```swift
tableview
  .bindNumberOfRowsForSection { _ in self.tableData.count }
  .bindCell(AwesomeCell.self) { indexPath, cell in cell.configure(self.tableData[indexPath.row]) }
```
Provide custom identifier for the cells
```swift
tableview
  .bindNumberOfRowsForSection { _ in self.tableData.count }
  .bindCellIdentifier { _ in "AwesomeCellNumber2" }
  .bindCell(AwesomeCell.self) { indexPath, cell in cell.configure(self.tableData[indexPath.row]) }
```
Customize number of section
```swift
tableview
  .bindNumberOfSections { return 2 }
  .bindNumberOfRowsForSection { _ in self.tableData.count }
  .bindCell(AwesomeCell.self) { indexPath, cell in cell.configure(self.tableData[indexPath.row]) }
```
Selection & Deselection
```swift
tableview
  .bindNumberOfRowsForSection { _ in self.tableData.count }
  .bindCell(AwesomeCell.self) { indexPath, cell in cell.configure(self.tableData[indexPath.row]) }
  .bindSelection { indexPath in print("selected row: \(self.tableData[indexPath.row]))") }
  .bindDeselection { indexPath in print("deselected row: \(self.tableData[indexPath.row]))") }
```

