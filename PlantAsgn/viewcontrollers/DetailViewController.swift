//
//  DetailViewController.swift
//  PlantAsgn
//
//  Created by Sandi on 11/17/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    @IBOutlet weak var imgPlantBackground: UIImageView!
    
    @IBOutlet weak var lblPlantNme: UILabel!
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblPersonName: UILabel!
    
    @IBOutlet weak var lblPlantTips: UILabel!
    
    @IBOutlet weak var viewFav: UIView!
    @IBOutlet weak var viewPlantDetail: UIView!
    
    @IBOutlet weak var collectionViewTipList: UICollectionView!
    
    @IBOutlet weak var imgFavIcon: UIImageView!
    
    var plantVoDetail: PlantVO?
    
    let bag = DisposeBag()
    
    private let viewModel = PlantListViewModel()
    
    var tipList: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgProfile.layer.cornerRadius = imgProfile.bounds.height / 2
        viewPlantDetail.layer.cornerRadius = 40
        viewPlantDetail.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        viewFav.layer.cornerRadius = 20
        guard let data = plantVoDetail else {
            return
        }
        
        if viewModel.getFavById(id: data.plant_id ?? "") {
            imgFavIcon.image = UIImage(named: "icons8-filled_like-1")
            imgFavIcon.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        collectionViewTipList.delegate = self
        collectionViewTipList.dataSource = self
        
        collectionViewTipList.register(UINib(nibName: String(describing: TipItemCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TipItemCollectionViewCell.self))

        
        lblPlantNme.text = data.plant_name
        lblPersonName.text = data.uploaded_user?.name
        imgProfile.sd_setImage(with: URL(string: data.uploaded_user?.user_photo ?? ""), completed: nil)

        lblPlantTips.text = data.top_tip
        imgPlantBackground.sd_setImage(with: URL(string: data.plant_photo ?? ""), completed: nil)

//        plantTipList.append(data.tips?.temperature ?? "")
//        plantTipList.append(data.tips?.light ?? "")
//        plantTipList.append(data.tips?.placement ?? "")
//
        tipList.append(["temperature": data.tips?.temperature ?? ""])
        tipList.append(["light": data.tips?.light ?? ""])
        tipList.append(["placement": data.tips?.placement ?? ""])
        
    }
   
}

extension DetailViewController: UICollectionViewDelegate{
    
}

extension DetailViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tipList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TipItemCollectionViewCell.self), for: indexPath) as! TipItemCollectionViewCell
//        item.mData = plantTipList[indexPath.row]
//        item.mBGColor = colorList[indexPath.row]
        item.mData = tipList[indexPath.row]
        return item
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension DetailViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width / 3) - 25;
        return CGSize(width: width, height: 250)
    }
}


