//
//  FavCollectionViewCell.swift
//  PlantAsgn
//
//  Created by Sandi on 11/16/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage

class FavCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgFavPlant: UIImageView!
    
    var mData: PlantVO?{
        didSet{
            imgFavPlant.sd_setImage(with: URL(string: mData?.plant_photo ?? ""), completed: nil)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
