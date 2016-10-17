//
//  TimeZoneSelectViewController.swift
//  bluetoothprinter
//
//  Created by Rui Caneira on 10/13/16.
//  Copyright © 2016 Rui Caneira. All rights reserved.
//

import UIKit

class TimeZoneSelectViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    
    let timezones: [String] = ["Pacific", "Arizona", "Mountain", "Central", "Eastern"]
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
        return self.timezones.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.timezones[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let hourViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("hourViewController") as? HourViewController
        self.appdelegate.orders.mdata.maccount.mtimezone = (tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text)!
        
        self.presentViewController(hourViewController!, animated: true, completion: nil)
        print("You selected cell #\(indexPath.row)!")
        
    }
    
}
