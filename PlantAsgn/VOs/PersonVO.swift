//
//  PersonVO.swift
//  PlantAsgn
//
//  Created by Sandi on 11/15/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation
import RealmSwift

class PersonVO: Object{
     @objc dynamic var name: String = ""
     @objc dynamic var user_photo: String = ""
     @objc dynamic var uploaded_time: String = ""
     @objc dynamic var user_rank: String = ""
    
}
