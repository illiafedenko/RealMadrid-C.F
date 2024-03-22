//
//  LanguageManager.swift
//  LanguageChangerSwift
//
//  Created by Harish-Uz-Jaman Mridha Raju on 9/17/16.
//  Copyright © 2016 Raju. All rights reserved.
//

import UIKit

func Localised(_ key:String) -> String {
    
    let languageCode =  UserDefaults.standard.string(forKey: "AppLanguage")
    let bundlePath = Bundle.main.path(forResource: languageCode as String?, ofType: "lproj")
    let Languagebundle = Bundle(path: bundlePath!)
    
    return (Languagebundle?.localizedString(forKey: key, value: key, table: nil))!
}

class LanguageManager: NSObject {
    
    struct Static {
        static var oneceToken: Int = 0
        static var intance: LanguageManager? = nil
    }
    private static var __once: () = { () -> Void in
        Static.intance = LanguageManager()
    }()
        
    
    class func sharedLanguageManager() -> LanguageManager {
        _ = self.__once
        return Static.intance!
    }
    
    override init() {
        super.init()
        
    }
    
    func setLanguageWithLocale(_ locale: String) {
        UserDefaults.standard.set(locale, forKey: "AppLanguage")
        UserDefaults.standard.synchronize()
    }
    
}
