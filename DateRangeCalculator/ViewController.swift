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

	
	@IBOutlet weak var dayCollectionView: UICollectionView!
	
	
	
	
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		

        dayCollectionView.dataSource = self
        dayCollectionView.delegate = self
        
		
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
		return 12
	}
	

	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("daysInMonthCell", forIndexPath: indexPath) as! DayCell
		
		return cell
		
	}
	
	
	
}

