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
    
    // Initialization
    
    private override init() {
        
    }
}

extension SharedApiClient: IApiClient{
    func saveFavPlant(data: PlantVO, realm: Realm) -> Observable<PlantVO> {
        let obs = self.saveToRealm(data: data, realm: realm, value: PlantVO.self)
        
        return obs
    }
    
    
    func getAllPlants() -> Observable<GetAllPlantsResponse> {
        let obs = self.requestApiWithHeaders2( url:"https://80032420-e94c-49d3-8c8b-570639a026cc.mock.pstmn.io/getAllPlants", method: .post, params: [:], value: GetAllPlantsResponse.self)
               
               return obs
    }
    
    
}
