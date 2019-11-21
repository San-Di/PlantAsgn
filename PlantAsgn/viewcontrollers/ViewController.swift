//
//  ViewController.swift
//  PlantAsgn
//
//  Created by Sandi on 11/14/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableViewPlantList: UITableView!
    
    @IBOutlet weak var imgBackground: UIImageView!
    
    let bag = DisposeBag()
    var mPlantList: [PlantVO] = []
    private let viewModel = PlantListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgBackground.layer.cornerRadius = 30
        imgBackground.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        tableViewPlantList.register(UINib(nibName: String(describing: PlantItemTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PlantItemTableViewCell.self))
        
        initDataObservation()
        
        viewModel.requestData()

    }

    private func initDataObservation(){
        viewModel.plantListObs.observeOn(MainScheduler.instance)
                    .bind(to: tableViewPlantList.rx.items) {
                        tableView, index, item in
                        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlantItemTableViewCell.self), for: IndexPath(row: index, section: 0)) as! PlantItemTableViewCell
                        
                        cell.mData = item
                        return cell
                }.disposed(by: bag)
        
        Observable
            .zip(tableViewPlantList.rx.itemSelected, tableViewPlantList.rx.modelSelected(PlantVO.self))
            .bind{
                indexPath, model in
                self.tableViewPlantList.deselectRow(at: indexPath, animated: true)
                print("Selected " + (model.plant_name ?? "") + " at \(indexPath)")
                
                guard let plantDetailVC = self.storyboard?.instantiateViewController(identifier: String(describing: DetailViewController.self)) as? DetailViewController else {
                    fatalError("Detail view controller is not found in Storyboard!")
                }
                plantDetailVC.plantVoDetail = model
                self.navigationController?.pushViewController(plantDetailVC, animated: true)
        }.disposed(by: bag)
    }
    
    func bindPlantList(plantList: [PlantVO]){
        self.mPlantList = plantList
        self.tableViewPlantList.reloadData()
    }

}
