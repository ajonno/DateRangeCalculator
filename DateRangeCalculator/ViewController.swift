//
import UIKit
import AVFoundation
import AVKit



//*****************************************************************************************************
//  PLEASE NOTE! I WAS LOW ON TIME TO GET THIS SUBMITTED AND SO PUT ALL UI ELEMENTS AND CODE IN THIS VC.
//  I WOULD **DEFINITELY**!! REFACTOR THIS CODE UNDER NORMAL CIRCUMSTANCES
//  HOWEVER I WANTED TO GET THIS UI PIECE DONE TO SHOW THAT I WANTED TO 
//  STAND OUT AND DO SOMETHING FUN AND A BIT DIFFERENT! 😀 (VS. GOOD OLE DATE PICKER..)
//  IT MIGHT NOT WIN A DESIGN AWARD BUT HEY... ;-)
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
    var thelabel = UILabel()
    
    
	@IBOutlet weak var dayCollectionView: UICollectionView!
    @IBOutlet weak var monthCollectionView: UICollectionView!
    @IBOutlet weak var yearCollectionView: UICollectionView!
	
    @IBOutlet weak var fromDay: UILabel!
    @IBOutlet weak var fromMonth: UILabel!
    @IBOutlet weak var fromYear: UILabel!
	
    @IBOutlet weak var toDay: UILabel!
    @IBOutlet weak var toMonth: UILabel!
    @IBOutlet weak var toYear: UILabel!

    @IBOutlet weak var resultLabel: UILabel!

	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
        //add labels to array
        let labelArray = [fromDay, fromMonth, fromYear, toDay, toMonth, toYear]
        
        dayCollectionView.dataSource = self
        dayCollectionView.delegate = self
        dayCollectionView.layer.masksToBounds = true
        dayCollectionView.layer.cornerRadius = 4
        dayCollectionView.hidden = true
        
        monthCollectionView.dataSource = self
        monthCollectionView.delegate = self
        monthCollectionView.layer.masksToBounds = true
        monthCollectionView.layer.cornerRadius = 4
        monthCollectionView.hidden = true

        yearCollectionView.dataSource = self
        yearCollectionView.delegate = self
        yearCollectionView.layer.masksToBounds = true
        yearCollectionView.layer.cornerRadius = 4
        yearCollectionView.hidden = true

        for label in labelArray {
            let tapGesture = UITapGestureRecognizer(target: self, action: "tappedDateView:")
            label.addGestureRecognizer(tapGesture)
        }
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

    func tappedDateView(sender:UITapGestureRecognizer){

        //if any other custom date picker elements are visible, hide them 
        if (dayCollectionView.hidden == false) {dayCollectionView.hidden = true}
        if (monthCollectionView.hidden == false) {monthCollectionView.hidden = true}
        if (yearCollectionView.hidden == false) {yearCollectionView.hidden = true}
        
        //let thelabel = sender.view as! UILabel
        thelabel = sender.view as! UILabel
        
        if thelabel.accessibilityIdentifier == SourceDate.FromDay.rawValue || thelabel.accessibilityIdentifier == SourceDate.FromMonth.rawValue || thelabel.accessibilityIdentifier == SourceDate.FromYear.rawValue  {
            positionCustomView1(thelabel)
        }
        
        if thelabel.accessibilityIdentifier == SourceDate.ToDay.rawValue || thelabel.accessibilityIdentifier == SourceDate.ToMonth.rawValue || thelabel.accessibilityIdentifier == SourceDate.ToYear.rawValue  {
            positionCustomView2(thelabel)
        }

       
    }
    
    private func positionCustomView1(thelabel: UILabel) {
        
        if thelabel.accessibilityIdentifier == SourceDate.FromDay.rawValue {
            dayCollectionView.frame = CGRectMake( dayCollectionView.frame.minX, fromDay.frame.maxY + 3, dayCollectionView.frame.size.width, dayCollectionView.frame.size.height ) // set new position exactly
            dayCollectionView.hidden = false
        }
        if thelabel.accessibilityIdentifier == SourceDate.FromMonth.rawValue {
            let fromMidX = fromMonth.frame.midX
            let fromMaxY = fromMonth.bounds.maxY + monthCollectionView.bounds.height + fromMonth.bounds.height
            let pos = CGPointMake(fromMidX, fromMaxY)
            
            monthCollectionView.center = pos
            monthCollectionView.hidden = false
        }
        if thelabel.accessibilityIdentifier == SourceDate.FromYear.rawValue {
            yearCollectionView.frame = CGRectMake( fromYear.frame.maxX - yearCollectionView.frame.width, fromYear.frame.maxY + 3, yearCollectionView.frame.size.width, yearCollectionView.frame.size.height )
            yearCollectionView.hidden = false
        }

    }
    
    private func positionCustomView2(thelabel: UILabel) {
    
        if thelabel.accessibilityIdentifier == SourceDate.ToDay.rawValue {
            dayCollectionView.frame = CGRectMake(dayCollectionView.frame.minX, toDay.frame.maxY + 3, dayCollectionView.frame.size.width, dayCollectionView.frame.size.height ) // set new position exactly
            dayCollectionView.hidden = false
        }
        if thelabel.accessibilityIdentifier == SourceDate.ToMonth.rawValue {
            let fromMidX = toMonth.frame.midX
            let fromMaxY = toMonth.frame.maxY + monthCollectionView.bounds.height/2 + 3 // toMonth.bounds.height
            let pos = CGPointMake(fromMidX, fromMaxY)
            
            monthCollectionView.center = pos
            monthCollectionView.hidden = false
        }
        if thelabel.accessibilityIdentifier == SourceDate.ToYear.rawValue {
            yearCollectionView.frame = CGRectMake( toYear.frame.maxX - yearCollectionView.frame.width, toYear.frame.maxY + 3, yearCollectionView.frame.size.width, yearCollectionView.frame.size.height ) // set new position exactly
            
            yearCollectionView.hidden = false
        }
    }

 
    @IBAction func tappedCalculateButton(sender: UIButton) {
        
        
        //build from date
        let fromDate = AJDate(theDay: convertToInt(fromDay.text!), theMonth: convertMonthStringToInt(fromMonth.text!), theYear: convertToInt(fromYear.text!))!
  
       let toDate = AJDate(theDay: convertToInt(toDay.text!), theMonth: convertMonthStringToInt(toMonth.text!), theYear: convertToInt(toYear.text!))!

        let total = fromDate.numberOfDaysBetween(fromDate, toDate: toDate, excludeStartDate: true)
        resultLabel.text = String(total) + (total > 1 ? " days" : " day")
        print(total)
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
        // If you need to use the touched cell, you can retrieve it like so
       
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
       
        if collectionView == self.dayCollectionView {
            print("touched cell at indexPath \(indexPath.row) value is: \(String(daysOfMonth[indexPath.row]))")
            if thelabel.accessibilityIdentifier == SourceDate.FromDay.rawValue {
                fromDay.text = (String(daysOfMonth[indexPath.row]))
            } else {
                toDay.text = (String(daysOfMonth[indexPath.row]))
            }
            dayCollectionView.hidden = true
        }
        
        if collectionView == self.monthCollectionView {
            print("touched cell at indexPath \(indexPath.row) value is: \(String(months[indexPath.row]))")
            if thelabel.accessibilityIdentifier == SourceDate.FromMonth.rawValue {
                fromMonth.text = months[indexPath.row]
            } else {
                toMonth.text = months[indexPath.row]
            }
            monthCollectionView.hidden = true
        }
        
        if collectionView == self.yearCollectionView {
            print("touched cell at indexPath \(indexPath.row) value is: \(String(years[indexPath.row]))")
            if thelabel.accessibilityIdentifier == SourceDate.FromYear.rawValue {
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

