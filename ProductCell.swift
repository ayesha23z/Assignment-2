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
    @IBOutlet weak var addProduct: UIButton!
    var type: Int?
    
}
