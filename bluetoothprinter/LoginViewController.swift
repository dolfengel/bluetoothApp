//
//  LoginViewController.swift
//  bluetoothprinter
//
//  Created by Rui Caneira on 10/10/16.
//  Copyright © 2016 Rui Caneira. All rights reserved.
//

import UIKit
import Alamofire
import BrightFutures
import MRProgress

class LoginViewController: UIViewController {

    @IBOutlet var txtAccount: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var loadingView: UIView!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var scrollContent: UIView!
    
    let userNameKeyConstant = "userNameKey"
    let userpassKeyConstant = "usePassKey"
    let userBoolKeyConstant = "userPassKey"
    var checkBool = false
    
    var params :[String: AnyObject]?
    
    let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnLogin(sender: UIButton) {
        
        let account = self.txtAccount.text
        let password = self.txtPassword.text
        
        
        if account == "" {
            let alertAccount = UIAlertController(title: "Attention!", message: "Please Enter the Account.", preferredStyle: .Alert)
            let accountAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertAccount.addAction(accountAction)
            
            presentViewController(alertAccount, animated: true, completion: nil)
            return
        }
        
        if password == "" {
            
            let alertPassword = UIAlertController(title: "Attention!", message: "Please Enter the Password.", preferredStyle: .Alert)
            let passwordAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertPassword.addAction(passwordAction)
            
            presentViewController(alertPassword, animated: true, completion: nil)
            return
        }
        
        
        
        params = [ AYNet.USERNAME: account as! AnyObject,
                       AYNet.USERPASSWORD: password as! AnyObject,
                       AYNet.USERTYPE: "bootstrap" as AnyObject]
        
        
        appdelegate.defaults.setObject(account, forKey: self.userNameKeyConstant)
        appdelegate.defaults.setObject(password, forKey: self.userpassKeyConstant)
        appdelegate.defaults.setBool(true, forKey: self.userBoolKeyConstant)
        appdelegate.checkingLog = false
        
        
        LoginFunction()
        
        
    }
    
    func LoginFunction(){
        
        MRProgressOverlayView.showOverlayAddedTo(self.loadingView!, animated: true)
        Net.connectOrder(params!).onSuccess(callback: {(list) -> Void in    // in net class
            MRProgressOverlayView.dismissOverlayForView(self.loadingView, animated: true)
            self.appdelegate.orders = list
            print(list)
            
            if self.appdelegate.orders.mtype == "SUCCESS" {
                
                let ordersViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ordersViewController") as? OrdersViewController
   
                self.presentViewController(ordersViewController!, animated: true, completion: nil)
                
            }
            
        }).onFailure(callback: { (_) -> Void in
            print("failed")
            MRProgressOverlayView.dismissOverlayForView(self.loadingView!, animated: true)
        })
        
    }
        
    
}


