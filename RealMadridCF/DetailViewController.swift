//
//  DetailViewController.swift
//  Soccer
//
//  Created by mac on 2/29/24.
//

import Foundation
import UIKit
import ImageSlideshow
import Alamofire
import ImageSlideshowAlamofire

class DetailViewController: UIViewController {
        
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var bioBtn: UIButton!
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var gamesView: UIView!
    @IBOutlet weak var goalsView: UIView!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var appearance: UILabel!
    @IBOutlet weak var goals: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: ImageSlideshow!
    @IBOutlet weak var age_1: UILabel!
    @IBOutlet weak var games_1: UILabel!
    @IBOutlet weak var goals_1: UILabel!
    
    override func viewDidLoad() {
        
        age_1.text = "AGE".localized()
        games_1.text = "GAMES".localized()
        goals.text = "GOALS".localized()
        bioBtn.setTitle("FULL BIO >>".localized(), for: .normal)
        
        infoView.layer.cornerRadius = 20.0
        infoView.layer.masksToBounds = true
        infoView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        infoView.layer.shadowColor = UIColor.gray.cgColor
        infoView.layer.shadowOpacity = 1
        infoView.layer.shadowOffset = .zero
        infoView.layer.shadowRadius = 30
        
        bioBtn.layer.cornerRadius = 25
        
        ageView.layer.cornerRadius = 15
        
        gamesView.layer.cornerRadius = 15
        
        goalsView.layer.cornerRadius = 15
        
        bioBtn.layer.shadowColor = UIColor.red.cgColor
        bioBtn.layer.shadowOpacity = 0.5
        bioBtn.layer.shadowOffset = .zero
        bioBtn.layer.shadowRadius = 10
        
        age.text = "\(MainViewController.sectionData[Players.section].players[Players.selected].age)"
        appearance.text = "\(MainViewController.sectionData[Players.section].players[Players.selected].appearance)"
        goals.text = "\(MainViewController.sectionData[Players.section].players[Players.selected].goal)"
        
        name.text = "\(MainViewController.sectionData[Players.section].players[Players.selected].name)"
        
        name.transform = CGAffineTransform(rotationAngle: CGFloat(-90.0 * .pi / 180))
        
        
        var slides: [AlamofireSource] = []
        for url in MainViewController.sectionData[Players.section].players[Players.selected].photos {
            slides.append(AlamofireSource(urlString: url)!)
        }
        
        photo.setImageInputs(slides)
        
    }
    
    @IBAction func goToTableScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func gotoMoreInfo(_ sender: Any) {
        performSegue(withIdentifier: "moreDetailViewController", sender: nil)
    }
        
    @IBAction func prev(_ sender: Any) {
        
        if Players.selected == 0 && Players.section == 0 {
            Players.section = 3
            Players.selected = MainViewController.sectionData[3].players.count - 1
        } else if Players.selected == 0 && Players.section != 0 {
            Players.section = Players.section - 1
            Players.selected = MainViewController.sectionData[Players.section].players.count - 1
        } else {
            Players.selected = Players.selected - 1
        }
        
    }
    
    @IBAction func next(_ sender: Any) {
        if Players.section == 3 && Players.selected == (MainViewController.sectionData[3].players.count - 1) {
            Players.section = 0
            Players.selected = 0
        } else if Players.section != 3 && Players.selected == (MainViewController.sectionData[Players.section].players.count - 1){
            Players.section = Players.section + 1
            Players.selected = 0
        } else {
            Players.selected = Players.selected + 1
        }
    }
}
