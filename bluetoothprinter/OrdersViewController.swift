//
//  OrdersViewController.swift
//  bluetoothprinter
//
//  Created by Rui Caneira on 10/11/16.
//  Copyright © 2016 Rui Caneira. All rights reserved.
//

import UIKit
import MRProgress

class OrdersViewController: UIViewController {
    
    @IBOutlet var OrderButton: UIButton!
    
    @IBOutlet var loadingview: UIView!
    @IBOutlet var CoverView: UIView!
    @IBOutlet var DialogView: UIView!
    @IBOutlet var printUIview: UIView!
    @IBOutlet var lblLine1: UILabel!
    @IBOutlet var lblLine2: UILabel!
    @IBOutlet var lblLine3: UILabel!
    @IBOutlet var lblLine4: UILabel!
    @IBOutlet var lblLine5: UILabel!
    @IBOutlet var lblLine6: UILabel!
    @IBOutlet var lblLine71: UILabel!
    @IBOutlet var lblLine72: UILabel!
    @IBOutlet var lblLine81: UILabel!
    @IBOutlet var lblLine91: UILabel!
    @IBOutlet var lblLine92: UILabel!
    @IBOutlet var lblLine101: UILabel!
    @IBOutlet var lblLine102: UILabel!
    @IBOutlet var lblLine111: UILabel!
    @IBOutlet var lblLine112: UILabel!
    @IBOutlet var lblLine121: UILabel!
    @IBOutlet var lblLine122: UILabel!
    
    @IBOutlet var btnRefund: UIButton!
    @IBOutlet var btnPrint: UIButton!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnConfirm: UIButton!
    @IBOutlet var txtPassword: UITextField!
    
    let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let userNameKeyConstant = "userNameKey"
    let userpassKeyConstant = "usePassKey"
    let userBoolKeyConstant = "userPassKey"
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkingLogin()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DetailAction(sender: UIButton) {
        
        printUIview.layer.hidden = false
        OrderButton.layer.hidden = true
        
        let line1 = "Jul 13, 2016 1:10 PM"
        let line2 = String(self.appdelegate.orders.mdata.morders[0].mprepTime) + " mins to prepare"
        let line3 = self.appdelegate.orders.mdata.morders[0].mtype + " at 1:40 PM"
        
        let line4 = self.appdelegate.orders.mdata.morders[0].mname
        let line5 = self.appdelegate.orders.mdata.morders[0].mphone
        let line6 = self.appdelegate.orders.mdata.morders[0].memail
        
        let line71 = self.appdelegate.orders.mdata.morders[0].mitems[0].mname
        let line72 = "$1.00"
        let line8 = "Quantity :" + " " + String(self.appdelegate.orders.mdata.morders[0].mitems[0].mquantity)
        
        let line9 = "$" + String(self.appdelegate.orders.mdata.morders[0].msubtotal/100)
        let line10 = "$" + String(self.appdelegate.orders.mdata.morders[0].mtax/100)
        let line11 = "$" + String(self.appdelegate.orders.mdata.morders[0].mfee/100)
        
        let line12 = "$" + String(self.appdelegate.orders.mdata.morders[0].mtotal/100)
        
        lblLine1.text = line1
        lblLine2.text = line2
        lblLine3.text = line3
        
        lblLine4.text = line4
        lblLine5.text = line5
        lblLine6.text = line6
        
        lblLine71.text = line71
        lblLine72.text = line72
        lblLine81.text = line8
        
        lblLine91.text = "Subtotal"
        lblLine92.text = line9
        lblLine101.text = "Tax"
        lblLine102.text = line10
        lblLine111.text = "Fee"
        lblLine112.text = line11
        
        lblLine121.text = "Total"
        lblLine122.text = line12
        
    }
    
    func checkingLogin(){
        if appdelegate.checkingLog == true {
            LoginFunction()
        }else{
            initView()
        }
    }
    
    func initView(){
        
        
        printUIview.layer.hidden = true
        DialogView.layer.hidden = true
        OrderButton.layer.cornerRadius = 8
        OrderButton?.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        OrderButton.titleLabel!.textAlignment = .Center
        let line1 = "Jul " + String(self.appdelegate.orders.mdata.maccount.mversion) + ", 2016  1:10 PM"
        let line2 = self.appdelegate.orders.mdata.morders[0].mname + " - " + self.appdelegate.orders.mdata.morders[0].mphone
        let line3 = "$1.34"
        OrderButton.setTitle(line1 + "\n" + line2 + "\n" + line3, forState: UIControlState.Normal)
        
        btnPrint.layer.cornerRadius = 5
        btnRefund.layer.cornerRadius = 5
        DialogView.layer.cornerRadius = 10
        txtPassword.layer.cornerRadius = 5
        txtPassword.layer.borderWidth = 1
        btnCancel.layer.cornerRadius = 5
        btnConfirm.layer.cornerRadius = 5
        
        
        
    }
    
    
    @IBAction func btnChangeScene(sender: UIButton) {
        
        let menuViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MenuViewController") as? MenuViewController
        
        self.presentViewController(menuViewController!, animated: true, completion: nil)
        
        
    }
    @IBAction func ActionCancel(sender: AnyObject) {
        DialogView.layer.hidden = true
        CoverView.layer.hidden = true
    }
    @IBAction func ActionConfirm(sender: AnyObject) {
        DialogView.layer.hidden = true
        CoverView.layer.hidden = true
    }
    @IBAction func ActionRefund(sender: AnyObject) {
        DialogView.layer.hidden = false
        CoverView.layer.hidden = false
    }
    
    
    func LoginFunction(){
        
        var params :[String: AnyObject]?
        params = [ AYNet.USERNAME: appdelegate.defaults.stringForKey(userNameKeyConstant) as! AnyObject,
                   AYNet.USERPASSWORD: appdelegate.defaults.stringForKey(userpassKeyConstant) as! AnyObject,
                   AYNet.USERTYPE: "bootstrap" as AnyObject]
        

        printUIview.layer.hidden = true
        MRProgressOverlayView.showOverlayAddedTo(self.loadingview!, animated: true)
        Net.connectOrder(params!).onSuccess(callback: {(list) -> Void in    // in net class
            MRProgressOverlayView.dismissOverlayForView(self.loadingview, animated: true)
            self.appdelegate.orders = list
            print(list)
            
            if self.appdelegate.orders.mtype == "SUCCESS" {
                
                self.initView()
            }
            
        }).onFailure(callback: { (_) -> Void in
            print("failed")
            MRProgressOverlayView.dismissOverlayForView(self.loadingview!, animated: true)
        })
        
    }
    
    
}
