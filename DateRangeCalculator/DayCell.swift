//
//  DayCell.swift
//  DateRangeCalculator
//
//  Created by Angus Johnston on 19/01/2016.
//  Copyright © 2016 Angus Johnston. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
	
	@IBOutlet weak var dayLabel: UILabel!
    
	required init?(coder aDecoder: NSCoder) {
        	super.init(coder: aDecoder)
        
        	self.layer.masksToBounds = true
        	self.layer.cornerRadius = 7
    	}
}
