//
//  SelectItemViewController.swift
//  bluetoothprinter
//
//  Created by Rui Caneira on 10/12/16.
//  Copyright © 2016 Rui Caneira. All rights reserved.
//

import UIKit

class SelectItemViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {

    var index : Int!
    
    let types: [String] = ["Phone Call", "Text Message", "Email"]
    let cellReuseIdentifier = "cell"
    let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
        initView()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        
        

        
    }
    
    
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.types.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.types[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch (tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text)! {
        case "Phone Call":
            self.appdelegate.orders.mdata.maccount.mnotifyList[index].mtype = "VOICE"
        case "Text Message":
            self.appdelegate.orders.mdata.maccount.mnotifyList[index].mtype = "TEXT"
        case "Email":
            self.appdelegate.orders.mdata.maccount.mnotifyList[index].mtype = "EMAIL"
        default: break
        }
        
        let notificationViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NotificationViewController") as? NotificationViewController
        
        self.presentViewController(notificationViewController!, animated: true, completion: nil)
        print("You selected cell #\(indexPath.row)!")
        
    }

}
