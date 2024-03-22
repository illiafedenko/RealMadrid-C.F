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
    var appearance: Int
    var goal: Int
    var assist: Int
    var yellow_card: Int
    var red_card: Int
    var trophy: Int
    var weight: String
    var height: String
    
    init(name: String, number: Int, position: String, age: Int, nationality: String, photos: [String], website: String, appearance: Int, goal: Int, assist: Int, yellow_card: Int, red_card: Int, trophy: Int, weight: String, height: String) {
        self.name = name
        self.number = number
        self.position = position
        self.age = age
        self.nationality = nationality
        self.photos = photos
        self.website = website
        self.appearance = appearance
        self.goal = goal
        self.assist = assist
        self.yellow_card = yellow_card
        self.red_card = red_card
        self.trophy = trophy
        self.weight = weight
        self.height = height
    }
}
