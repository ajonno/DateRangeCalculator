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




struct AJDate {
	
	private(set) var day: Int
	private(set) var month: Int
	private(set) var year: Int
	
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
		switch (month) {
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
		default: return 31
		}
	}
	
	
}
