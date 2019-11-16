//
//  IApiClient.swift
//  PlantAsgn
//
//  Created by Sandi on 11/15/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import RealmSwift

protocol IApiClient {
    func getAllPlants() -> Observable<GetAllPlantsResponse>
    func saveFavPlant(data : PlantVO, realm : Realm) -> Observable<PlantVO>
}
