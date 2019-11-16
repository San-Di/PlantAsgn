//
//  PlantResponse.swift
//  PlantAsgn
//
//  Created by Sandi on 11/15/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation
import RealmSwift

struct GetAllPlantsResponse: Codable {
    var message: String = ""
    var code: Int = 0
    var data: [PlantVO] = []
    
}

