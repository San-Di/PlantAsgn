//
//  LoginUserVO.swift
//  PlantAsgn
//
//  Created by Sandi on 11/20/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation
import RxSwift

class LoginUserVO: Codable {
    var user_id: String?
    var user_name: String?
    var userPhotoUrl: String?
    var memberSince: String?
    var memberRank: String?
}
