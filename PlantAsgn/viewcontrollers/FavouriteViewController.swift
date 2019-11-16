//
//  FavouriteViewController.swift
//  PlantAsgn
//
//  Created by Sandi on 11/16/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class FavouriteViewController: UIViewController {

//    @IBOutlet weak var collectionViewFavCategories: UICollectionView!
    
    @IBOutlet weak var collectionViewFavList: UICollectionView!
    
    let realm = try! Realm()
 
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewFavList.dataSource = self
        collectionViewFavList.delegate = self
        
        collectionViewFavList.register(UINib(nibName: String(describing: FavCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FavCollectionViewCell.self))
        
        fetchAllFavList()
    }
    
    func fetchAllFavList() {
        let favList = realm.objects(PlantVO.self)
        
        print("favList \(favList)")
//        self.favList = favList
    }
    
}
extension FavouriteViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension FavouriteViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavCollectionViewCell.self), for: indexPath) as! FavCollectionViewCell
        return cell
    }
    
}

extension FavouriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width - 20) / 3, height: 10)
    }
}
