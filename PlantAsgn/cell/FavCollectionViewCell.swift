//
//  FavCollectionViewCell.swift
//  PlantAsgn
//
//  Created by Sandi on 11/20/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit
import SDWebImage
class FavCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgfav: UIImageView!
    
    @IBOutlet weak var viewContentFav: UIView!
    
    var mData: String? {
        didSet{
            imgfav.sd_setImage(with: URL(string: mData ?? ""), completed: nil)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewContentFav.layer.cornerRadius = 20
    }

}
