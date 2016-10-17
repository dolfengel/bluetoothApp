//
//  MenuViewController.swift
//  bluetoothprinter
//
//  Created by Rui Caneira on 10/12/16.
//  Copyright © 2016 Rui Caneira. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet var btnHour: UIButton!
    @IBOutlet var btnNotification: UIButton!
    @IBOutlet var btnLogout: UIButton!
    @IBOutlet var btnOrders: UIButton!
    
    
    
    let userNameKeyConstant = "userNameKey"
    let userpassKeyConstant = "usePassKey"
    let userBoolKeyConstant = "userPassKey"
    
    
    let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        btnHour.layer.cornerRadius = 5
        btnNotification.layer.cornerRadius = 5
        btnLogout.layer.cornerRadius = 5
        btnOrders.layer.cornerRadius = 5
    }
    
    @IBAction func ActionOrder(sender: AnyObject) {
        
        let ordersViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ordersViewController") as? OrdersViewController
        
        self.presentViewController(ordersViewController!, animated: true, completion: nil)
        
    }
    
    @IBAction func ActionLogout(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: self.userBoolKeyConstant)
        defaults.setObject("", forKey: self.userNameKeyConstant)
        defaults.setObject("", forKey: self.userpassKeyConstant)

        
        let logoutViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("loginviewController") as? LoginViewController
        
        self.presentViewController(logoutViewController!, animated: true, completion: nil)
    }

    @IBAction func ActionNotification(sender: AnyObject) {
        let notificationViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NotificationViewController") as? NotificationViewController
        
        self.presentViewController(notificationViewController!, animated: true, completion: nil)
    }
   
    @IBAction func ActionHour(sender: AnyObject) {
        
        let hourViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("hourViewController") as? HourViewController
        
        self.presentViewController(hourViewController!, animated: true, completion: nil)
    }
    
    

}
