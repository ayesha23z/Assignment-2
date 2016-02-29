//
//  CartTableViewCell.swift
//  ShopME
//
//  Created by Ayesha on 2/28/16.
//  Copyright © 2016 Ayesha. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var cartProductTitle: UILabel!
    @IBOutlet weak var cartPrice: UILabel!
    @IBOutlet weak var cartDecreaseQuantity: UIImageView!
    @IBOutlet weak var cartProductQuantity: UILabel!
    
    @IBOutlet weak var cartIncreaseQuantity: UIImageView!
    
}
