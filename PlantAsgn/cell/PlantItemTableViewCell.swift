//
//  PlantItemTableViewCell.swift
//  PlantAsgn
//
//  Created by Sandi on 11/15/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit
import RxCocoa
import SDWebImage
import RxSwift

class PlantItemTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPlant: UIImageView!
    
    @IBOutlet weak var btnFav: UIButton!
    
    private let viewModel = PlantListViewModel()
    
    let bag = DisposeBag()
    
    var mData: PlantVO? {
        didSet{
            imgPlant.sd_setImage(with: URL(string: mData?.plant_photo ?? ""), completed: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnFav(_ sender: Any) {
        btnFav.setImage(UIImage(named: "icons8-filled_like-1"), for: .normal)
        
        guard let mFav = mData else {
            return
        }
        viewModel.saveFavPlant(data: mFav)
    }
    
    
}
