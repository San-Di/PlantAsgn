//
//  LoginResponse.swift
//  PlantAsgn
//
//  Created by Sandi on 11/20/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    var message: String = ""
    var code: Int = 0
    var data = LoginUserVO()
    
}
