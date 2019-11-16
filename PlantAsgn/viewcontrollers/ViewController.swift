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
    
    let bag = DisposeBag()
    var mPlantList: [PlantVO] = []
    private let viewModel = PlantListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewPlantList.register(UINib(nibName: String(describing: PlantItemTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PlantItemTableViewCell.self))
        
        initDataObservation()
        
        viewModel.requestData()

    }

    private func initDataObservation(){
//        viewModel.catObs.observeOn(MainScheduler.instance)
//            .subscribe(onNext: {
//                data in
//                print("data => \(data)")
//    //                    self.bindCategory(category: data)
//        }).disposed(by: bag)
        
        viewModel.catObs.observeOn(MainScheduler.instance)
                    .bind(to: tableViewPlantList.rx.items) {
                        tableView, index, item in
                        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlantItemTableViewCell.self), for: IndexPath(row: index, section: 0)) as! PlantItemTableViewCell
                        
                        cell.mData = item
                        
        //                cell.heightAnchor = NSLayoutAnchor(
                        return cell
                }.disposed(by: bag)
    }
    
    func bindPlantList(plantList: [PlantVO]){
        self.mPlantList = plantList
        self.tableViewPlantList.reloadData()
    }

}
