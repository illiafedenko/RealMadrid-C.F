//
//  MainViewController.swift
//  RealMadridCF
//
//  Created by mac on 3/2/24.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var themeChangeButton: UIButton!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerPlayer: UILabel!
    @IBOutlet weak var headerNumber: UILabel!
    @IBOutlet weak var headerAge: UILabel!
    @IBOutlet weak var headerNation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var languageButton: UIButton!
    
    let tableSectionTitle = [
        "Goalkeepers".localized(),
        "Defenders".localized(),
        "Midfielders".localized(),
        "Forwards".localized(),]
    
    var gSection = PlayerSection()
    var mSection = PlayerSection()
    var dSection = PlayerSection()
    var fSection = PlayerSection()
    static var sectionData: [PlayerSection] = []
    
    override func viewDidLoad() {
        
        if (Locale.current.language.languageCode == .spanish) {
            languageButton.setTitle("Spanish", for: .normal)
            Bundle.setLanguage(lang: "es")
        }
        else {
            languageButton.setTitle("English", for: .normal)
            Bundle.setLanguage(lang: "en")
        }
        
        setupUI()
        loadXMLData()
    }
        
    @IBAction func didSetEnglish(_ sender: Any) {
        languageButton.setTitle("English".localized(), for: .normal)
        Bundle.setLanguage(lang: "en")
        tableView.reloadData()
        setupUI()
        
    }
    
    @IBAction func didSetSpanish(_ sender: Any) {
        languageButton.setTitle("Spanish".localized(), for: .normal)
        Bundle.setLanguage(lang: "es")
        tableView.reloadData()
        setupUI()
    }
    
    func setupUI() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpeg")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        headerView.layer.cornerRadius = 20.0
        headerView.layer.masksToBounds = true
        headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        teamLogo.image = UIImage(named: "club.png")
        
        if Players.isDarkMode {
            themeChangeButton.setImage(UIImage(named: "moon.png"), for: .normal)
            headerView.backgroundColor  = .darkGray
            headerPlayer.textColor      = .white
            headerNumber.textColor      = .white
            headerAge.textColor         = .white
            headerNation.textColor      = .white
        } else {
            themeChangeButton.setImage(UIImage(named: "sun.png"), for: .normal)
            headerView.backgroundColor  = .white
            headerPlayer.textColor      = .black
            headerNumber.textColor      = .black
            headerAge.textColor         = .black
            headerNation.textColor      = .black
        }
        
        headerPlayer.text = "Player".localized()
        headerNumber.text = "Number".localized()
        headerAge.text = "Age".localized()
        headerNation.text = "Nation".localized()
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        Players.isDarkMode = !Players.isDarkMode
        setupUI()
        tableView.reloadData()
    }
    
    func loadXMLData() {
        
        var names: [String] = []
        var ages: [String] = []
        var nations: [String] = []
        var positions: [String] = []
        var squads: [String] = []
        var websites: [String] = []
        var images: [[String]] = []
        var appearances: [String] = []
        var goals: [String] = []
        var assists: [String] = []
        var yellow_cards: [String] = []
        var red_cards: [String] = []
        var trophies: [String] = []
        var weights: [String] = []
        var heights: [String] = []
        
        let xmlParser = XMLParser()
        xmlParser.fileName = "players"
        xmlParser.parseFromLocalFile()
        names = xmlParser.getElements(path: "//element/name")
        ages = xmlParser.getElements(path: "//element/age")
        nations = xmlParser.getElements(path: "//element/nation")
        positions = xmlParser.getElements(path: "//element/pos")
        squads = xmlParser.getElements(path: "//element/squad")
        images = xmlParser.getChildren(path: "//element/images")
        websites = xmlParser.getElements(path: "//element/website")
        appearances = xmlParser.getElements(path: "//element/appearance")
        goals = xmlParser.getElements(path: "//element/goal")
        assists = xmlParser.getElements(path: "//element/assist")
        yellow_cards = xmlParser.getElements(path: "//element/yellow_card")
        red_cards = xmlParser.getElements(path: "//element/red_card")
        trophies = xmlParser.getElements(path: "//element/trophy")
        weights = xmlParser.getElements(path: "//element/weight")
        heights = xmlParser.getElements(path: "//element/height")
        
        for (index, _) in names.enumerated() {
            let player = Player(name: names[index], number: Int(squads[index])!, position: positions[index], age: Int(ages[index])!, nationality: nations[index], photos: images[index], website: websites[index], appearance: Int(appearances[index])!, goal: Int(goals[index])!, assist: Int(assists[index])!, yellow_card: Int(yellow_cards[index])!, red_card: Int(red_cards[index])!, trophy: Int(trophies[index])!, weight: weights[index], height: heights[index])
            
            Players.players.append(player)
        }
        
        gSection.title = tableSectionTitle[0]
        dSection.title = tableSectionTitle[1]
        mSection.title = tableSectionTitle[2]
        fSection.title = tableSectionTitle[3]
                
        for player in Players.players {
            
            switch player.position {
            case "G":
                gSection.players.append(player)
                break
            case "D":
                dSection.players.append(player)
                break
            case "M":
                mSection.players.append(player)
                break
            case "F":
                fSection.players.append(player)
                break
            default:
                break
            }
        }
        
        MainViewController.sectionData.append(gSection)
        MainViewController.sectionData.append(dSection)
        MainViewController.sectionData.append(mSection)
        MainViewController.sectionData.append(fSection)
    }
       
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainViewController.sectionData[section].players.count
    }
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MainViewController.sectionData[section].title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let sectionHeaderBackgroundColor = Players.isDarkMode ? UIColor.darkGray : UIColor.white
        let sectionHeaderLabelView = UIView()
        sectionHeaderLabelView.frame = CGRect(x: 0, y: -80, width: tableView.frame.width, height: tableView.rowHeight)
        sectionHeaderLabelView.backgroundColor = sectionHeaderBackgroundColor

        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.text = MainViewController.sectionData[section].title
        sectionHeaderLabel.textColor = Players.isDarkMode ? .white : .darkGray
        sectionHeaderLabel.frame = CGRect(x: 10, y: -30, width: 250, height: 80)
        sectionHeaderLabelView.addSubview(sectionHeaderLabel)

        return sectionHeaderLabelView

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell {
            let section = MainViewController.sectionData[indexPath.section]
            let player = section.players[indexPath.row]
            
            DispatchQueue.global().async {
                guard let url = URL(string: player.photos[0]) else {
                    DispatchQueue.main.async {
                        
                    }
                    return
                }
                
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.avatar.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        
                    }
                }
            }
            cell.avatar.layer.cornerRadius = 30
            cell.name.text = player.name
            cell.number.text = "\(player.number)"
            
            switch player.position {
            case "G":
                cell.position.text = "Goalkeeper".localized()
                break
            case "M":
                cell.position.text = "Midfielder".localized()
                break
            case "D":
                cell.position.text = "Defender".localized()
                break
            case "F":
                cell.position.text = "Forward".localized()
            default:
                break
            }
            
            cell.age.text = "\(player.age)"
            cell.nation.image = UIImage(named: player.nationality)
            
            if (Players.isDarkMode) {
                cell.backgroundColor = UIColor.darkGray
                cell.name.textColor = UIColor.white
                cell.number.textColor = UIColor.white
                cell.position.textColor = UIColor.white
                cell.age.textColor = UIColor.white
                cell.number.backgroundColor = UIColor(patternImage: UIImage(named: "cloth_white.png")!)
            } else {
                cell.backgroundColor = UIColor.white
                cell.name.textColor = UIColor.black
                cell.number.textColor = UIColor.black
                cell.position.textColor = UIColor.black
                cell.age.textColor = UIColor.black
                cell.number.backgroundColor = UIColor(patternImage: UIImage(named: "cloth_dark.png")!)
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        Players.section = indexPath.section
        Players.selected = indexPath.row
        performSegue(withIdentifier: "detailVC", sender: nil)
    }
}

extension Bundle {
    private static var bundle: Bundle!
    
    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = UserDefaults.standard.string(forKey: "app_lang") ?? "en"
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }
        
        return bundle;
    }
    
    public static func setLanguage(lang: String) {
        UserDefaults.standard.set(lang, forKey: "app_lang")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Strings", bundle: Bundle.localizedBundle(), value: "", comment: "")
    }
}

