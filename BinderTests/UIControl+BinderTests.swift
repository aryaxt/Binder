//
//  BinderTests.swift
//  BinderTests
//
//  Created by Aryan Ghassemi on 5/1/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import XCTest
@testable import Binder

class UIControlBinderTests: XCTestCase {
	
	func testTouchDown() { assertControlEvent(.TouchDown) }
	func testTouchDownRepeat() { assertControlEvent(.TouchDownRepeat) }
	func testTouchDragInside() { assertControlEvent(.TouchDragInside) }
	func testTouchDragEnter() { assertControlEvent(.TouchDragEnter) }
	func testTouchDragExit() { assertControlEvent(.TouchDragExit) }
	func testTouchUpInside() { assertControlEvent(.TouchUpInside) }
	func testTouchUpOutside() { assertControlEvent(.TouchUpOutside) }
	func testValueChanged() { assertControlEvent(.ValueChanged) }
	func testEditingDidBegin() { assertControlEvent(.EditingDidBegin) }
	func testEditingChanged() { assertControlEvent(.EditingChanged) }
	func testEditingDidEnd() { assertControlEvent(.EditingDidEnd) }
	func testEditingDidEndOnExit() { assertControlEvent(.EditingDidEndOnExit) }
	func testAllTouchEvents() { assertControlEvent(.AllTouchEvents) }
	func testAllEditingEvents() { assertControlEvent(.AllEditingEvents) }
	
	func testShouldNotTriggerWhenNotExpected() {
		let button = UIButton()
		var eventDetected = false
		button.bindControlEvent(.TouchUpInside) { eventDetected = true }
		button.sendActionsForControlEvents(.TouchUpOutside)
		XCTAssert(eventDetected == false)
	}
	
	private func assertControlEvent(event: UIControlEvents) {
		let button = UIButton()
		var eventDetected = false
		button.bindControlEvent(event) { eventDetected = true }
		button.sendActionsForControlEvents(event)
		XCTAssert(eventDetected == true)
	}
    
}
