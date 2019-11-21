//
//  PlantTipVO.swift
//  PlantAsgn
//
//  Created by Sandi on 11/16/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation

import RealmSwift

class PlantTipVO: Object, Codable{
    @objc dynamic var temperature: String?
    @objc dynamic var light: String?
    @objc dynamic var placement: String?
}
