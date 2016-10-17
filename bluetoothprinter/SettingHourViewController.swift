//
//  SettingHourViewController.swift
//  bluetoothprinter
//
//  Created by Rui Caneira on 10/13/16.
//  Copyright © 2016 Rui Caneira. All rights reserved.
//

import UIKit

class SettingHourViewController: UIViewController {
    
    
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var viewTitle: UIView!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var viewHours: [UIView]!
    @IBOutlet var btnStartAM: [UIButton]!
    @IBOutlet var btnStartTime: [UIButton]!
    @IBOutlet var btnEndAM: [UIButton]!
    @IBOutlet var btnEndtime: [UIButton]!
    @IBOutlet var CoverView: UIView!
    @IBOutlet var DialogView: UIView!
    @IBOutlet var btnSelectTime: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    
    var mday : mmweekday!
    
    var mtitle : String!
    var dayIndex : Int!
    var fixedIndex : Int!
    let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initData()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        
        lblDate.text = mtitle
        viewTitle.layer.cornerRadius = 5
        btnSave.layer.cornerRadius = 5
        DialogView.layer.cornerRadius = 10
        btnSelectTime.layer.cornerRadius = 5
        
    }
    
    func initData(){
    
        switch mtitle {
        case "Sunday":
            self.mday = self.appdelegate.orders.mdata.maccount.mweek.msunday
        case "Monday":
            self.mday = self.appdelegate.orders.mdata.maccount.mweek.mmonday
        case "Tuesday":
            self.mday = self.appdelegate.orders.mdata.maccount.mweek.mtuesday
        case "Wednesday":
            self.mday = self.appdelegate.orders.mdata.maccount.mweek.mwednesday
        case "Thursday":
            self.mday = self.appdelegate.orders.mdata.maccount.mweek.mthursday
        case "Friday":
            self.mday = self.appdelegate.orders.mdata.maccount.mweek.mfriday
        case "Saturday":
           self.mday = self.appdelegate.orders.mdata.maccount.mweek.msaturday
        default: break
        }
        
        var count = self.mday.mranges.count
        if count > 3 {
            count = 3
        }else if count == 0 {
            return
        }
        
        for index in 0...count - 1 {
            viewHours[index].layer.hidden = false
            let mStarthour = self.mday.mranges[index].mstart.mhour
            let mStartmin = self.mday.mranges[index].mstart.mminute
            let mEndhour = self.mday.mranges[index].mend.mhour
            let mEndmin = self.mday.mranges[index].mend.mminute
            var mStartMinute = ""
            var mEndMinute = ""
            if mStartmin < 10 {
                mStartMinute = "0" + String(mStartmin)
            }else{
                mStartMinute = String(mStartmin)
            }
            if mEndmin < 10 {
                mEndMinute = "0" + String(mEndmin)
            }else{
                mEndMinute = String(mEndmin)
            }
            if mStarthour > 12 {
                btnStartTime[index].setTitle("\(mStarthour! - 12):" + mStartMinute , forState: .Normal)
                btnStartAM[index].setTitle("pm", forState: .Normal)
            }else{
                btnStartTime[index].setTitle(String(mStarthour) + ":" + mStartMinute , forState: .Normal)
            }
            
            if mEndhour > 12 {
                btnEndtime[index].setTitle(String(mEndhour! - 12) + ":" + mEndMinute , forState: .Normal)
                btnEndAM[index].setTitle("pm", forState: .Normal)
            }else{
                btnEndtime[index].setTitle(String(mEndhour) + ":" + mEndMinute , forState: .Normal)
            }
        }
    }

    @IBAction func actionSave(sender: AnyObject) {
        switch mtitle {
        case "Sunday":
            self.appdelegate.orders.mdata.maccount.mweek.msunday = self.mday
        case "Monday":
            self.appdelegate.orders.mdata.maccount.mweek.mmonday = self.mday
        case "Tuesday":
            self.appdelegate.orders.mdata.maccount.mweek.mtuesday = self.mday
        case "Wednesday":
            self.appdelegate.orders.mdata.maccount.mweek.mwednesday = self.mday
        case "Thursday":
            self.appdelegate.orders.mdata.maccount.mweek.mthursday = self.mday
        case "Friday":
            self.appdelegate.orders.mdata.maccount.mweek.mfriday = self.mday
        case "Saturday":
            self.appdelegate.orders.mdata.maccount.mweek.msaturday = self.mday
        default: break
        }

        let hourViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("hourViewController") as? HourViewController
        
    
        self.presentViewController(hourViewController!, animated: true, completion: nil)
    }
    
    @IBAction func actionAddNewHour(sender: AnyObject) {
    
        var melement = mmranges()
        melement.mstart.mhour = 0
        melement.mstart.mminute = 0
        melement.mend.mhour = 0
        melement.mend.mminute = 0
        for index in 0...2{
            if viewHours[index].layer.hidden == true {
                viewHours[index].layer.hidden = false
                self.mday.mranges.append(melement)
                return
            }
        }
    }
    
    @IBAction func actionRemoveHour(sender: AnyObject) {
        for index in 0...2{
            if viewHours[2 - index].layer.hidden == false {
                viewHours[2 - index].layer.hidden = true
                self.mday.mranges.removeAtIndex(2 - index)
                return
            }
        }
      
    }
    
    @IBAction func ActionSelectTimer(sender: UIButton) {
        CoverView.layer.hidden = false
        DialogView.layer.hidden = false
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat =  "HH:mm"

        var mhour : Int = 0
        var mmin : Int = 0
        
        switch sender.tag {
        case 1:
            mhour = self.mday.mranges[0].mstart.mhour!
            mmin = self.mday.mranges[0].mstart.mminute!
            fixedIndex = 1
        case 2:
            mhour = self.mday.mranges[0].mend.mhour!
            mmin = self.mday.mranges[0].mend.mminute!
            fixedIndex = 2
        case 3:
            mhour = self.mday.mranges[1].mstart.mhour!
            mmin = self.mday.mranges[1].mstart.mminute!
            fixedIndex = 3
        case 4:
            mhour = self.mday.mranges[1].mend.mhour!
            mmin = self.mday.mranges[1].mend.mminute!
            fixedIndex = 4
        case 5:
            mhour = self.mday.mranges[2].mstart.mhour!
            mmin = self.mday.mranges[2].mstart.mminute!
            fixedIndex = 5
        case 6:
            mhour = self.mday.mranges[2].mend.mhour!
            mmin = self.mday.mranges[2].mend.mminute!
            fixedIndex = 6
       default: break
        }

       let date = dateFormatter.dateFromString(String(mhour) + ":" + String(mmin))
        datePicker.date = date!
        
        
    }
    
    @IBAction func actionOK(sender: AnyObject) {
        CoverView.layer.hidden = true
        DialogView.layer.hidden = true
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat =  "HH"
        let fixedHour = dateFormatter.stringFromDate(datePicker.date)
        dateFormatter.dateFormat =  "mm"
        let fixedMin = dateFormatter.stringFromDate(datePicker.date)
        
        setTime(fixedHour, fixedMin: fixedMin)
    }
    
    func setTime(fixedHour : String, fixedMin : String){
        switch fixedIndex{
        case 1:
            btnStartTime[0].setTitle(String(fixedHour) + ":" + String(fixedMin), forState: .Normal)
            btnStartAM[0].setTitle("am", forState: .Normal)
            self.mday.mranges[0].mstart.mhour = Int(fixedHour)
            self.mday.mranges[0].mstart.mminute = Int(fixedMin)
        case 2:
            btnEndtime[0].setTitle(String(fixedHour) + ":" + String(fixedMin), forState: .Normal)
            btnEndAM[0].setTitle("am", forState: .Normal)
            self.mday.mranges[0].mend.mhour = Int(fixedHour)
            self.mday.mranges[0].mend.mminute = Int(fixedMin)
        case 3:
            btnStartTime[1].setTitle(String(fixedHour) + ":" + String(fixedMin), forState: .Normal)
            btnStartAM[1].setTitle("am", forState: .Normal)
            self.mday.mranges[1].mstart.mhour = Int(fixedHour)
            self.mday.mranges[1].mstart.mminute = Int(fixedMin)
        case 4:
            btnEndtime[1].setTitle(String(fixedHour) + ":" + String(fixedMin), forState: .Normal)
            btnEndAM[1].setTitle("am", forState: .Normal)
            self.mday.mranges[1].mend.mhour = Int(fixedHour)
            self.mday.mranges[1].mend.mminute = Int(fixedMin)
        case 5:
            btnStartTime[2].setTitle(String(fixedHour) + ":" + String(fixedMin), forState: .Normal)
            btnStartAM[2].setTitle("am", forState: .Normal)
            self.mday.mranges[2].mstart.mhour = Int(fixedHour)
            self.mday.mranges[2].mstart.mminute = Int(fixedMin)
        case 6:
            btnEndtime[2].setTitle(String(fixedHour) + ":" + String(fixedMin), forState: .Normal)
            btnEndAM[2].setTitle("am", forState: .Normal)
            self.mday.mranges[2].mend.mhour = Int(fixedHour)
            self.mday.mranges[2].mend.mminute = Int(fixedMin)
        default: break
        }
        
    }
    
    
}



