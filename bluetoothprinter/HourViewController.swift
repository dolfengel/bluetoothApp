//
//  HourViewController.swift
//  bluetoothprinter
//
//  Created by Rui Caneira on 10/12/16.
//  Copyright © 2016 Rui Caneira. All rights reserved.
//

import UIKit
import MRProgress

class HourViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var btnSave: UIButton!
    
    @IBOutlet var btnTimezone: UIButton!
    @IBOutlet var txtPrepTime: UITextField!
    @IBOutlet var btnDay: [UIButton]!
    @IBOutlet var btnOpen: [UIButton]!
    
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
//        let screenRect = UIScreen.mainScreen().bounds
//        let screenWidth = screenRect.size.width
//        
//        //Setting the right content size - only height is being calculated depenging on content.
//        let height = self.btnSave.frame.maxY + 15
//        let contentSize = CGSizeMake(screenWidth, height);
//        self.scrollView.contentSize = contentSize;
//        
        btnTimezone.layer.borderWidth = 1
        btnTimezone.layer.cornerRadius = 5
        btnTimezone.layer.borderColor = UIColor(colorLiteralRed: 0.7556, green: 0.7556, blue: 0.7556, alpha: 1.0).CGColor
        
        txtPrepTime.layer.borderWidth = 1
        txtPrepTime.layer.cornerRadius = 5
        txtPrepTime.layer.borderColor = UIColor(colorLiteralRed: 0.7556, green: 0.7556, blue: 0.7556, alpha: 1.0).CGColor
        
        btnSave.layer.cornerRadius = 5
        
        for index in 0...6 {
          btnDay[index].layer.cornerRadius = 5
        }
    }
    
    func initData(){
        btnTimezone.setTitle(self.appdelegate.orders.mdata.maccount.mtimezone , forState: .Normal)
        txtPrepTime.text = String(self.appdelegate.orders.mdata.maccount.mprepTime)
        
        switch self.appdelegate.orders.mdata.maccount.mopen {
        case "OPEN":
            btnOpen[0].setImage(UIImage(named: "check_on"), forState: .Normal)
        case "CLOSED":
            btnOpen[1].setImage(UIImage(named: "check_on"), forState: .Normal)
        case "PERIODS":
            btnOpen[2].setImage(UIImage(named: "check_on"), forState: .Normal)
        default: break
        }
    }
    
    @IBAction func ActionOpen(sender: UIButton) {
        
        switch sender.titleLabel!.text! {
        case "Open":
            btnOpen[0].setImage(UIImage(named: "check_on"), forState: .Normal)
            btnOpen[1].setImage(UIImage(named: "check_off"), forState: .Normal)
            btnOpen[2].setImage(UIImage(named: "check_off"), forState: .Normal)
            self.appdelegate.orders.mdata.maccount.mopen = "OPEN"
        case "Closed":
            btnOpen[0].setImage(UIImage(named: "check_off"), forState: .Normal)
            btnOpen[1].setImage(UIImage(named: "check_on"), forState: .Normal)
            btnOpen[2].setImage(UIImage(named: "check_off"), forState: .Normal)
            self.appdelegate.orders.mdata.maccount.mopen = "CLOSED"
        case "Periods":
            btnOpen[0].setImage(UIImage(named: "check_off"), forState: .Normal)
            btnOpen[1].setImage(UIImage(named: "check_off"), forState: .Normal)
            btnOpen[2].setImage(UIImage(named: "check_on"), forState: .Normal)
            self.appdelegate.orders.mdata.maccount.mopen = "PERIODS"
        default:
            break
        }

    }
    
    
    
    @IBAction func btnChangeScene(sender: UIButton) {
        
        let menuViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MenuViewController") as? MenuViewController
        self.presentViewController(menuViewController!, animated: true, completion: nil)
        
        
    }
    
    @IBAction func ActionSelectTimeZone(sender: AnyObject) {
        let selecttimezoneViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TimeZoneSelectViewController") as? TimeZoneSelectViewController
        self.presentViewController(selecttimezoneViewController!, animated: true, completion: nil)
        
    }
    
    @IBAction func ActionSelectDay(sender: UIButton) {

        let settinghourViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SettingHourViewController") as? SettingHourViewController
                settinghourViewController!.mtitle = sender.titleLabel?.text
        self.presentViewController(settinghourViewController!, animated: true, completion: nil)
        
    }
    
    @IBAction func ActionUploadingHours(sender: UIButton) {
        
//        var hourResponse : AYResponse!
//        
//        let userNameKeyConstant = "userNameKey"
//        let userpassKeyConstant = "usePassKey"
//
//        
//        var params :[String: AnyObject]?
////        var resWeek : [String: AnyObject]?
//        params = [ AYUploadHour.TYPE: "update hours",
//                   AYUploadHour.VERSION: appdelegate.orders.mdata.mversion,
//                   AYUploadHour.KEY: appdelegate.defaults.stringForKey(userNameKeyConstant) as! AnyObject,
//                   AYUploadHour.AUTH: appdelegate.defaults.stringForKey(userpassKeyConstant) as! AnyObject,
//                   AYUploadHour.DATA: resWeek as mmaccount,
//                   AYUploadHour.PREPTIME: appdelegate.orders.mdata.maccount.mprepTime as AnyObject]
//        
//        MRProgressOverlayView.showOverlayAddedTo(self.scrollView!, animated: true)
//        Net.connectHour(params!).onSuccess(callback: {(list) -> Void in    // in net class
//            MRProgressOverlayView.dismissOverlayForView(self.scrollView, animated: true)
//            hourResponse = list
//            print(list)
//            
//            if hourResponse.mtype == "SUCCESS" {
//                
//                let alertResponse = UIAlertController(title: "Success!", message: "You uploaded the data successfully.", preferredStyle: .Alert)
//                let ResponseAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//                alertResponse.addAction(ResponseAction)
//                
//                self.presentViewController(alertResponse, animated: true, completion: nil)
//            }
//            
//        }).onFailure(callback: { (_) -> Void in
//            print("failed")
//            MRProgressOverlayView.dismissOverlayForView(self.scrollView!, animated: true)
//        })     
    }
    
    
}
