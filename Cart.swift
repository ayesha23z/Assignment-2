//
//  Cart.swift
//  ShopME
//
//  Created by Ayesha on 2/27/16.
//  Copyright © 2016 Ayesha. All rights reserved.
//

import UIKit

class Cart: NSObject, NSCoding {

    var totalPrice: Double?
    var totalQuantity: Int? = 0
    //var purchaseDate: NSDate?
    var groceries = [Product]()
    var clothing = [Product]()
    var movies = [Product]()
    var garden = [Product]()
    var electronics = [Product]()
    var books = [Product]()
    var appliances = [Product]()
    var toys = [Product]()
    
    
    init(totalPrice: Double?, totalQuantity: Int?, purchaseDate: NSDate?, groceries: [Product], clothing: [Product], movies: [Product], garden: [Product], electronics: [Product], books: [Product], appliances: [Product], toys: [Product]) {
        self.totalPrice = totalPrice
        self.totalQuantity = totalQuantity
        //self.purchaseDate = purchaseDate
        self.groceries = groceries
        self.clothing = clothing
        self.movies = movies
        self.garden = garden
        self.electronics = electronics
        self.books = books
        self.appliances = appliances
        self.toys = toys
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let totalPrice = aDecoder.decodeDoubleForKey("totalPrice")
        let totalQuantity = aDecoder.decodeIntegerForKey("totalQuantity")
        //let purchaseDate = aDecoder.decodeObjectForKey("purchaseDate") as! NSDate
        let groceries = aDecoder.decodeObjectForKey("groceries") as! [Product]
        let clothing = aDecoder.decodeObjectForKey("clothing") as! [Product]
        let movies = aDecoder.decodeObjectForKey("movies") as! [Product]
        let garden = aDecoder.decodeObjectForKey("garden") as! [Product]
        let electronics = aDecoder.decodeObjectForKey("electronics") as! [Product]
        let books = aDecoder.decodeObjectForKey("books") as! [Product]
        let appliances = aDecoder.decodeObjectForKey("appliances") as! [Product]
        let toys = aDecoder.decodeObjectForKey("toys") as! [Product]
        //change purchase data from nil
        self.init(totalPrice: totalPrice, totalQuantity: totalQuantity, purchaseDate: nil, groceries: groceries, clothing: clothing, movies: movies, garden: garden, electronics: electronics, books: books, appliances: appliances, toys: toys)
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeDouble(totalPrice!, forKey: "totalPrice")
        aCoder.encodeInteger(totalQuantity!, forKey: "totalQuantity")
        //aCoder.encodeObject(purchaseDate, forKey: "purchaseDate")
        aCoder.encodeObject(groceries, forKey: "groceries")
        aCoder.encodeObject(clothing, forKey: "clothing")
        aCoder.encodeObject(movies, forKey: "movies")
        aCoder.encodeObject(garden, forKey: "garden")
        aCoder.encodeObject(electronics, forKey: "electronics")
        aCoder.encodeObject(books, forKey: "books")
        aCoder.encodeObject(appliances, forKey: "appliances")
        aCoder.encodeObject(toys, forKey: "toys")
        
    }
    
    func addObject(object: Product, type: Int) {
        totalQuantity = totalQuantity! + 1
        switch type {
        case 2:
            for product in groceries {
                //if product 1 is in cart, product = +1 & cart = +1
                if product.title == object.title{
                    product.amount = product.amount! + 1
                    return
                }
                
            }
            groceries.append(object)
        case 3:
            for product in clothing {
                if product.title == object.title{
                    product.amount = product.amount! + 1
                    return                }
                
            }
           clothing.append(object)
        case 4:
            for product in movies {
                if product.title == object.title{
                    product.amount = product.amount! + 1
                    return                }
                
            }
            movies.append(object)
        case 5:
            for product in garden {
                if product.title == object.title{
                    product.amount = product.amount! + 1
                    return                }
                
            }
            garden.append(object)
        case 6:
            for product in electronics {
                if product.title == object.title{
                    product.amount = product.amount! + 1
                    return                }
                
            }
            electronics.append(object)
        case 7:
            for product in books {
                if product.title == object.title{
                    product.amount = product.amount! + 1
                    return
                }
                
            }
            books.append(object)
        case 8:
            for product in appliances {
                if product.title == object.title{
                    product.amount = product.amount! + 1
                    return
                }
                
            }
            appliances.append(object)
        case 9:
            for product in toys {
                if product.title == object.title{
                    product.amount = product.amount! + 1
                    return
                }
                
            }
            toys.append(object)
        default:
            break
        }

    }
    
}
