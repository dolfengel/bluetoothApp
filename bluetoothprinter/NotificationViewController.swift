//
//  NotificationViewController.swift
//  bluetoothprinter
//
//  Created by Rui Caneira on 10/12/16.
//  Copyright © 2016 Rui Caneira. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet var NotificationViews: [UIView]!
    
    @IBOutlet var NotificationTitle: UIView!
    @IBOutlet var btnTypes: [UIButton]!
    @IBOutlet var txtTypeContent: [UITextField]!
    
    @IBOutlet var btnSave: UIButton!
    
    
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
            case "VOICE":
                btnTypes[index].setTitle("Phone Call" , forState: .Normal)
            case "TEXT":
                btnTypes[index].setTitle("Text Message" , forState: .Normal)
            default: break
            }
            txtTypeContent[index].text = self.appdelegate.orders.mdata.maccount.mnotifyList[index].mto
            
        }

    }
    
    
    @IBAction func btnChangeScene(sender: UIButton) {
        
        let selectitemViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MenuViewController") as? MenuViewController
        
        self.presentViewController(selectitemViewController!, animated: true, completion: nil)
        
    }

    @IBAction func ActionAddNotification(sender: AnyObject) {
        
        var melement = mmnotifyList()
        melement.mto = "VOICE"
        melement.mtype = "8888888888"
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
   
}