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


class AJDate {
	
	private let day: Int
	private let month: Int
	private let year: Int
	
	let MINIMUM_YEAR: Int = 1000
	let MAXIMUM_YEAR: Int = 2222
	
	
	init?(theDay: Int, theMonth: Int, theYear: Int) {
		
		self.day = theDay
		self.month = theMonth
		self.year = theYear
		
		if !isValid(year, month: month, day: day) {
			return nil
		}
	}
	
	func isValid(year: Int, month: Int, day: Int) -> Bool {
		
		if year < 0	|| (year < MINIMUM_YEAR || year > MAXIMUM_YEAR)
		{
			return false
		}
		if month < 1 || month > 12	{return false}
		if day < 1 || day > 31		{return false}
	
		switch (month) {
			case 1: return true
			case 2: return isLeapYear() ? day <= 29 : day <= 28
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
	
	func isLeapYear() -> Bool {
		
		guard (self.year-2000)%4 == 0 else {
			return false
		}
		
		guard (self.year)%100 != 0 else {
			return false
		}
		
		guard (self.year)%400 == 0 else {
			return true
		}
		
		return false
	}

	
	

}
