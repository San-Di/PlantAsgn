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
    
    public var plantListObs: PublishSubject<[PlantVO]> = PublishSubject()
    public var favObs: PublishSubject<PlantVO> = PublishSubject()
    public var favListObs: PublishSubject<[PlantVO]> = PublishSubject()
    public var favCategoriesObs: PublishSubject<[String]> = PublishSubject()
    public var loginUserObs: PublishSubject<LoginUserVO> = PublishSubject()
    
    let apiService = SharedApiClient.shared
    
    override init() {}
    
    
    public func requestData() {
        isLoading.accept(true)
        apiService.getAllPlants().subscribeOn(ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global()))
            .subscribe(onNext: {
                respone in
                
                self.isLoading.accept(false)
                self.plantListObs.onNext(respone.data)
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
    public func requestLogin(email: String, password: String){
        print("login lar par p")
        isLoading.accept(true)
        apiService.login(email: email, password: password).subscribeOn(ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global()))
            .subscribe(onNext: {
                respone in
                print("login response===> \(respone.data.user_name)")
                self.isLoading.accept(false)
                self.loginUserObs.onNext(respone.data)
            }, onError:{
                error in
                self.isLoading.accept(false)
                self._errorObs.accept(error.localizedDescription)
            }
        ).disposed(by: bag)
    }
    
    
    public func getFavList(){
        isLoading.accept(true)
        apiService.getFavourites().subscribeOn(MainScheduler.init())
            .subscribe(onNext: {
                respone in
                
                self.isLoading.accept(false)
                self.favListObs.onNext(respone)
                self.favCategoriesObs.onNext(["Recent", "Old", "Color", "Album"])
            }, onError: {
                error in
                self.isLoading.accept(false)
                self._errorObs.accept(error.localizedDescription)
            }).disposed(by: bag)
    }
    
    public func removeFav(id: String){
        isLoading.accept(true)
        apiService.removeFavById(id: id).subscribeOn(MainScheduler.init())
            .subscribe(onNext: {
                response in
                
                self.isLoading.accept(false)
                
            }, onError: {
                error in
                self.isLoading.accept(false)
                self._errorObs.accept(error.localizedDescription)
            }).disposed(by: bag)
    }
    
    public func getFavById(id: String) -> Bool{
        
        let moviesList = realm.objects(PlantVO.self).filter("plant_id = '\(id)'")
        
        if moviesList.isEmpty{
            return false
        }
        
        return true
        
    }
}
