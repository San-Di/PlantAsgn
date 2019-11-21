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

    
    @IBOutlet weak var collectionViewFavCategories: UICollectionView!
    
    @IBOutlet weak var collectionViewFavList: UICollectionView!
    
    let bag = DisposeBag()
    private let viewModel = PlantListViewModel()
    
    let realm = try! Realm()
 
    override func viewDidLoad() {
        super.viewDidLoad()

//        collectionViewFavList.dataSource = self
        collectionViewFavList.delegate = self
        
        collectionViewFavList.register(UINib(nibName: String(describing: FavCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FavCollectionViewCell.self))
        
        collectionViewFavCategories.delegate = self
        
        collectionViewFavCategories.register(UINib(nibName: String(describing: FavCategoryCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FavCategoryCollectionViewCell.self))
        
        fetchAllFavList()
        
        viewModel.getFavList()
    }
    
    func fetchAllFavList() {
        viewModel.favListObs.observeOn(MainScheduler.instance)
            .bind(to: collectionViewFavList.rx.items) {
                collectionView, index, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavCollectionViewCell.self), for: IndexPath(row: index, section: 0)) as! FavCollectionViewCell
                
                cell.mData = item.plant_photo ?? ""
                
                return cell
        }.disposed(by: bag)
        
        viewModel.favCategoriesObs.observeOn(MainScheduler.instance)
            .bind(to: collectionViewFavCategories.rx.items) {
                collectionView, index, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavCategoryCollectionViewCell.self), for: IndexPath(row: index, section: 0)) as! FavCategoryCollectionViewCell
                
                cell.mData = item
                
                return cell
        }.disposed(by: bag)
        
        Observable
            .zip(collectionViewFavCategories.rx.itemSelected, collectionViewFavCategories.rx.modelSelected(String.self))
            .bind{
                indexPath, model in
                self.collectionViewFavCategories.deselectItem(at: indexPath, animated: true)
        }.disposed(by: bag)

    }
}
extension FavouriteViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == self.collectionViewFavCategories {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavCategoryCollectionViewCell.self), for: IndexPath(row: indexPath.row, section: 0)) as! FavCategoryCollectionViewCell
               
               cell.viewContentFavCategoruy.backgroundColor = UIColor(named: "Color-dark-green")
               cell.lblFavCategory.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}
extension FavouriteViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionViewFavList {
           let width = (collectionView.bounds.width / 2 ) - 10;
            
            return CGSize(width: width, height: width)
        }else {
            
             let width = (collectionView.bounds.width / 4 ) - 8;
             
             return CGSize(width: width, height: 50)
        }
        
    }
}

