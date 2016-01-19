//
//  AJDate.swift
//  DateRangeCalculator
//
//  Created by Angus Johnston on 18/01/2016.
//  Copyright © 2016 Angus Johnston. All rights reserved.
//

/**
	Notes
	=====
	- this class is being built to satisfy the requirements of a simple from-date range task, and so its properties and methods are designed only with that purpose in mind
**/

import Foundation


enum Month : Int {
	case Jan = 1
	case Feb = 2
	case Mar = 3
	case Apr = 4
	case May = 5
	case Jun = 6
	case Jul = 7
	case Aug = 8
	case Sep = 9
	case Oct = 10
	case Nov = 11
	case Dec = 12
}


struct AJDate {
	
	private(set) var day: Int
	private(set) var month: Int
	private(set) var year: Int
	
	//helper arrays
	private let gregorianDays = Array(1...31)
	private let gregorianMonths = Array(1...12)
	
	let MINIMUM_YEAR: Int = 1901
 	let MAXIMUM_YEAR: Int = 2999
	
	//this will return nil, if any of the passed in values were invalid
	init?(theDay: Int, theMonth: Int, theYear: Int) {
		
		self.day = theDay
		self.month = theMonth
		self.year = theYear
		
		if !isDateValid(self.year, month: self.month, day: self.day) {
			return nil
		}
	}
	
	var isLeapYear: Bool {
		get {
			return isLeapYear(self.year)
		}
	}

	var numberOfDaysInYear: Int {
		get {
			return numberOfDaysInYear(self.year)
		}
	}

	var numberOfDaysInMonth: Int {
		get {
			return numberOfDaysInMonth(self.year, theMonth: self.month)
		}
	}

	var numberOfDaysUntilEndOfMonth: Int {
		get {
			return numberOfDaysUntilEndOfMonth(self.year, fromMonth: self.month, fromDay: self.day)
		}
	}

	var numberOfDaysUntilEndOfYear: Int {
		get {
			return numberOfDaysUntilEndOfYear(self.year, fromMonth: self.month, fromDay: self.day)
		}
	}

	var numberOfDaysFromStartOfYear: Int {
		get {
			return numberOfDayFromStartOfYearTo(self.year, toMonth: self.month, toDay: self.day)
		}
	}

	
	
	func isLeapYear(year: Int) -> Bool {
		
		guard (year-2000)%4 == 0 else {
			return false
		}
		
		guard (year)%100 != 0 else {
			return false
		}
		
		guard (year)%400 == 0 else {
			return true
		}
		
		return false
	}
	
	func isDateValid(year: Int, month: Int, day: Int) -> Bool {
		
		if year < 0	|| (year < MINIMUM_YEAR || year > MAXIMUM_YEAR) {return false}
		if month < 1 || month > 12		{return false}
		if day < 1 || day > 31			{return false}
		
		switch (month) {
		case 1: return true
		case 2: return isLeapYear(year) ? day <= 29 : day <= 28
		case 3: return true
		case 4: return day < 31
		case 5: return true
		case 6: return day < 31
		case 7: return true
		case 8: return true
		case 9: return day < 31
		case 10: return true
		case 11: return day < 31
		default: return true		//for Dec
		}
	}
	
	func numberOfDaysInYear(theYear: Int) -> Int {
		return isLeapYear(theYear) ? 366 : 365
	}
	
	func numberOfDaysInMonth(theYear: Int, theMonth: Int) -> Int {
		switch (theMonth) {
		case 1: return 31
		case 2: return isLeapYear(theYear) ? 29 : 28
		case 3: return 31
		case 4: return 30
		case 5: return 31
		case 6: return 30
		case 7: return 31
		case 8: return 31
		case 9: return 30
		case 10: return 31
		case 11: return 30
		case 12: return 31
		default: return 0
		}
	}
	
	func numberOfDaysUntilEndOfMonth(fromYear: Int , fromMonth: Int, fromDay: Int) -> Int {
		let daysInMonth = numberOfDaysInMonth(fromYear, theMonth: fromMonth)     //numberOfDaysInMonth(month)
		return daysInMonth - fromDay
	}

	func numberOfDaysUntilEndOfYear(fromYear: Int, fromMonth: Int, fromDay: Int ) -> Int {
	
		//number of days remaining in the fromMonth
		let daysRemainingInFromMonth = numberOfDaysUntilEndOfMonth(fromYear, fromMonth: fromMonth, fromDay: fromDay)
		//print("\ndaysRemainingInFromMonth = \(daysRemainingInFromMonth)\n")
		
		let allMonthsAfterStartMonth = gregorianMonths.dropFirst(fromMonth)
		print("\nallMonthsAfterStartMonth = \(allMonthsAfterStartMonth)\n")
		
		var totalDaysForAllOtherMonths: Int = 0
		for month in allMonthsAfterStartMonth {
			totalDaysForAllOtherMonths += numberOfDaysInMonth(fromYear, theMonth: month)
		}
		//print("\ntotalDaysForAllOtherMonths = \(totalDaysForAllOtherMonths)\n")
		
		//TODO: this is currently NOT including the fromDay. so vs. web result this is 1 less
		
		return daysRemainingInFromMonth + totalDaysForAllOtherMonths
	}
	
