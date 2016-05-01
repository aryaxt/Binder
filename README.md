# Binder
[![Build Status](https://api.travis-ci.org/aryaxt/Binder.svg)](https://api.travis-ci.org/aryaxt/Binder)
[![Version](http://cocoapod-badges.herokuapp.com/v/Binder/badge.png)](http://cocoadocs.org/docsets/Binder)

A simaple UI Binder for swift 

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
```swift
// Will automatically dequeus cell with identifier with the same name as the custom cell class
tableview
  .bindNumberOfRowsForSection { _ in self.tableData.count }
  .bindCell(AwesomeCell.self) { indexPath, cell in cell.configure(self.tableData[indexPath.row]) }
  .bindSelection { indexPath in print("selected row: \(self.tableData[indexPath.row]))") }
  
// Providing the cell identifier manually
tableview
  .bindNumberOfRowsForSection { _ in self.tableData.count }
  .bindCellIdentifier { _ in "AwesomeCellNumber2" }
  .bindCell(AwesomeCell.self) { indexPath, cell in cell.configure(self.tableData[indexPath.row]) }
  .bindSelection { indexPath in print("selected row: \(self.tableData[indexPath.row]))") }
```

