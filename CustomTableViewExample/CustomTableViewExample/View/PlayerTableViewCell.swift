//
//  PlayerTableViewCell.swift
//  Soccer
//
//  Created by mac on 2/29/24.
//

import Foundation
import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerPhoto: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerPosition: UILabel!
    @IBOutlet weak var playerAge: UILabel!
    @IBOutlet weak var playerNationality: UIImageView!
    
    func configureCell(player: Player) {
        
    }
}