	func numberOfDayFromStartOfYearTo(toYear: Int, toMonth: Int, toDay: Int) -> Int {
		
		//   1/1/2005 - 31/12/2005		[31, 28, 31 18] = 69
		
		//let monthsToCalculateDaysFor = [Jan…toMonth]  EXCLUDE THE **TO** MONTH when building this array
		let monthsToCalculateDaysFor = gregorianMonths.dropLast(gregorianMonths.count - (toMonth - 1))
		
		var totalsDaysForAllMonthsExceptLast: Int = 0
		for month in monthsToCalculateDaysFor {
			totalsDaysForAllMonthsExceptLast += numberOfDaysInMonth(toYear, theMonth: month)
		}

		return totalsDaysForAllMonthsExceptLast + toDay
	}
	
	
	func numberOfDaysBetween(fromDate: AJDate, toDate: AJDate, excludeStartDate: Bool) -> Int {
		
		//TODO: handle backwards dates here too (flip in the array)

		//case 1 - start and end yr/mth are the same
		if (fromDate.year == toDate.year && fromDate.month == toDate.month) {
			var finalResult = (toDate.day - fromDate.day)
			if excludeStartDate {
				finalResult = (finalResult - 1) < 0 ? 0 : finalResult - 1
			}
			return finalResult
		}
		
		//case 2 - start and end yr are the same, months are different
		if (fromDate.year == toDate.year) {
			
			//calc from(4 July 1984) to (25 Dec 1984) ; sb 173 days
			
			let firstMonthDays = fromDate.numberOfDaysUntilEndOfMonth
			
			//get in between (if there are any) months total days 
			let requiredFromToMonths = Array(fromDate.month...toDate.month)
			
			var fullMonthsTotal: Int = 0
			if requiredFromToMonths.count > 2 {
				let fullMonthElements = requiredFromToMonths.dropFirst().dropLast()
				for month in fullMonthElements {
					fullMonthsTotal += numberOfDaysInMonth(fromDate.year, theMonth: month)
				}
			}
			let finalResult = firstMonthDays + fullMonthsTotal + toDate.day
			return excludeStartDate ? finalResult - 1 : finalResult
		}
		
		//case 3 - start and end year are different
		if (fromDate.year != toDate.year) {
		
			//calc from(3 Jan 1989) to (3 Aug 1983) ; sb 1979 days

			//first make sure the years are in sequence (as per the BCG document - this test case
			//has reverse date order
			var confirmedFromDate: AJDate = fromDate
			var confirmedToDate: AJDate = toDate
			
			if !isCorrectDateOrderSequence(fromDate, toDate: toDate) {
				confirmedFromDate = toDate
				confirmedToDate = fromDate
			}
			
			//get in between (if there are any) years total days
			let requiredFromToYears = Array(confirmedFromDate.year...confirmedToDate.year)
			
			var inBetweenYearsTotal: Int = 0
			if requiredFromToYears.count > 2 {
				let fullYearElements = requiredFromToYears.dropFirst().dropLast()
				for year in fullYearElements {
					inBetweenYearsTotal += numberOfDaysInYear(year)
				}
			}
			
			//now get the first years total days (ie. from start day/mth -> 31 Dec of that same year
			let firstYearsTotalDays = confirmedFromDate.numberOfDaysUntilEndOfYear
			
			//now get the last years total days (ie. from 1 Jan -> end date)
			let lastYearsTotalDays = confirmedToDate.numberOfDaysFromStartOfYear
			
			let finalResult = firstYearsTotalDays + inBetweenYearsTotal + lastYearsTotalDays
			return excludeStartDate ? finalResult - 1 : finalResult
		}
		
		//TODO: no result - what is best way to handle this
		return 0
	}
	
	private func isCorrectDateOrderSequence(fromDate: AJDate, toDate: AJDate) -> Bool {
		if (fromDate.year > toDate.year) {
			return false
		}
		return true
	}
	
//	private func calcNumberOfDaysBetweenSameYear(startDate: AJDate, endDate: AJDate) -> Int {
//		
//		let numDaysTillEndOfFirstMonth = startDate.numberOfDaysUntilEndOfMonth
//		
//		
//		
//		return 0
//	}
	
	
}
