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
        // Put setup code here. This method is called before the invocation of each test method in the class.
		
		
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsTheYearALeapYear() {
		
		let theDate = AJDate(theDay: 1, theMonth: 1, theYear: 2000)
		XCTAssertEqual(false, theDate?.isLeapYear())
    }
	
	
	
	
	
	
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
	
}
