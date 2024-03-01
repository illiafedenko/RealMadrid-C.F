//
//  Player.swift
//  Soccer
//
//  Created by mac on 2/29/24.
//

import Foundation

class Player: NSObject {
    
    var name: String
    var number: Int
    var position: String
    var age: Int
    var nationality: String
    var photos: [String]
    var website: String
    
    init(name: String, number: Int, position: String, age: Int, nationality: String, photos: [String], website: String) {
        self.name = name
        self.number = number
        self.position = position
        self.age = age
        self.nationality = nationality
        self.photos = photos
        self.website = website
    }
}
