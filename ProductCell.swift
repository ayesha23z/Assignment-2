//
//  ProductCell.swift
//  ShopME
//
//  Created by Ayesha on 2/27/16.
//  Copyright © 2016 Ayesha. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productSubtitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var product: Product?
    var type: Int?

    @IBAction func addProductButton(sender: AnyObject) {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("CurrentCart") as? NSData {
            let currentCart = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Cart
            currentCart.addObject(product!, type: type!)
            let data = NSKeyedArchiver.archivedDataWithRootObject(currentCart)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "CurrentCart")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
}
