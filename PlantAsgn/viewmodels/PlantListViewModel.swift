//
//  PlantListViewModel.swift
//  PlantAsgn
//
//  Created by Sandi on 11/15/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class PlantListViewModel: BaseViewModel {
    
    let realm = try! Realm()
    let bag = DisposeBag()
    public var isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    public var _errorObs: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    public var catObs: PublishSubject<[PlantVO]> = PublishSubject()
    public var favObs: PublishSubject<PlantVO> = PublishSubject()
    let apiService = SharedApiClient.shared
    
    override init() {}
    
    
    public func requestData() {
        isLoading.accept(true)
        apiService.getAllPlants().subscribeOn(ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global()))
            .subscribe(onNext: {
                respone in
                
                self.isLoading.accept(false)
                self.catObs.onNext(respone.data)
            }, onError:{
                error in
                self.isLoading.accept(false)
                self._errorObs.accept(error.localizedDescription)
            }
        ).disposed(by: bag)
        
    }
    
    public func saveFavPlant(data: PlantVO) {
        isLoading.accept(true)
        apiService.saveFavPlant(data: data, realm: self.realm).subscribeOn(MainScheduler.init())
            .subscribe(onNext: {
                respone in
                
                self.isLoading.accept(false)
                self.favObs.onNext(respone)
            }, onError: {
                error in
                self.isLoading.accept(false)
                self._errorObs.accept(error.localizedDescription)
            }).disposed(by: bag)
        
    }
}
