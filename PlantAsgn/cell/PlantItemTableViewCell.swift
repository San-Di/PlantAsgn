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
import RealmSwift

class PlantItemTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPlant: UIImageView!
    
    @IBOutlet weak var btnFav: UIButton!
    
    @IBOutlet weak var lblPlantName: UILabel!
    @IBOutlet weak var imgPostOwner: UIImageView!
    
    @IBOutlet weak var lblPosterName: UILabel!
    @IBOutlet weak var itemContentView: UIView!
    
    let realm = try! Realm()
    
    var favToggle: Bool = false
    
    private let viewModel = PlantListViewModel()
    
    let bag = DisposeBag()
    
    var mData: PlantVO? {
        didSet{
            imgPlant.sd_setImage(with: URL(string: mData?.plant_photo ?? ""), completed: nil)
            lblPlantName.text = mData?.plant_name ?? ""
            lblPosterName.text = mData?.uploaded_user?.name ?? ""
            imgPostOwner.sd_setImage(with: URL(string: mData?.uploaded_user?.user_photo ?? ""), completed: nil)
            
            favToggle = viewModel.getFavById(id: mData?.plant_id ?? "")
            if favToggle {
                btnFav.setImage(UIImage(named: "icons8-filled_like-1"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        imgPostOwner.layer.cornerRadius = imgPostOwner.bounds.height / 2
        itemContentView.layer.cornerRadius = 10
        itemContentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        itemContentView.layer.cornerRadius = 25
        itemContentView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btnFav(_ sender: Any) {
        
        guard let mFav = mData else {
                   return
        }
        if favToggle{
            favToggle = false
            btnFav.setImage(UIImage(named: "icons8-filled_like-2"), for: .normal)
            viewModel.removeFav(id: mData?.plant_id ?? "")
        }else{
            favToggle = true
            btnFav.setImage(UIImage(named: "icons8-filled_like-1"), for: .normal)
            btnFav.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            viewModel.saveFavPlant(data: mFav)
        }
       
        
    }
    
    
}
