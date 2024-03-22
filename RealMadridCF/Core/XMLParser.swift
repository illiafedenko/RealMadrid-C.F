//
//  XMLParser.swift
//  CustomTableViewExample
//
//  Created by mac on 3/1/24.
//  Copyright © 2024 Filip Varda. All rights reserved.
//

import Foundation
import Fuzi

class XMLParser {
    var fileName: String = ""
    var xml: String = ""
    var document: XMLDocument!
    
    func parseFromLocalFile() {
        let xmlFile = Bundle.main.path(forResource: fileName, ofType: "xml")
        let xmlData = NSData(contentsOfFile: xmlFile!)
        
        do {
          document = try XMLDocument(data: xmlData! as Data)
          
            
        } catch let error {
           print(error)
        }
        
    }
    
    func parseFromXMLString() -> XMLDocument {
        do {
          document = try XMLDocument(string: xml)
          
            if document.root != nil {
                return document
            }
            
        } catch let error {
           print(error)
        }
        
        return document
    }
    
    func getElements(path: String) -> [String] {
        var result: [String] = []
        
        for element in document.xpath(path) {
            result.append(element.stringValue)
        }
        
        return result
    }
    
    func getChildren(path: String) -> [[String]] {
        var result: [[String]] = []
        for element in document.xpath(path) {
            var temp : [String] = []
            for element1 in element.children {
                temp.append(element1.stringValue)
            }
            
            result.append(temp)
        }
        
        return result
    }
}
