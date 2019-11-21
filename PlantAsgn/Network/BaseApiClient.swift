//
//  BaseApiClient.swift
//  PlantAsgn
//
//  Created by Sandi on 11/15/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation
import Alamofire

import RxSwift
import RxCocoa
import RealmSwift

open class BaseApiClient {
    fileprivate let BASE_URL = ""
        
        func requestApiWithHeaders(url: String, method: HTTPMethod, params: Parameters, success: @escaping(Data) -> Void, fail: @escaping(String) -> Void) {
            
            let headers: HTTPHeaders = ["Authorization" : "Bearer \(String(describing: UserDefaults.standard.string(forKey: "" )))"]
            
            Alamofire.request(url, method: method, parameters: params, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success:
                    //                guard let data = response.result.value else { return }
                    //                success(data as! Data)
                    success(response.data!)
                    break
                case .failure(let err):
                    
                    debugPrint(err.localizedDescription)
                    fail(err.localizedDescription)
                    break
                }
            }
            
        }
        
        // UI thread -> main scheduler
        // main thread -> concurrent dispatch scheduler
        
        
        func requestApiWithHeaders2<T>(url: String, method: HTTPMethod, params: Parameters, value: T.Type) -> Observable<T> where T: Codable {
            
            let headers: HTTPHeaders = [
                "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: "ACCESS_TOKEN") ?? "")"]
            
            return Observable<T>.create { (observer) -> Disposable in
                let request = Alamofire.request(self.BASE_URL + url, method: method, parameters: params, headers: headers).responseJSON { (response) in
                    switch response.result {
                        case .success:
                             let decoder = JSONDecoder()
                            if 200 ... 299 ~= response.response?.statusCode ?? 500 {
                                let data = try! decoder.decode(T.self, from: response.data!)
                                
                                observer.onNext(data)
                                observer.onCompleted()
                        }
                            else{
//                                let error = try! decoder.decode(ErrorResponse.self, from: response.data!)
//
//                                observer.onError(NSError(domain: error.message, code: error.code, userInfo: nil))
                            
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                
                return Disposables.create(with: {
                    request.cancel()
                })
            }
            
        }
        
    func saveToRealm<T>(data: PlantVO, realm: Realm, value: T.Type) -> Observable<T> where T: Codable {
        return Observable<T>.create { (observer) -> Disposable in
            var plantVO = PlantVO()
            
            plantVO.plant_id = data.plant_id
            plantVO.plant_name = data.plant_name
            plantVO.plant_photo = data.plant_photo
            plantVO.top_tip = data.top_tip
            plantVO.uploaded_user = data.uploaded_user
            plantVO.tips = data.tips
            
            do{
                try realm.write {
                    realm.add(plantVO, update: .modified)
                    //                realm.add(movieVO)
                }
            }catch{
                print("Error: \(error.localizedDescription) cannot save init movie list")
            }
            
            return Disposables.create(with: {
                    print("after saving fav ---------")
                })
            }
            
    }
    
    func requestApiWithoutHeaders(
            url: String,
            method: HTTPMethod,
            params: Parameters,
            success: @escaping(Data) -> Void,
            fail: @escaping(String) -> Void){
            
            Alamofire.request(url, method: method, parameters: params, headers: [:]).responseJSON { (response) in
                switch response.result {
                case .success:
    //                guard let data = response.result.value else { return }
    //                success(data as! Data)
                    success(response.data!)
                    break
                case .failure(let err):
                    
                    debugPrint(err.localizedDescription)
                    fail(err.localizedDescription)
                    break
                }
            }
        }
}
