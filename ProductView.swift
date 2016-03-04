//
//  ProductView.swift
//  ShopME
//
//  Created by Ayesha on 2/27/16.
//  Copyright © 2016 Ayesha. All rights reserved.
//

import UIKit

class ProductView: UITableViewController {
    var products: [Product]?
    var currentCart: Cart?
    var type: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logButton = UIButton()
        logButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        logButton.setImage(UIImage(named: "cart"), forState: UIControlState.Normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logButton)
        logButton.addTarget(self, action: "goCart", forControlEvents: UIControlEvents.TouchUpInside)
    
        
        if let currentCart = NSUserDefaults.standardUserDefaults().objectForKey("CurrentCart") as? NSData {
            self.currentCart = NSKeyedUnarchiver.unarchiveObjectWithData(currentCart) as? Cart
        } else {
            currentCart = Cart(totalPrice: 0, totalQuantity: 0, purchaseDate: nil, groceries: [Product](), clothing: [Product](), movies: [Product](), garden: [Product](), electronics: [Product](), books: [Product](), appliances: [Product](), toys: [Product]())
            let data = NSKeyedArchiver.archivedDataWithRootObject(currentCart!)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "CurrentCart")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func goCart(){
        performSegueWithIdentifier("goToCart", sender: nil)
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("productCell", forIndexPath: indexPath) as! ProductCell
        let product = products![indexPath.row]
        cell.product = product
        cell.type = type
        cell.productTitle.text = product.title
        cell.productSubtitle.text = product.subtitle
        cell.productImage.image = product.productImage
        cell.productPrice.text = String(product.price!)
        
        return cell
    
    }
    
    
}
