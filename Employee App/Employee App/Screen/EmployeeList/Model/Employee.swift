//
//  Employee.swift
//  Employee App
//
//  Created by Kaipeng Wu on 21/10/19.
//

import Foundation
import ObjectMapper

class Employee: Mappable {
    var id: Int?
    var first_name: String?
    var last_name: String?
    var gender: String?
    var birth_date: String?
    var thumbImage: String?
    var image: String?
    
    init (){
        
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        gender <- map["gender"]
        birth_date <- map["birth_date"]
        thumbImage <- map["thumbImage"]
        image <- map["image"]
    }
}

