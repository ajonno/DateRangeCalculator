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

		let anotherDate = AJDate(theDay: 35, theMonth: 14, theYear: 2016)
		XCTAssertEqual(true, anotherDate == nil)

	}

	func testTheYearIsValidBasedOnMinMaxValues() {
		
		//min = 01 Jan 1901
		//max = 31 Dec 2999
		
		let validDate = AJDate(theDay: 1, theMonth: 1, theYear: 1901)
		XCTAssertEqual(false, validDate == nil)
		
		let theDate = AJDate(theDay: 1, theMonth: 1, theYear: 1900)
		XCTAssertEqual(true, theDate == nil)
		
		let anotherDate = AJDate(theDay: 1, theMonth: 1, theYear: 3000)
		XCTAssertEqual(true, anotherDate == nil)
		
		
	}
	
    func testIsTheYearALeapYear() {
		
		let theDate = AJDate(theDay: 1, theMonth: 1, theYear: 2004)
		XCTAssertEqual(true, theDate?.isLeapYear)

		let newDate = AJDate(theDay: 1, theMonth: 1, theYear: 2000)
		XCTAssertEqual(false, newDate?.isLeapYear)
    }
	
	func testNumberOfDaysInAYearIsCorrect() {
		
		//LEAP year
		let theDate = AJDate(theDay: 1, theMonth: 1, theYear: 2016)
		if let theDate = theDate {
			XCTAssertEqual(366, theDate.numberOfDaysInYear)
		}
		
		//non-leap year
		let anotherDate = AJDate(theDay: 1, theMonth: 1, theYear: 2001)
		if let anotherDate = anotherDate {
			XCTAssertEqual(365, anotherDate.numberOfDaysInYear)
		}
	}
	
	func testNumberOfDaysInAMonthIsCorrect() {
	
		//requires the month and the year (since it could be a leap year)
		let aDate = AJDate(theDay: 21, theMonth: 5, theYear: 1998)
		if let aDate = aDate {
			XCTAssertEqual(31, aDate.numberOfDaysInMonth)
			XCTAssertNotEqual(30, aDate.numberOfDaysInMonth)
		}
		
		//requires the month and the year (since it could be a leap year)
		let anotherDate = AJDate(theDay: 21, theMonth: 2, theYear: 2004)
		if let anotherDate = anotherDate {
			XCTAssertEqual(29, anotherDate.numberOfDaysInMonth)
			XCTAssertNotEqual(28, anotherDate.numberOfDaysInMonth)
		}
	}
	
	
	
	
	
}
