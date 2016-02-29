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
        if let currentCart = NSUserDefaults.standardUserDefaults().objectForKey("CurrentCart") as? NSData {
            self.currentCart = NSKeyedUnarchiver.unarchiveObjectWithData(currentCart) as? Cart
        } else {
            currentCart = Cart(totalPrice: 0, totalQuantity: 0, purchaseDate: nil, groceries: [Product](), clothing: [Product](), movies: [Product](), garden: [Product](), electronics: [Product](), books: [Product](), appliances: [Product](), toys: [Product]())
            let data = NSKeyedArchiver.archivedDataWithRootObject(currentCart!)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "CurrentCart")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
            return 0
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
        var count = 0
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
            //this will be the last row I need eventually
            return UITableViewCell()
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
        cell.cartPrice.text = String(product!.price!) //this won't work for +/- the price since it's a string
        //cell.cartDecreaseQuantity.image =
        cell.cartProductQuantity.text = String(product!.amount!)
        //cell.cartIncreaseQuantity.image =
        
        return cell
    }

    
}
