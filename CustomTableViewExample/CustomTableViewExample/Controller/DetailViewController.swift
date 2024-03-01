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
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var slideShow: ImageSlideshow!
    
    @IBOutlet weak var location_1: UIImageView!
    @IBOutlet weak var location_2: UIImageView!
    @IBOutlet weak var location_3: UIImageView!
    @IBOutlet weak var location_4: UIImageView!
    
    @IBOutlet weak var lbl_1: UILabel!
    @IBOutlet weak var lbl_2: UILabel!
    @IBOutlet weak var lbl_3: UILabel!
    @IBOutlet weak var lbl_4: UILabel!
    
    @IBOutlet weak var pos: UILabel!
    @IBOutlet weak var squad: UILabel!
    @IBOutlet weak var national: UILabel!
    @IBOutlet weak var age: UILabel!
    
    
    override func viewDidLoad() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureUI()
    }
    
    func configureUI() {
        backBtn.setTitle("", for: .normal)
        prevBtn.setTitle("", for: .normal)
        nextBtn.setTitle("", for: .normal)
        
        self.infoView.layer.cornerRadius = 30
                
        var alamofireSource: [AlamofireSource] = []
        
        
        self.name.textColor = UIColor.white
        self.name.text = ViewController.sectionData[Players.section].players[Players.selected].name
        
        for url in ViewController.sectionData[Players.section].players[Players.selected].photos {
            alamofireSource.append(AlamofireSource(urlString: url)!)
        }
        
        
        self.slideShow.setImageInputs(alamofireSource)
        self.slideShow.contentScaleMode = .scaleAspectFit
        
        self.lbl_1.text = "Position"
        self.lbl_2.text = "Squad"
        self.lbl_3.text = "Nation"
        self.lbl_4.text = "Age"
        
        switch ViewController.sectionData[Players.section].players[Players.selected].position {
        case "G":
            self.pos.text = "Goalkeeper"
            break
        case "M":
            self.pos.text = "Midfielder"
            break
        case "D":
            self.pos.text = "Defender"
            break
        case "F":
            self.pos.text = "Forward"
        default:
            break
        }
        
        let country = ViewController.sectionData[Players.section].players[Players.selected].nationality.split(separator: "_")[1]
        switch country {
        case "AR":
            self.national.text = "Argentina"
            break
        case "AUT":
            self.national.text = "Austria"
            break
        case "BE":
            self.national.text = "Belgium"
            break
        case "BRA":
            self.national.text = "Brazil"
            break
        case "DE":
            self.national.text = "Germany"
            break
        case "ENG":
            self.national.text = "England"
            break
        case "ESP":
            self.national.text = "Spain"
            break
        case "FR":
            self.national.text = "France"
            break
        case "HR":
            self.national.text = "Croatia"
            break
        case "TR":
            self.national.text = "Turkey"
            break
        case "UA":
            self.national.text = "Ukraine"
            break
        case "UY":
            self.national.text = "Uruguai"
            break
        default:
            break
        }
        
        self.squad.text = "\(ViewController.sectionData[Players.section].players[Players.selected].number)"
        
        self.age.text = "\(ViewController.sectionData[Players.section].players[Players.selected].age)"
        
        if (Players.isDarkMode) {
            self.infoView.backgroundColor = UIColor.darkGray
            self.location_1.tintColor = UIColor.white
            self.location_2.tintColor = UIColor.white
            self.location_3.tintColor = UIColor.white
            self.location_4.tintColor = UIColor.white
            self.lbl_1.textColor = UIColor.white
            self.lbl_2.textColor = UIColor.white
            self.lbl_3.textColor = UIColor.white
            self.lbl_4.textColor = UIColor.white
            
            self.pos.textColor = UIColor.white
            self.squad.textColor = UIColor.white
            self.national.textColor = UIColor.white
            self.age.textColor = UIColor.white
        } else {
            self.infoView.backgroundColor = UIColor.white
            self.location_1.tintColor = UIColor.black
            self.location_2.tintColor = UIColor.black
            self.location_3.tintColor = UIColor.black
            self.location_4.tintColor = UIColor.black
            self.lbl_1.textColor = UIColor.darkGray
            self.lbl_2.textColor = UIColor.darkGray
            self.lbl_3.textColor = UIColor.darkGray
            self.lbl_4.textColor = UIColor.darkGray
            self.pos.textColor = UIColor.black
            self.squad.textColor = UIColor.black
            self.national.textColor = UIColor.black
            self.age.textColor = UIColor.black
        }
        
    }
    func setBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpeg")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func prev(_ sender: Any) {
        
        if Players.selected == 0 && Players.section == 0 {
            Players.section = 3
            Players.selected = ViewController.sectionData[3].players.count - 1
        } else if Players.selected == 0 && Players.section != 0 {
            Players.section = Players.section - 1
            Players.selected = ViewController.sectionData[Players.section].players.count - 1
        } else {
            Players.selected = Players.selected - 1
        }
        
        
        self.configureUI()
    }
    
    @IBAction func next(_ sender: Any) {
        if Players.section == 3 && Players.selected == (ViewController.sectionData[3].players.count - 1) {
            Players.section = 0
            Players.selected = 0
        } else if Players.section != 3 && Players.selected == (ViewController.sectionData[Players.section].players.count - 1){
            Players.section = Players.section + 1
            Players.selected = 0
        } else {
            Players.selected = Players.selected + 1
        }
        
        self.configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackgroundImage()
    }
}
