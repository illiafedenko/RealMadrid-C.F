//
//  MoreDetailViewController.swift
//  Soccer
//
//  Created by mac on 2/29/24.
//

import Foundation
import UIKit

class MoreDetailViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var nationView: UIView!
    @IBOutlet weak var positionView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var weightView: UIView!
    @IBOutlet weak var heightView: UIView!
    @IBOutlet weak var appearCircle: ProgressCircleView!
    @IBOutlet weak var goalsCircle: ProgressCircleView!
    @IBOutlet weak var assistCircle: ProgressCircleView!
    @IBOutlet weak var redCircle: ProgressCircleView!
    @IBOutlet weak var yellowCircle: ProgressCircleView!
    @IBOutlet weak var trophyCircle: ProgressCircleView!
    @IBOutlet weak var websiteBtn: UIButton!
    
    var url: String = ""
    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var appearance: UILabel!
    @IBOutlet weak var goals: UILabel!
    @IBOutlet weak var assist: UILabel!
    @IBOutlet weak var red: UILabel!
    @IBOutlet weak var yellow: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var nationality: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var trophy: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var age_2: UILabel!
    @IBOutlet weak var nation_2: UILabel!
    @IBOutlet weak var position_2: UILabel!
    @IBOutlet weak var number_2: UILabel!
    @IBOutlet weak var weight_2: UILabel!
    @IBOutlet weak var height_2: UILabel!
    @IBOutlet weak var ratings: UILabel!
    @IBOutlet weak var appearance_2: UILabel!
    @IBOutlet weak var goals_2: UILabel!
    @IBOutlet weak var assist_2: UILabel!
    @IBOutlet weak var red_2: UILabel!
    @IBOutlet weak var yellow_2: UILabel!
    @IBOutlet weak var trophy_2: UILabel!
    
    override func viewDidLoad() {
        
        age_2.text = "AGE:".localized()
        nation_2.text = "NATION:".localized()
        position_2.text = "POSITION:".localized()
        number_2.text = "NUMBER:".localized()
        weight_2.text = "WEIGHT:".localized()
        height_2.text = "HEIGHT:".localized()
        ratings.text = "RATINGS".localized()
        appearance_2.text = "APPEARANCE".localized()
        goals_2.text = "GOALS".localized()
        assist_2.text = "ASSIST".localized()
        red_2.text = "RED CARD".localized()
        yellow_2.text = "YELLOW CARD".localized()
        trophy_2.text = "TROPHY".localized()
        websiteBtn.setTitle("WEBSITE >>".localized(), for: .normal)
        
        backBtn.setTitle("", for: .normal)
        appearCircle.backgroundColor    = .clear
        goalsCircle.backgroundColor     = .clear
        assistCircle.backgroundColor    = .clear
        redCircle.backgroundColor       = .clear
        yellowCircle.backgroundColor    = .clear
        trophyCircle.backgroundColor    = .clear
        
        ageView.layer.cornerRadius = 15.0
        nationView.layer.cornerRadius = 15.0
        positionView.layer.cornerRadius = 15.0
        numberView.layer.cornerRadius = 15.0
        weightView.layer.cornerRadius = 15.0
        heightView.layer.cornerRadius = 15.0
        
        websiteBtn.layer.cornerRadius = 25.0
        websiteBtn.layer.shadowColor = UIColor.red.cgColor
        websiteBtn.layer.shadowOpacity = 0.5
        websiteBtn.layer.shadowOffset = .zero
        websiteBtn.layer.shadowRadius = 10
        
        setupMoreInfo()
        setupPhoto()
        setupFlag()
        
        appearCircle.completion = CGFloat((MainViewController.sectionData[Players.section].players[Players.selected].appearance)) * 0.3
        goalsCircle.completion = CGFloat((MainViewController.sectionData[Players.section].players[Players.selected].goal)) * 0.2
        assistCircle.completion = CGFloat((MainViewController.sectionData[Players.section].players[Players.selected].assist)) * 0.36
        redCircle.completion = CGFloat((MainViewController.sectionData[Players.section].players[Players.selected].red_card)) * 0.05
        yellowCircle.completion = CGFloat((MainViewController.sectionData[Players.section].players[Players.selected].yellow_card)) * 0.1
        trophyCircle.completion = CGFloat((MainViewController.sectionData[Players.section].players[Players.selected].trophy)) * 0.5
    }
        
    func setupFlag() {
        flag.backgroundColor = .clear
        flag.layer.cornerRadius = 15.0
        flag.image = UIImage(named: MainViewController.sectionData[Players.section].players[Players.selected].nationality)
    }
    
    func setupMoreInfo() {
        name.text = "\(MainViewController.sectionData[Players.section].players[Players.selected].name)"
        weight.text = "\(MainViewController.sectionData[Players.section].players[Players.selected].weight) KG"
        height.text = "\(MainViewController.sectionData[Players.section].players[Players.selected].height) CM"
        number.text = "\(MainViewController.sectionData[Players.section].players[Players.selected].number)"
        appearance.text = "\(MainViewController.sectionData[Players.section].players[Players.selected].appearance)"
        goals.text      = "\(MainViewController.sectionData[Players.section].players[Players.selected].goal)"
        assist.text     = "\(MainViewController.sectionData[Players.section].players[Players.selected].assist)"
        red.text        = "\(MainViewController.sectionData[Players.section].players[Players.selected].red_card)"
        yellow.text     = "\(MainViewController.sectionData[Players.section].players[Players.selected].yellow_card)"
        age.text        = "\(MainViewController.sectionData[Players.section].players[Players.selected].age)"
        let country = MainViewController.sectionData[Players.section].players[Players.selected].nationality.split(separator: "_")[1]
        switch country {
        case "AR":
            nationality.text = "Argentina"
            break
        case "AUT":
            nationality.text = "Austria"
            break
        case "BE":
            nationality.text = "Belgium"
            break
        case "BRA":
            nationality.text = "Brazil"
            break
        case "DE":
            nationality.text = "Germany"
            break
        case "ENG":
            nationality.text = "England"
            break
        case "ESP":
            nationality.text = "Spain"
            break
        case "FR":
            nationality.text = "France"
            break
        case "HR":
            nationality.text = "Croatia"
            break
        case "TR":
            nationality.text = "Turkey"
            break
        case "UA":
            nationality.text = "Ukraine"
            break
        case "UY":
            nationality.text = "Uruguay"
            break
        default:
            break
        }
        switch MainViewController.sectionData[Players.section].players[Players.selected].position {
        case "G":
            position.text = "Goalkeeper"
            break
        case "M":
            position.text = "Midfielder"
            break
        case "D":
            position.text = "Defender"
            break
        case "F":
            position.text = "Forward"
        default:
            break
        }
        trophy.text     = "\(MainViewController.sectionData[Players.section].players[Players.selected].trophy)"
    }
    
    func setupPhoto() {
        photo.backgroundColor = .white
        photo.layer.cornerRadius = 25.0
                
        DispatchQueue.global().async {
            guard let url = URL(string: MainViewController.sectionData[Players.section].players[Players.selected].photos[0]) else {
                DispatchQueue.main.async {
                    
                }
                return
            }
            
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async { [self] in
                    photo.image = image
                }
            } else {
                DispatchQueue.main.async {
                    
                }
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func gotoWeb(_ sender: Any) {
        let alert = UIAlertController(title: "Website".localized(), message: "Enter website url".localized(), preferredStyle: .alert)
        alert.addTextField()
        let fields = alert.textFields
        let first = fields?.first
        first!.text = MainViewController.sectionData[Players.section].players[Players.selected].website
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel) { action in
            alert.dismiss(animated: true)
         })
        alert.addAction(UIAlertAction(title: "OK".localized(), style: .default) { action in
            if
                let textFields = alert.textFields,
                let tf = textFields.first,
                let result = tf.text
            {
                if result != "" {
                    self.url = result
                    self.performSegue(withIdentifier: "websiteViewController", sender: nil)
                } else {
                    alert.dismiss(animated: true)
                }
                
            }
            else
            { }
        })
        navigationController?.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if (segue.identifier == "websiteViewController") {
          let webview = segue.destination as! WebSiteViewController
           webview.websitelink = url
       }
    }
}
