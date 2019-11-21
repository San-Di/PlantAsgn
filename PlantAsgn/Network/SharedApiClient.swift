//
//  SharedApiClient.swift
//  PlantAsgn
//
//  Created by Sandi on 11/15/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class SharedApiClient: BaseApiClient {
    
    // MARK: - Properties
    
    static let shared = SharedApiClient()
    
    let realm = try! Realm()
    // Initialization
    
    private override init() {
        
    }
}

extension SharedApiClient: IApiClient{
    func removeFavById(id: String) -> Observable<String> {
        return Observable<String>.create { (observer) -> Disposable in
            do {
                let object = self.realm.objects(PlantVO.self).filter("plant_id = %@", id).first

                try! self.realm.write {
                    if let obj = object {
                        self.realm.delete(obj)
                        observer.onNext("Removed from fav successfully")
                    }
                }
            } catch let error{
                // handle error
                print("error - \(error.localizedDescription)")
            }

            return Disposables.create(with: {
                observer.onCompleted()
            })
        }
    }
    
    func getFavourites() -> Observable<[PlantVO]> {
        return Observable<[PlantVO]>.create { (observer) -> Disposable in
            let favList = self.realm.objects(PlantVO.self)
            print("fav list ===> \(favList)")
            
            observer.onNext(Array(favList))
//            observer.onCompleted()
            
            return Disposables.create(with: {
                observer.onCompleted()
            })
            
        }
    }
    
    func login(email: String, password: String) -> Observable<LoginResponse> {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        let obs = self.requestApiWithHeaders2(url: "https://e770532b-3dc4-42af-a70b-05a4553b7b68.mock.pstmn.io/login", method: .post, params: parameters, value: LoginResponse.self)
        
        return obs
    }
    
    func saveFavPlant(data: PlantVO, realm: Realm) -> Observable<PlantVO> {
        let obs = self.saveToRealm(data: data, realm: realm, value: PlantVO.self)
        
        return obs
    }
    
    
    func getAllPlants() -> Observable<GetAllPlantsResponse> {
        let obs = self.requestApiWithHeaders2( url:"https://e770532b-3dc4-42af-a70b-05a4553b7b68.mock.pstmn.io/getAllPlants", method: .post, params: [:], value: GetAllPlantsResponse.self)
               
               return obs
    }
    
    
}
