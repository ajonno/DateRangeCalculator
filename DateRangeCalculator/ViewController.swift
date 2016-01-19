//
//  ViewController.swift
//  DateRangeCalculator
//
//  Created by Angus Johnston on 18/01/2016.
//  Copyright © 2016 Angus Johnston. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

	
    let daysOfMonth = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
    let months = ["Jan", "Feb", "Mar","Apr", "May", "Jun","Jul", "Aug","Sep","Oct","Nov", "Dec"]

    
	@IBOutlet weak var dayCollectionView: UICollectionView!
    @IBOutlet weak var monthCollectionView: UICollectionView!
	
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
        dayCollectionView.dataSource = self
        dayCollectionView.delegate = self
        
        
        dayCollectionView.layer.cornerRadius = 5

        monthCollectionView.dataSource = self
        monthCollectionView.delegate = self

        monthCollectionView.layer.masksToBounds = true
        monthCollectionView.layer.cornerRadius = 4
        
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

extension ViewController: UICollectionViewDelegateFlowLayout {
	
}

extension ViewController: UICollectionViewDataSource {
	

	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        if collectionView == self.dayCollectionView {
            return daysOfMonth.count
        }

        if collectionView == self.monthCollectionView {
            return months.count
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

        return cell
        
    }
	
	
	
}

