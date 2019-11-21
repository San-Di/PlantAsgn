//
//  FavCategoryCollectionViewCell.swift
//  PlantAsgn
//
//  Created by Sandi on 11/16/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit

class FavCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContentFavCategoruy: UIView!
    
    @IBOutlet weak var lblFavCategory: UILabel!
    
    var mData: String? {
        didSet{
            lblFavCategory.text = mData ?? ""
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewContentFavCategoruy.layer.cornerRadius = 15
    }

}
