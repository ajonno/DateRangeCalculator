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
	- this class is being built to satisfy the requirements of a from-date range task, and so its properties and methods are designed solely with that purpose in mind
**/

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
		
		let allMonthsAfterStartMonth = gregorianMonths.dropFirst(fromMonth)
		
		var totalDaysForAllOtherMonths: Int = 0
		for month in allMonthsAfterStartMonth {
			totalDaysForAllOtherMonths += numberOfDaysInMonth(fromYear, theMonth: month)
		}
		
		return daysRemainingInFromMonth + totalDaysForAllOtherMonths
	}
	
	func numberOfDayFromStartOfYearTo(toYear: Int, toMonth: Int, toDay: Int) -> Int {
		
		let monthsToCalculateDaysFor = gregorianMonths.dropLast(gregorianMonths.count - (toMonth - 1))
		
		var totalsDaysForAllMonthsExceptLast: Int = 0
		for month in monthsToCalculateDaysFor {
			totalsDaysForAllMonthsExceptLast += numberOfDaysInMonth(toYear, theMonth: month)
		}

		return totalsDaysForAllMonthsExceptLast + toDay
	}
	
	func numberOfDaysBetween(fromDate: AJDate, toDate: AJDate, excludeStartDate: Bool) -> Int {
		//case 1 - start and end yr/mth are the same
		if (fromDate.year == toDate.year && fromDate.month == toDate.month) {
            		let finalResult = daysOnlyAreDifferent(fromDate, toDate: toDate, excludeStartDate: excludeStartDate)
            		return finalResult
		}
		
		//case 2 - start and end yr are the same, months are different
		if (fromDate.year == toDate.year) {
            		let finalResult = monthsAndDaysAreDifferent(fromDate, toDate: toDate, excludeStartDate: excludeStartDate)
            		return finalResult
		}
		
		//case 3 - start and end year are different
		if (fromDate.year != toDate.year) {
            		let finalResult = startAndEndYearAreDifferent(fromDate, toDate: toDate, excludeStartDate: excludeStartDate)
            		return finalResult
		}
		return 0
	}
	
    	private func daysOnlyAreDifferent(fromDate: AJDate, toDate: AJDate, excludeStartDate: Bool) -> Int {
        
        	//first make sure the days are in sequence
        	var confirmedFromDate: AJDate = fromDate
        	var confirmedToDate: AJDate = toDate
        
        	if !isCorrectDateOrderSequence(fromDate, toDate: toDate) {
            		confirmedFromDate = toDate
            		confirmedToDate = fromDate
        	}
        
        	var finalResult = (confirmedToDate.day - confirmedFromDate.day)
        	if excludeStartDate {
            		finalResult = (finalResult - 1) < 0 ? 0 : finalResult - 1
        	}

	        return finalResult
    	}
    
    	private func monthsAndDaysAreDifferent(fromDate: AJDate, toDate: AJDate, excludeStartDate: Bool) -> Int {
        	//first make sure the months are in sequence
        	var confirmedFromDate: AJDate = fromDate
        	var confirmedToDate: AJDate = toDate
        
	        if !isCorrectDateOrderSequence(fromDate, toDate: toDate) {
	        	confirmedFromDate = toDate
            		confirmedToDate = fromDate
            	}
        
        	let firstMonthDays = confirmedFromDate.numberOfDaysUntilEndOfMonth
        
        	//get in between (if there are any) months total days
        	let requiredFromToMonths = Array(confirmedFromDate.month...confirmedToDate.month)
        
        	var fullMonthsTotal: Int = 0
        	if requiredFromToMonths.count > 2 {
            		let fullMonthElements = requiredFromToMonths.dropFirst().dropLast()
            		for month in fullMonthElements {
                		fullMonthsTotal += numberOfDaysInMonth(confirmedFromDate.year, theMonth: month)
            		}
        	}
        	let finalResult = firstMonthDays + fullMonthsTotal + confirmedToDate.day
        	return excludeStartDate ? finalResult - 1 : finalResult
    	}
    
    	private func startAndEndYearAreDifferent(fromDate: AJDate, toDate: AJDate, excludeStartDate: Bool) -> Int {
        	//make sure the years are in sequence (as per the BCG document - this test case
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
    
    	private func isCorrectDateOrderSequence(fromDate: AJDate, toDate: AJDate) -> Bool {
		if (fromDate.year > toDate.year) {
			return false
		}
		if (fromDate.year == toDate.year) && (fromDate.month > toDate.month) {
        		return false
        	}
        	if (fromDate.year == toDate.year) && (fromDate.month == toDate.month)  &&  (fromDate.day > toDate.day){
        		return false
        	}
		return true
	}
}
