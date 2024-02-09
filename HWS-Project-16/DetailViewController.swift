//
//  DetailViewController.swift
//  HWS-Project-16
//
//  Created by Ade Dwi Prayitno on 09/02/24.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var cityName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let cityName,
           let wikiURL = URL(string: "https://id.wikipedia.org/wiki/\(cityName)")  {
            webView.load(URLRequest(url: wikiURL))
        }
    }
}
