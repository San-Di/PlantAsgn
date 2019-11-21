//
//  PlantVO.swift
//  PlantAsgn
//
//  Created by Sandi on 11/15/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation
import RealmSwift

class PlantVO: Object, Codable {
    @objc dynamic var plant_id: String?
    @objc dynamic var plant_name: String?
//    @objc dynamic var plant_type: [String] = []
//    @objc dynamic var description: String?
    @objc dynamic var top_tip: String?
    @objc dynamic var plant_photo: String?
    @objc dynamic var uploaded_user: PersonVO?
    @objc dynamic var tips: PlantTipVO?
    
    override static func primaryKey() -> String?{
        return "plant_id"
    }
}


extension PlantVO {
    static func getMovieById(movieId : Int, realm : Realm) -> PlantVO? {
        //TODO: Implement realm object fetch API
        return realm.object(ofType: PlantVO.self, forPrimaryKey: movieId)
    }
        
}
