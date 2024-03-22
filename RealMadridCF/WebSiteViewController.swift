//
//  WebSiteViewController.swift
//  Soccer
//
//  Created by mac on 2/29/24.
//

import Foundation
import UIKit
import WebKit

class WebSiteViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backBtn: UIButton!
    
    var websitelink: String = ""
    
    override func viewDidLoad() {
        let url = URL (string: websitelink)
        let requestObj = URLRequest(url: url!)
        backBtn.setTitle("", for: .normal)
        webView.load(requestObj)
        webView.layer.cornerRadius = 10.0
        webView.layer.masksToBounds = true
    }
    @IBAction func backDetailVC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let url = URL (string: "about:blank")
        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)
    }
}
