//
import UIKit
import AVFoundation
import AVKit



//*****************************************************************************************************
//  PLEASE NOTE! I WAS LOW ON TIME TO GET THIS SUBMITTED AND SO PUT ALL UI ELEMENTS AND CODE IN THIS VC.
//  I WOULD **DEFINITELY**!! REFACTOR THIS CODE UNDER NORMAL CIRCUMSTANCES. 
//  HOWEVER I WANTED TO GET THIS UI PIECE DONE TO SHOW THAT I WANTED TO 
//  STAND OUT AND DO SOMETHING FUN AND A BIT DIFFERENT! 😀 (VS. GOOD OLE DATE PICKER..)
//  IT MIGHT NOT WIN A DESIGN AWARD BUT HEY... ;-)
//*****************************************************************************************************
class ViewController: UIViewController {

	
    let daysOfMonth = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
    let months = ["Jan", "Feb", "Mar","Apr", "May", "Jun","Jul", "Aug","Sep","Oct","Nov", "Dec"]
    let years = Array(1901...2999)
    let startYear = 2016  //* I DIDNT WANT TO TOUCH ANY DATE CLASSES SO JUST FOR THIS EXERCISE POPPED THIS IN HERE
    
	@IBOutlet weak var dayCollectionView: UICollectionView!
    @IBOutlet weak var monthCollectionView: UICollectionView!
    @IBOutlet weak var yearCollectionView: UICollectionView!
	
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
        dayCollectionView.dataSource = self
        dayCollectionView.delegate = self
        dayCollectionView.layer.masksToBounds = true
        dayCollectionView.layer.cornerRadius = 4
        
        monthCollectionView.dataSource = self
        monthCollectionView.delegate = self
        monthCollectionView.layer.masksToBounds = true
        monthCollectionView.layer.cornerRadius = 4

        yearCollectionView.dataSource = self
        yearCollectionView.delegate = self
        yearCollectionView.layer.masksToBounds = true
        yearCollectionView.layer.cornerRadius = 4

        
        
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

    override func viewDidLayoutSubviews() {
        let startYearPosition = years.indexOf(2016)
        let indexPath = NSIndexPath(forRow: startYearPosition!, inSection: 0)
        yearCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredVertically, animated: false)
        
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

