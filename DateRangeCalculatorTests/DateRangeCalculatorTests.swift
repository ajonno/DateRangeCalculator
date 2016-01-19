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

		let lastDate = AJDate(theDay: 35, theMonth: 14, theYear: 2016)
		XCTAssertEqual(true, lastDate == nil)

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
	
	func testNumberOfDaysInAYear() {
		
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
	
	func testNumberOfDaysInAMonth() {
	
		//requires the month and the year (since it could be a leap year)
		let aDate = AJDate(theDay: 21, theMonth: 12, theYear: 1998)
		if let aDate = aDate {
			XCTAssertEqual(31, aDate.numberOfDaysInMonth)
			XCTAssertNotEqual(30, aDate.numberOfDaysInMonth)
		}

		let aDate2 = AJDate(theDay: 21, theMonth: 12, theYear: 1998)
		if let aDate2 = aDate2 {
			XCTAssertEqual(31, aDate2.numberOfDaysInMonth(2005, theMonth: 12))
			XCTAssertNotEqual(30, aDate2.numberOfDaysInMonth(2005, theMonth: 12))
		}

		
		//test for a leap year
		let anotherDate = AJDate(theDay: 21, theMonth: 2, theYear: 2004)
		if let anotherDate = anotherDate {
			XCTAssertEqual(29, anotherDate.numberOfDaysInMonth)
			XCTAssertNotEqual(28, anotherDate.numberOfDaysInMonth)
		}
	}
	
	func testNumberOfDaysUntilEndOfMonth() {
		
		let aDate = AJDate(theDay: 30, theMonth: 3, theYear: 2001)
		if let aDate = aDate {
			let daysRemainingInMonth = aDate.numberOfDaysUntilEndOfMonth
			XCTAssertEqual(1, daysRemainingInMonth)
		}
		
		//test it on a leap year in February
		let anotherDate = AJDate(theDay: 12, theMonth: 2, theYear: 2004)
		if let anotherDate = anotherDate {
			let daysRemainingInMonth = anotherDate.numberOfDaysUntilEndOfMonth
			XCTAssertEqual(17, daysRemainingInMonth)
		}
		
		//test result for last day of the month
		let lastDate = AJDate(theDay: 31, theMonth: 3, theYear: 2015)
		if let lastDate = lastDate {
			let daysRemainingInMonth = lastDate.numberOfDaysUntilEndOfMonth
			XCTAssertEqual(0, daysRemainingInMonth)
		}
	}
	
	func testTotalDaysRemainingUntilEndOfTheYear() {
		
		let aDate = AJDate(theDay: 1, theMonth: 10, theYear: 2005)
		if let aDate = aDate {
			let daysRemainingInYear = aDate.numberOfDaysUntilEndOfYear(aDate.year, fromMonth: aDate.month, fromDay: aDate.day)
			XCTAssertEqual(92, daysRemainingInYear)
		}

		//TODO: MORE ASSERTS HERE. NEED TO RESOLVE ISSUE OF NOT COUNTING START AND END DATE FOR THIS APP
		
	
	}

	func testTotalDaysFromStartOfYearTo() {
		
		let toDate = AJDate(theDay: 31, theMonth: 12, theYear: 2005)
		if let toDate = toDate {
			let daysFromStartOfYearTo = toDate.numberOfDayFromStartOfYearTo(toDate.year, toMonth: toDate.month, toDay: toDate.day)
			XCTAssertEqual(365, daysFromStartOfYearTo)
		}
		
		//TODO: MORE ASSERTS HERE. NEED TO RESOLVE ISSUE: WE CURRENTLY ARE INCLUDING START AND END DATE FOR THIS APP
		
		
	}

	func test_1_From_Test_Cases() {
	
		//calc from(2 June 1983 ) to (22 June 1983 ) ;  sb/ 19 days
		let fromDate = AJDate(theDay: 2, theMonth: 6, theYear: 1983)
		let toDate = AJDate(theDay: 22, theMonth: 6, theYear: 1983)
		
		if let fromDate = fromDate , let toDate = toDate {
			var result = fromDate.numberOfDaysBetween(fromDate, toDate: toDate)
			XCTAssertEqual(19, result)
		} else {
			XCTAssertNil(fromDate)	//TODO: invalid dates test should fail
		}
	}
	
	func test_2_From_Test_Cases() {
	
		//calc from(4 July 1984) to (25 Dec 1984) ; sb 173 days
		let fromDate = AJDate(theDay: 4, theMonth: 7, theYear: 1984)
		let toDate = AJDate(theDay: 25, theMonth: 12, theYear: 1984)
		
		if let fromDate = fromDate , let toDate = toDate {
			var result = fromDate.numberOfDaysBetween(fromDate, toDate: toDate)
			XCTAssertEqual(173, result)
		} else {
			XCTAssertNil(fromDate)	//TODO: invalid dates test should fail
		}
	}

	func test_3_From_Test_Cases() {
		
		//calc from(3 Jan 1989) to (3 Aug 1983) ; sb 1979 days
		let fromDate = AJDate(theDay: 3, theMonth: 1, theYear: 1989)	//<!!!!-----
		let toDate = AJDate(theDay: 3, theMonth: 8, theYear: 1983)
		
		if let fromDate = fromDate , let toDate = toDate {
			var result = fromDate.numberOfDaysBetween(fromDate, toDate: toDate)
			XCTAssertEqual(1979, result)
		} else {
			XCTAssertNil(fromDate)	//TODO: invalid dates test should fail
		}
	}

	
}
