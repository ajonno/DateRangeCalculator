//
//  DateRangeCalculatorTests.swift
//  DateRangeCalculatorTests
//
//  Created by Angus Johnston on 18/01/2016.
//  Copyright © 2016 Angus Johnston. All rights reserved.
//

import XCTest
@testable import DateRangeCalculator

class DateRangeCalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
	
	
	func testTheDateIsAValidDate() {
		
		let theDate = AJDate(theDay: 1, theMonth: 1, theYear: 2000)
		XCTAssertEqual(true, theDate != nil)

		let theDate2 = AJDate(theDay: 21, theMonth: 14, theYear: 2016)
		XCTAssertEqual(true, theDate2 == nil)

	}
	
	
    func testIsTheYearALeapYear() {
		
		let theDate = AJDate(theDay: 1, theMonth: 1, theYear: 2004)
		XCTAssertEqual(true, theDate?.isLeapYear)

		let newDate = AJDate(theDay: 1, theMonth: 1, theYear: 2000)
		XCTAssertEqual(false, newDate?.isLeapYear)
    }
	
	
}
