//
import UIKit
import AVFoundation
import AVKit


//*****************************************************************************************************
//  PLEASE NOTE! I WAS LOW ON TIME TO GET THIS SUBMITTED AND SO PUT ALL UI ELEMENTS AND CODE IN THIS VC.
//  I WOULD **DEFINITELY**!! REFACTOR THIS SOMEWHAT MVC UNDER NORMAL CIRCUMSTANCES
//  HOWEVER I WANTED TO GET THIS UI PIECE DONE TO SHOW THAT I WANTED TO 
//  DO SOMETHING FUN AND A BIT DIFFERENT! 😀
//*****************************************************************************************************
class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    enum SourceDate : String {
        case FromDay = "fromDay"
        case FromMonth = "fromMonth"
        case FromYear = "fromYear"
        case ToDay = "toDay"
        case ToMonth = "toMonth"
        case ToYear = "toYear"
    }
  
    let daysOfMonth = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
    let months = ["Jan", "Feb", "Mar","Apr", "May", "Jun","Jul", "Aug","Sep","Oct","Nov", "Dec"]
    let years = Array(1901...2999)
    let startYear = 2016  //* I DIDNT WANT TO TOUCH ANY DATE CLASSES SO JUST FOR THIS EXERCISE POPPED THIS IN HERE
    var userDataLabel = UILabel()
    var labelArray = [UILabel]()
    
	@IBOutlet weak var dayCollectionView: UICollectionView!
    @IBOutlet weak var monthCollectionView: UICollectionView!
    @IBOutlet weak var yearCollectionView: UICollectionView!
	
    @IBOutlet weak var fromDay: UILabel!
    @IBOutlet weak var fromMonth: UILabel!
    @IBOutlet weak var fromYear: UILabel!
	
    @IBOutlet weak var toDay: UILabel!
    @IBOutlet weak var toMonth: UILabel!
    @IBOutlet weak var toYear: UILabel!

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!

	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
        //add labels that hold the dates user has chosen to array
        labelArray = [fromDay, fromMonth, fromYear, toDay, toMonth, toYear]
        
        initialiseDayCollectionView()
        initialiseMonthCollectionView()
        initialiseYearCollectionView()
     
        for label in labelArray {
            let tapGesture = UITapGestureRecognizer(target: self, action: "tappedDateView:")
            label.addGestureRecognizer(tapGesture)
            label.userInteractionEnabled = true
        }
        
        let startYearPosition = years.indexOf(2016)
        let indexPath = NSIndexPath(forRow: startYearPosition!, inSection: 0)
        yearCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredVertically, animated: false)

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


    private func initialiseDayCollectionView() {
        dayCollectionView.dataSource = self
        dayCollectionView.delegate = self
        dayCollectionView.layer.masksToBounds = true
        dayCollectionView.layer.cornerRadius = 4
        dayCollectionView.hidden = true
        
        dayCollectionView.frame = CGRectMake(5, fromDay.frame.maxY + 3, screenBounds.width - 10, 56)
    }

    private func initialiseMonthCollectionView() {
        monthCollectionView.dataSource = self
        monthCollectionView.delegate = self
        monthCollectionView.layer.masksToBounds = true
        monthCollectionView.layer.cornerRadius = 4
        monthCollectionView.hidden = true
    }
    
    private func initialiseYearCollectionView() {
        yearCollectionView.dataSource = self
        yearCollectionView.delegate = self
        yearCollectionView.layer.masksToBounds = true
        yearCollectionView.layer.cornerRadius = 4
        yearCollectionView.hidden = true
    }
    
    func tappedDateView(sender:UITapGestureRecognizer){

        //if any other custom date picker elements are visible, hide them
        if (dayCollectionView.hidden == false) {dayCollectionView.hidden = true}
        if (monthCollectionView.hidden == false) {monthCollectionView.hidden = true}
        if (yearCollectionView.hidden == false) {yearCollectionView.hidden = true}
        
        userDataLabel = sender.view as! UILabel
        if userDataLabel.userInteractionEnabled == true {
            userDataLabel.userInteractionEnabled = false
        }
        
        if userDataLabel.accessibilityIdentifier == SourceDate.FromDay.rawValue || userDataLabel.accessibilityIdentifier == SourceDate.FromMonth.rawValue || userDataLabel.accessibilityIdentifier == SourceDate.FromYear.rawValue  {
            positionFromViewLookupControls(userDataLabel)
        }
        
        if userDataLabel.accessibilityIdentifier == SourceDate.ToDay.rawValue || userDataLabel.accessibilityIdentifier == SourceDate.ToMonth.rawValue || userDataLabel.accessibilityIdentifier == SourceDate.ToYear.rawValue  {
            positionToViewLookupControls(userDataLabel)
        }

       
    }
    
    private func positionFromViewLookupControls(userDataLabel: UILabel) {
        
        if userDataLabel.accessibilityIdentifier == SourceDate.FromDay.rawValue {
            dayCollectionView.frame = CGRectMake(5, fromDay.frame.maxY + 3, screenBounds.width - 10, 56)
            dayCollectionView.hidden = false
        }
        if userDataLabel.accessibilityIdentifier == SourceDate.FromMonth.rawValue {
            let fromMidX = fromMonth.frame.midX
            let fromMaxY = fromMonth.bounds.maxY + monthCollectionView.bounds.height + fromMonth.bounds.height + 20
            let pos = CGPointMake(fromMidX, fromMaxY)
            monthCollectionView.center = pos
            monthCollectionView.frame = CGRectMake(monthCollectionView.frame.minX, fromMonth.frame.maxY + 3, monthCollectionView.frame.width, monthCollectionView.frame.height + 10)
            monthCollectionView.hidden = false
        }
        if userDataLabel.accessibilityIdentifier == SourceDate.FromYear.rawValue {
            yearCollectionView.frame = CGRectMake( fromYear.frame.maxX - yearCollectionView.frame.width, fromYear.frame.maxY + 4, yearCollectionView.frame.size.width, yearCollectionView.frame.size.height )
            yearCollectionView.hidden = false
        }

    }
    
    private func positionToViewLookupControls(userDataLabel: UILabel) {

        if userDataLabel.accessibilityIdentifier == SourceDate.ToDay.rawValue {
            dayCollectionView.frame = CGRectMake(5, toDay.frame.maxY + 1, screenBounds.width - 10, 56)
            dayCollectionView.hidden = false
        }
        if userDataLabel.accessibilityIdentifier == SourceDate.ToMonth.rawValue {
            let fromMidX = toMonth.frame.midX
            let fromMaxY = toMonth.frame.maxY + monthCollectionView.frame.height/2 + 3
            let pos = CGPointMake(fromMidX, fromMaxY)
            monthCollectionView.frame = CGRectMake(monthCollectionView.frame.minX, fromMonth.frame.maxY + 3, monthCollectionView.frame.width, monthCollectionView.frame.height + 15)
            monthCollectionView.center = pos

            monthCollectionView.hidden = false
        }
        if userDataLabel.accessibilityIdentifier == SourceDate.ToYear.rawValue {
            yearCollectionView.frame = CGRectMake( toYear.frame.maxX - yearCollectionView.frame.width, toYear.frame.maxY + 3, yearCollectionView.frame.size.width, yearCollectionView.frame.size.height )
            yearCollectionView.hidden = false
        }
    }

 
    @IBAction func tappedCalculateButton(sender: UIButton) {
        
        //build from date
        let fromDate = AJDate(theDay: convertToInt(fromDay.text!), theMonth: convertMonthStringToInt(fromMonth.text!), theYear: convertToInt(fromYear.text!))!
  
        let toDate = AJDate(theDay: convertToInt(toDay.text!), theMonth: convertMonthStringToInt(toMonth.text!), theYear: convertToInt(toYear.text!))!

        let total = fromDate.numberOfDaysBetween(fromDate, toDate: toDate, excludeStartDate: true)
        if ( total == 1) {
            resultLabel.text = String(total) + " day"
        } else {
            resultLabel.text = String(total) + " days"
        }
    }
   
    private func convertToInt(stringValue: String) -> Int {
        if let intVersion = Int(stringValue) {
            return intVersion
        } else {
            return 0
        }
    }

    private func convertMonthStringToInt(stringValue: String) -> Int {
        let monthValue = 0
        for month in Month.allValues {
            let monthString = String(month)
            if monthString == stringValue {
                return month.rawValue
            }
        }
        return monthValue
    }
    
}

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

