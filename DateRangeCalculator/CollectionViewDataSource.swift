//
//  CollectionViewDataSource.swift
//  DateRangeCalculator
//
//  Created by Angus Johnston on 20/01/2016.
//  Copyright © 2016 Angus Johnston. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDataSource {
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.dayCollectionView {
            return daysOfMonth.count
        }
        
        if collectionView == self.monthCollectionView {
            return months.count
        }
        
        if collectionView == self.yearCollectionView {
            return years.count
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        if collectionView == self.dayCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("daysInMonthCell", forIndexPath: indexPath) as! DayCell
            
            cell.dayLabel.text = String(daysOfMonth[indexPath.row])
            
            return cell
        }
        
        if collectionView == self.monthCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("monthCell", forIndexPath: indexPath) as! MonthCell
            
            cell.monthLabel.text = months[indexPath.row]
            
            return cell
        }
        
        if collectionView == self.yearCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("yearCell", forIndexPath: indexPath) as! YearCell
            
            cell.yearLabel.text = String(years[indexPath.row])
            
            return cell
        }
        
        return cell
        
    }
    
    
    
}
