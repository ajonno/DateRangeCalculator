//
//  CollectionViewDelegate.swift
//  DateRangeCalculator
//
//  Created by Angus Johnston on 20/01/2016.
//  Copyright © 2016 Angus Johnston. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //reset state for tapping label(s)
        for label in labelArray {
            label.userInteractionEnabled = true
        }
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        if collectionView == self.dayCollectionView {
            print("touched cell at indexPath \(indexPath.row) value is: \(String(daysOfMonth[indexPath.row]))")
            if userDataLabel.accessibilityIdentifier == SourceDate.FromDay.rawValue {
                fromDay.text = (String(daysOfMonth[indexPath.row]))
            } else {
                toDay.text = (String(daysOfMonth[indexPath.row]))
            }
            dayCollectionView.hidden = true
        }
        
        if collectionView == self.monthCollectionView {
            print("touched cell at indexPath \(indexPath.row) value is: \(String(months[indexPath.row]))")
            if userDataLabel.accessibilityIdentifier == SourceDate.FromMonth.rawValue {
                fromMonth.text = months[indexPath.row]
            } else {
                toMonth.text = months[indexPath.row]
            }
            monthCollectionView.hidden = true
        }
        
        if collectionView == self.yearCollectionView {
            print("touched cell at indexPath \(indexPath.row) value is: \(String(years[indexPath.row]))")
            if userDataLabel.accessibilityIdentifier == SourceDate.FromYear.rawValue {
                fromYear.text = String(years[indexPath.row])
            } else {
                toYear.text = String(years[indexPath.row])
            }
            yearCollectionView.hidden = true
        }
    }
}
