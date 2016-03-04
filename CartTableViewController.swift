//
//  CartTableViewController.swift
//  ShopME
//
//  Created by Ayesha on 2/28/16.
//  Copyright © 2016 Ayesha. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController {
    
    //get category
    //get product, price, and quantity
    
    var currentCart: Cart?
    var typesOfSections = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        
        //let logButton : UIBarButtonItem = UIBarButtonItem(title: "RigthButtonTitle", style: UIBarButtonItemStyle.Plain, target: self, action: "root")
        
        let logButton = UIButton()
        logButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        logButton.setImage(UIImage(named: "homeButton"), forState: UIControlState.Normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logButton)
        logButton.addTarget(self, action: "root", forControlEvents: UIControlEvents.TouchUpInside)
 
        if let currentCart = NSUserDefaults.standardUserDefaults().objectForKey("CurrentCart") as? NSData {
            self.currentCart = NSKeyedUnarchiver.unarchiveObjectWithData(currentCart) as? Cart
        } else {
            currentCart = Cart(totalPrice: 0, totalQuantity: 0, purchaseDate: nil, groceries: [Product](), clothing: [Product](), movies: [Product](), garden: [Product](), electronics: [Product](), books: [Product](), appliances: [Product](), toys: [Product]())
            let data = NSKeyedArchiver.archivedDataWithRootObject(currentCart!)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "CurrentCart")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func root(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section > typesOfSections.count - 1 {
            return 100
        }
        return 40
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section > typesOfSections.count - 1 {
            return nil
        }
        switch typesOfSections[section] {
        case 1:
            return "Grocery"
        case 2:
            return "Clothing"
        case 3:
            return "Movies"
        case 4:
            return "Garden"
        case 5:
            return "Electronics"
        case 6:
            return "Books"
        case 7:
            return "Appliances"
        case 8:
            return "Toys"
        default:
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == typesOfSections.count {
            //this will be the last row I need eventually
            return 1
        }
        
        switch typesOfSections[section] {
        case 1:
            return currentCart!.groceries.count
        case 2:
            return currentCart!.clothing.count
        case 3:
            return currentCart!.movies.count
        case 4:
            return currentCart!.garden.count
        case 5:
            return currentCart!.electronics.count
        case 6:
            return currentCart!.books.count
        case 7:
            return currentCart!.appliances.count
        case 8:
            return currentCart!.toys.count
        default:
            return 0
        }
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var count = 1
        typesOfSections.removeAll()
        if currentCart?.groceries.count > 0{
            typesOfSections.append(1)
            count++
        }
        if currentCart?.clothing.count > 0{
            typesOfSections.append(2)
            count++
        }
        if currentCart?.movies.count > 0{
            typesOfSections.append(3)
            count++
        }
        if currentCart?.garden.count > 0{
            typesOfSections.append(4)
            count++
        }
        if currentCart?.electronics.count > 0{
            typesOfSections.append(5)
            count++
        }
        if currentCart?.books.count > 0{
            typesOfSections.append(6)
            count++
        }
        if currentCart?.appliances.count > 0{
            typesOfSections.append(7)
            count++
        }
        if currentCart?.toys.count > 0{
            typesOfSections.append(8)
            count++
        }
        return count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == typesOfSections.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("totalQuantity", forIndexPath:indexPath) as! QuantityTableViewCell
            
            
            
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            formatter.locale = NSLocale.currentLocale()
            
            cell.finalCartPrice.text = formatter.stringFromNumber(currentCart!.totalPrice!)
            cell.finalCartQuantity.text = String(currentCart!.totalQuantity!)
            cell.emptyCart.userInteractionEnabled = true
            let tapRecognizer = UITapGestureRecognizer(target: self, action: "emptyCart")
            cell.emptyCart.addGestureRecognizer(tapRecognizer)
            
            cell.buyCart.userInteractionEnabled = true
            let tapRecognizer2 = UITapGestureRecognizer(target: self, action: "buyCart")
            cell.buyCart.addGestureRecognizer(tapRecognizer2)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cartCell", forIndexPath:indexPath) as! CartTableViewCell
        var product: Product?
        switch typesOfSections[indexPath.section] {
        case 1:
            product = currentCart?.groceries[indexPath.row]
            break
        case 2:
            product = currentCart?.clothing[indexPath.row]
            break
        case 3:
            product = currentCart?.movies[indexPath.row]
            break
        case 4:
            product = currentCart?.garden[indexPath.row]
            break
        case 5:
            product = currentCart?.electronics[indexPath.row]
            break
        case 6:
            product = currentCart?.books[indexPath.row]
            break
        case 7:
            product = currentCart?.appliances[indexPath.row]
            break
        case 8:
            product = currentCart?.toys[indexPath.row]
            break
        default:
            break
        }
        
        //configure cell
        //cell.titleLabel.text = product.title
        //etc.
        cell.cartProductTitle.text = product?.title
        cell.cartPrice.text = String(product!.price!)
        cell.cartProductQuantity.text = String(product!.amount!)
        cell.cartIncreaseQuantity.addTarget(self, action: "increaseAmount:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.cartIncreaseQuantity.tag = typesOfSections[indexPath.section] * 100 + indexPath.row
        cell.cartDecreaseQuantity.addTarget(self, action: "decreaseAmount:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.cartDecreaseQuantity.tag = typesOfSections[indexPath.section] * 100 + indexPath.row
        return cell
    }
    
    func increaseAmount(sender: UIButton){
        print(sender.tag)
        switch sender.tag/100 {
        case 1:
            currentCart?.addObject(currentCart!.groceries[sender.tag % 100], type: sender.tag/100 + 1)
            break
        case 2:
          
            currentCart?.addObject(currentCart!.clothing[sender.tag % 100], type: sender.tag/100 + 1)
            break
        case 3:
            currentCart?.addObject(currentCart!.movies[sender.tag % 100], type: sender.tag/100 + 1)
            break
        case 4:
            currentCart?.addObject(currentCart!.garden[sender.tag % 100], type: sender.tag/100 + 1)
            break
        case 5:
            currentCart?.addObject(currentCart!.electronics[sender.tag % 100], type: sender.tag/100 + 1)
            break
        case 6:
            currentCart?.addObject(currentCart!.books[sender.tag % 100], type: sender.tag/100 + 1)
            break
        case 7:
            currentCart?.addObject(currentCart!.appliances[sender.tag % 100], type: sender.tag/100 + 1)
            break
        case 8:
            currentCart?.addObject(currentCart!.toys[sender.tag % 100], type: sender.tag/100 + 1)
            break
        default:
            break
        }
        let data = NSKeyedArchiver.archivedDataWithRootObject(currentCart!)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "CurrentCart")
        NSUserDefaults.standardUserDefaults().synchronize()
        tableView.reloadData()
        
    }
    
    func decreaseAmount(sender: UIButton){
        currentCart!.totalQuantity!--
        switch sender.tag/100 {
        case 1:
            currentCart!.groceries[sender.tag % 100].amount!--
            currentCart!.totalPrice! -= currentCart!.groceries[sender.tag % 100].price!
            if currentCart!.groceries[sender.tag % 100].amount! == 0{
                currentCart!.groceries.removeAtIndex(sender.tag % 100)
            }
            break
        case 2:
            currentCart!.clothing[sender.tag % 100].amount!--
            currentCart!.totalPrice! -= currentCart!.clothing[sender.tag % 100].price!
            if currentCart!.clothing[sender.tag % 100].amount! == 0{
                currentCart!.clothing.removeAtIndex(sender.tag % 100)
            }
            break
        case 3:
            currentCart!.movies[sender.tag % 100].amount!--
            currentCart!.totalPrice! -= currentCart!.movies[sender.tag % 100].price!
            if currentCart!.movies[sender.tag % 100].amount! == 0{
                currentCart!.movies.removeAtIndex(sender.tag % 100)
            }
            break
        case 4:
            currentCart!.garden[sender.tag % 100].amount!--
            currentCart!.totalPrice! -= currentCart!.garden[sender.tag % 100].price!
            if currentCart!.garden[sender.tag % 100].amount! == 0{
                currentCart!.garden.removeAtIndex(sender.tag % 100)
            }
            break
        case 5:
            currentCart!.electronics[sender.tag % 100].amount!--
            currentCart!.totalPrice! -= currentCart!.electronics[sender.tag % 100].price!
            if currentCart!.electronics[sender.tag % 100].amount! == 0{
                currentCart!.electronics.removeAtIndex(sender.tag % 100)
            }
            break
        case 6:
            currentCart!.books[sender.tag % 100].amount!--
            currentCart!.totalPrice! -= currentCart!.books[sender.tag % 100].price!
            if currentCart!.books[sender.tag % 100].amount! == 0{
                currentCart!.books.removeAtIndex(sender.tag % 100)
            }
            break
        case 7:
            currentCart!.appliances[sender.tag % 100].amount!--
            currentCart!.totalPrice! -= currentCart!.appliances[sender.tag % 100].price!
            if currentCart!.appliances[sender.tag % 100].amount! == 0{
                currentCart!.appliances.removeAtIndex(sender.tag % 100)
            }
            break
        case 8:
            currentCart!.toys[sender.tag % 100].amount!--
            currentCart!.totalPrice! -= currentCart!.toys[sender.tag % 100].price!
            if currentCart!.toys[sender.tag % 100].amount! == 0{
                currentCart!.toys.removeAtIndex(sender.tag % 100)
            }
            break
        default:
            break
        }
        let data = NSKeyedArchiver.archivedDataWithRootObject(currentCart!)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "CurrentCart")
        NSUserDefaults.standardUserDefaults().synchronize()
        tableView.reloadData()
    }
    
    func emptyCart() {
        currentCart = Cart(totalPrice: 0, totalQuantity: 0, purchaseDate: nil, groceries: [Product](), clothing: [Product](), movies: [Product](), garden: [Product](), electronics: [Product](), books: [Product](), appliances: [Product](), toys: [Product]())
        let data = NSKeyedArchiver.archivedDataWithRootObject(currentCart!)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "CurrentCart")
        NSUserDefaults.standardUserDefaults().synchronize()
        tableView.reloadData()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func buyCart() {
        
        if currentCart!.totalQuantity == 0{
        return
        }
        let refreshAlert = UIAlertController(title: "PAYMENT", message: "Your card will be charged \(currentCart!.totalPrice!)", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        
        refreshAlert.addAction(UIAlertAction(title: "Place Order", style: .Default, handler: { (action: UIAlertAction!) in
            let dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "MMM/dd, EEE, hh:mm a"
            let dateString = dateFormat.stringFromDate(NSDate())
            print(dateString)
            self.currentCart?.purchaseDate = dateString
            let data = NSKeyedArchiver.archivedDataWithRootObject(self.currentCart!)
            if var recentOrderData = NSUserDefaults.standardUserDefaults().objectForKey("RecentOrders") as? [NSData] {
                recentOrderData.insert(data, atIndex: 0)
                if recentOrderData.count == 11{
                    recentOrderData.removeAtIndex(10)
                }
                NSUserDefaults.standardUserDefaults().setObject(recentOrderData, forKey: "RecentOrders")
                
            } else {
                NSUserDefaults.standardUserDefaults().setObject([data], forKey: "RecentOrders")
            }
            
            NSUserDefaults.standardUserDefaults().synchronize()
            self.emptyCart()
            
           self.navigationController?.popToRootViewControllerAnimated(true)
            
            
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "Your Cart"
        
        
    }
    
    
   
    
}
