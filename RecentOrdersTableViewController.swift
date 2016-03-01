//
//  RecentOrdersTableViewController.swift
//  ShopME
//
//  Created by Ayesha on 2/29/16.
//  Copyright © 2016 Ayesha. All rights reserved.
//

import UIKit

class RecentOrdersTableViewController: UITableViewController {
    var allOrders = [Cart]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let recentOrderData = NSUserDefaults.standardUserDefaults().objectForKey("RecentOrders") as? [NSData] {
            for data in recentOrderData {
                allOrders.append(NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Cart)
            }
            
        }
        navigationItem.rightBarButtonItem = editButtonItem()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allOrders.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("orderCell")
        let recentOrder = allOrders[indexPath.row]
        cell?.textLabel?.text = "\(recentOrder.totalQuantity!) items ($\(recentOrder.totalPrice!))"
        cell?.detailTextLabel!.text = recentOrder.purchaseDate
        
        return cell!
        
    }
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "Recent Orders"
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            allOrders.removeAtIndex(indexPath.row)
            var datas = [NSData]()
            for order in allOrders {
                let data = NSKeyedArchiver.archivedDataWithRootObject(order)
                datas.append(data)
            }
            NSUserDefaults.standardUserDefaults().setObject(datas, forKey: "RecentOrders")
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
}
