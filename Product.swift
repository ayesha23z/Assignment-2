//
//  Product.swift
//  ShopME
//
//  Created by Ayesha on 2/27/16.
//  Copyright © 2016 Ayesha. All rights reserved.
//

import UIKit

class Product: NSObject, NSCoding {
    
    var title: String?
    var subtitle: String?
    var price: Double?
    var amount: Int?
    var productImage: UIImage?
    
    init(title: String?, subtitle: String?, price: Double?, amount: Int?) {
        self.title = title
        self.subtitle = subtitle
        self.price = price
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObjectForKey("title") as! String
        let subtitle = aDecoder.decodeObjectForKey("subtitle") as! String
        let price = aDecoder.decodeDoubleForKey("price")
        let amount =  aDecoder.decodeIntegerForKey("amount")
        self.init(title: title, subtitle: subtitle, price: price, amount: amount)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(subtitle, forKey: "subtitle")
        aCoder.encodeDouble(price!, forKey: "price")
        aCoder.encodeInteger(amount!, forKey: "amount")
    }

}
