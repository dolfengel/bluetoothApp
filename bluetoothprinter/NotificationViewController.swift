//
//  NotificationViewController.swift
//  bluetoothprinter
//
//  Created by Rui Caneira on 10/12/16.
//  Copyright © 2016 Rui Caneira. All rights reserved.
//

import UIKit
import MRProgress

class NotificationViewController: UIViewController, UITextViewDelegate {
    
    let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet var NotificationViews: [UIView]!
    
    @IBOutlet var NotificationTitle: UIView!
    @IBOutlet var btnTypes: [UIButton]!
    @IBOutlet var txtTypeContent: [UITextField]!
    
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var loadingView: UIView!
    
    var Booluploading = [Bool?](count:3, repeatedValue:true)
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
        
        NotificationTitle.layer.cornerRadius = 5
        btnSave.layer.cornerRadius = 5
        
        
    }
    
    func initData(){
        var countType = self.appdelegate.orders.mdata.maccount.mnotifyList.count
        
        if countType > 3 {
            countType = 3
        }
        
        for index in 0...countType - 1 {
            NotificationViews[index].layer.hidden = false
            
            switch self.appdelegate.orders.mdata.maccount.mnotifyList[index].mtype {
            case "EMAIL":
                btnTypes[index].setTitle("Email" , forState: .Normal)
                txtTypeContent[index].text = self.appdelegate.orders.mdata.maccount.mnotifyList[index].mto
            case "VOICE":
                btnTypes[index].setTitle("Phone Call" , forState: .Normal)
                txtTypeContent[index].text = MakingsubString(self.appdelegate.orders.mdata.maccount.mnotifyList[index].mto)
            case "TEXT":
                btnTypes[index].setTitle("Text Message" , forState: .Normal)
                txtTypeContent[index].text = MakingsubString(self.appdelegate.orders.mdata.maccount.mnotifyList[index].mto)
            default: break
            }
            
        }

    }
    
    func MakingsubString(mtext:String) -> (String){
        let prefix = String(String(mtext).characters.prefix(3))
        let suffix = String(String(mtext).characters.suffix(4))
        let premidfix = String(String(mtext).characters.prefix(6))
        let midfix = String(String(premidfix).characters.suffix(3))
        let comText = "( " + prefix + " ) " + midfix + " - " + suffix
        return (comText)
    }
    
    
    @IBAction func btnChangeScene(sender: UIButton) {
        
        let selectitemViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MenuViewController") as? MenuViewController
        
        self.presentViewController(selectitemViewController!, animated: true, completion: nil)
        
    }
    
    
    @IBAction func ActionEditBegin(sender: UITextField) {
        sender.text = self.appdelegate.orders.mdata.maccount.mnotifyList[sender.tag].mto
    }
    
    
    @IBAction func ActionTextEnd(sender: UITextField) {
        switch self.appdelegate.orders.mdata.maccount.mnotifyList[sender.tag].mtype {
        case "EMAIL":
            if isValidEmail(sender.text!) == true {
                self.appdelegate.orders.mdata.maccount.mnotifyList[sender.tag].mto = sender.text!
                sender.layer.borderColor = UIColor(colorLiteralRed: 0.7556, green: 0.7556, blue: 0.7556, alpha: 0.8).CGColor
                Booluploading[0] = true
            }else{
                sender.layer.borderWidth = 1
                sender.layer.borderColor = UIColor(colorLiteralRed: 0.7556, green: 0.115, blue: 0.115, alpha: 0.8).CGColor
                Booluploading[0] = false
            }
        case "VOICE":
            if isPhoneValidate(sender.text!) == true {
                self.appdelegate.orders.mdata.maccount.mnotifyList[sender.tag].mto = sender.text!
                sender.text = MakingsubString(self.appdelegate.orders.mdata.maccount.mnotifyList[sender.tag].mto)
                sender.layer.borderColor = UIColor(colorLiteralRed: 0.7556, green: 0.7556, blue: 0.7556, alpha: 0.8).CGColor
                Booluploading[1] = true
            }else{
                sender.layer.borderWidth = 1
                sender.layer.borderColor = UIColor(colorLiteralRed: 0.7556, green: 0.115, blue: 0.115, alpha: 0.8).CGColor
                Booluploading[1] = false
            }
        case "TEXT":
            if isPhoneValidate(sender.text!) == true {
                self.appdelegate.orders.mdata.maccount.mnotifyList[sender.tag].mto = sender.text!
                sender.text = MakingsubString(self.appdelegate.orders.mdata.maccount.mnotifyList[sender.tag].mto)
                sender.layer.borderColor = UIColor(colorLiteralRed: 0.7556, green: 0.7556, blue: 0.7556, alpha: 0.8).CGColor
                Booluploading[2] = true
            }else{
                sender.layer.borderWidth = 1
                sender.layer.borderColor = UIColor(colorLiteralRed: 0.7556, green: 0.115, blue: 0.115, alpha: 0.8).CGColor
                Booluploading[2] = false
            }
        default: break
        }
    }
    
    func isPhoneValidate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluateWithObject(value)
        return result
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        return result
    }

    

    @IBAction func ActionAddNotification(sender: AnyObject) {
        
        var melement = mmnotifyList()
        melement.mto = "8888888888"
        melement.mtype = "VOICE"
        for index in 0...2{
            if NotificationViews[index].layer.hidden == true {
                NotificationViews[index].layer.hidden = false
                self.appdelegate.orders.mdata.maccount.mnotifyList.append(melement)
                return
            }
        }
    }


    @IBAction func ActionRemoveNotification(sender: AnyObject) {
        for index in 0...2{
            if NotificationViews[2 - index].layer.hidden == false {
                NotificationViews[2 - index].layer.hidden = true
                self.appdelegate.orders.mdata.maccount.mnotifyList.removeAtIndex(2 - index)
                return
            }
        }
    }
    
    @IBAction func ActionSelectType(sender: UIButton) {
        
        let selectitemViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SelectItemViewController") as? SelectItemViewController
        selectitemViewController!.index = sender.tag
        
        self.presentViewController(selectitemViewController!, animated: true, completion: nil)
    }
    
    @IBAction func ActionUPloadNotify(sender: AnyObject) {
        
        for index in 0...2{
            if Booluploading[index] == false {
                let alertResponse = UIAlertController(title: "Attention!", message: "Please Enter Valid Data.", preferredStyle: .Alert)
                let ResponseAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertResponse.addAction(ResponseAction)
                
                self.presentViewController(alertResponse, animated: true, completion: nil)
               return
            }
        }
        var notificationResponse : AYResponse!
        
        let userNameKeyConstant = "userNameKey"
        let userpassKeyConstant = "usePassKey"
        
        var params :[String: AnyObject]
        var paramo :[String: AnyObject]! = [:]
        var paramoArray :[AnyObject]! = []
        for index in 0...appdelegate.orders.mdata.maccount.mnotifyList.count - 1 {
            
            paramo.gnm_setValue(self.appdelegate.orders.mdata.maccount.mnotifyList[index].mtype as AnyObject, forKeyPath: "type")
            paramo.gnm_setValue(self.appdelegate.orders.mdata.maccount.mnotifyList[index].mto, forKeyPath: "to")
            paramoArray.append(paramo)
            print(paramoArray)
        }

        
        let paramsnotify = ["version" : appdelegate.orders.mdata.maccount.mversion, "list" : paramoArray]
        print(paramsnotify)
        
        params = [ AYUploadHour.TYPE: "update notify",
                   AYUploadHour.VERSION: appdelegate.orders.mdata.mversion,
                   AYUploadHour.KEY: appdelegate.defaults.stringForKey(userNameKeyConstant) as! AnyObject,
                   AYUploadHour.AUTH: appdelegate.defaults.stringForKey(userpassKeyConstant) as! AnyObject,
                   AYUploadHour.DATA: paramsnotify as AnyObject]
        
        print(params)
        MRProgressOverlayView.showOverlayAddedTo(self.loadingView!, animated: true)
        Net.connectHour(params).onSuccess(callback: {(list) -> Void in    // in net class
            MRProgressOverlayView.dismissOverlayForView(self.loadingView, animated: true)
            notificationResponse = list
            print(list)
            
            if notificationResponse.mtype == "SUCCESS" {
                self.appdelegate.orders.mdata.maccount.mversion = notificationResponse.mdata.mversion
                let alertResponse = UIAlertController(title: "Success!", message: "You uploaded the Notifications successfully.", preferredStyle: .Alert)
                let ResponseAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertResponse.addAction(ResponseAction)
                
                self.presentViewController(alertResponse, animated: true, completion: nil)
            }else{
                self.showFailedAlert()
            }
            
        }).onFailure(callback: { (_) -> Void in
            print("failed")
            MRProgressOverlayView.dismissOverlayForView(self.loadingView!, animated: true)
            
            self.showFailedAlert()
        })
        
    }
    
    func showFailedAlert(){

        let alertResponse = UIAlertController(title: "Failed!", message: "You failed in uploading.", preferredStyle: .Alert)
        let ResponseAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertResponse.addAction(ResponseAction)
        
        self.presentViewController(alertResponse, animated: true, completion: nil)

    
    }
   
}