//
//  AppHelper.swift
//  RealMadridCF
//
//  Created by mac on 3/4/24.
//

import Foundation

class AppHelper: NSObject {
    
    static func getLocalizeString(str:String) -> String {
        let string = Bundle.main.path(forResource: UserDefaults.standard.string(forKey: "Language"), ofType: "lproj")
        let myBundle = Bundle(path: string!)
        return (myBundle?.localizedString(forKey: str, value: "", table: nil))!
    }
}
