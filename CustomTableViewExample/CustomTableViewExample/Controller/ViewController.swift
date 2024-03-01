//
//  Players.swift
//  Soccer
//
//  Created by mac on 2/29/24.
//


import UIKit
import Fuzi

class ViewController: UIViewController {
    
    @IBOutlet weak var playerTableView: UITableView!
    
    @IBOutlet weak var themeModeButton: UISwitch!
    
    @IBOutlet weak var tableHeader: UIView!
    
    @IBOutlet weak var headerName: UILabel!
    
    @IBOutlet weak var headerNumber: UILabel!
    
    @IBOutlet weak var headerPosition: UILabel!
    
    @IBOutlet weak var headerAge: UILabel!
    
    @IBOutlet weak var headerNAT: UILabel!
    
    let tableSectionTitle = ["Goalkeepers", "Defenders", "Midfielders", "Forwards"]
    
    var gSection = PlayerSection()
    var mSection = PlayerSection()
    var dSection = PlayerSection()
    var fSection = PlayerSection()
    static var sectionData: [PlayerSection] = []
    
    var players = Players()
    
    @IBOutlet weak var tableView:UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.themeModeButton.isOn = false
        
        setBackgroundImage()
        loadXMLData()
        
    }
    
    func loadXMLData() {
        let xmlFile = Bundle.main.path(forResource: "players", ofType: "xml")
        let xmlData = NSData(contentsOfFile: xmlFile!)
        
        do {
          let document = try XMLDocument(data: xmlData! as Data)
          
            if document.root != nil {
                var names: [String] = []
                var ages: [String] = []
                var nations: [String] = []
                var positions: [String] = []
                var squads: [String] = []
                var websites: [String] = []
                var images: [[String]] = []
                
                let namepath = "//element/name"
                for element in document.xpath(namepath) {
                    names.append(element.stringValue)
                }
                let agepath = "//element/age"
                for element in document.xpath(agepath) {
                    ages.append(element.stringValue)
                }
                let nationpath = "//element/nation"
                for element in document.xpath(nationpath) {
                    nations.append(element.stringValue)
                }
                let positionpath = "//element/pos"
                for element in document.xpath(positionpath) {
                    positions.append(element.stringValue)
                }
                let squadpath = "//element/squad"
                for element in document.xpath(squadpath) {
                    squads.append(element.stringValue)
                }
                
                let webpath = "//element/website"
                for element in document.xpath(webpath) {
                    websites.append(element.stringValue)
                }
                
                let imgpath = "//element/images"
                for element in document.xpath(imgpath) {
                    var imgs : [String] = []
                    for element1 in element.children {
                        imgs.append(element1.stringValue)
                    }
                    
                    images.append(imgs)
                }
                                
                for (index, _) in names.enumerated() {
                    let player = Player(name: names[index], number: Int(squads[index])!, position: positions[index], age: Int(ages[index])!, nationality: nations[index], photos: images[index], website: websites[index])
                    
                    Players.players.append(player)
                }
                
                classificationSectionData()
              }
            
        } catch let error {
          print(error)
        }
    }
    
    func classificationSectionData() {
                
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
        
        ViewController.sectionData.append(gSection)
        ViewController.sectionData.append(dSection)
        ViewController.sectionData.append(mSection)
        ViewController.sectionData.append(fSection)
    }
    
    @IBAction func themeModeButtonPressed(_ sender: Any) {
        setThemeMode(isEnabled: Players.isDarkMode)
    }
    
    func setThemeMode(isEnabled: Bool) {
        if (!isEnabled) {
            tableHeader.backgroundColor = UIColor.darkGray
            headerName.textColor = UIColor.white
            headerNumber.textColor = UIColor.white
            headerPosition.textColor = UIColor.white
            headerAge.textColor = UIColor.white
            headerNAT.textColor = UIColor.white
            
            playerTableView.reloadData()
        } else {
            tableHeader.backgroundColor = UIColor.white
            headerName.textColor = UIColor.black
            headerNumber.textColor = UIColor.black
            headerPosition.textColor = UIColor.black
            headerAge.textColor = UIColor.black
            headerNAT.textColor = UIColor.black
            
            playerTableView.reloadData()
        }
        
        Players.isDarkMode = !isEnabled
    }
    
    func setBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpeg")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.sectionData[section].players.count
    }
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ViewController.sectionData[section].title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let sectionHeaderBackgroundColor = Players.isDarkMode ? UIColor.darkGray : UIColor.white
        let sectionHeaderLabelView = UIView()
        sectionHeaderLabelView.frame = CGRect(x: 0, y: -80, width: tableView.frame.width, height: tableView.rowHeight)
        sectionHeaderLabelView.backgroundColor = sectionHeaderBackgroundColor

        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.text = ViewController.sectionData[section].title
        sectionHeaderLabel.textColor = Players.isDarkMode ? .white : .darkGray
        sectionHeaderLabel.frame = CGRect(x: 10, y: -30, width: 250, height: 80)
        sectionHeaderLabelView.addSubview(sectionHeaderLabel)

        return sectionHeaderLabelView

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell {
            let section = ViewController.sectionData[indexPath.section]
            let player = section.players[indexPath.row]
            
            DispatchQueue.global().async {
                guard let url = URL(string: player.photos[0]) else {
                    DispatchQueue.main.async {
                        
                    }
                    return
                }
                
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.playerPhoto.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        
                    }
                }
            }
            cell.playerPhoto.layer.cornerRadius = 30
            cell.playerName.text = player.name
            cell.playerNumber.text = "\(player.number)"
            cell.playerPosition.text = player.position
            cell.playerAge.text = "\(player.age)"
            cell.playerNationality.image = UIImage(named: player.nationality)
            
            if (Players.isDarkMode) {
                cell.backgroundColor = UIColor.darkGray
                cell.playerName.textColor = UIColor.white
                cell.playerNumber.textColor = UIColor.white
                cell.playerPosition.textColor = UIColor.white
                cell.playerAge.textColor = UIColor.white
            } else {
                cell.backgroundColor = UIColor.white
                cell.playerName.textColor = UIColor.black
                cell.playerNumber.textColor = UIColor.black
                cell.playerPosition.textColor = UIColor.black
                cell.playerAge.textColor = UIColor.black
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
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyBoard.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController {
            self.present(detailViewController, animated: true, completion: nil)
            Players.section = indexPath.section
            Players.selected = indexPath.row
        }
    }
}
