//
//  ViewController.swift
//  dangdangbot
//
//  Created by 오국원 on 2021/06/21.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,WKUIDelegate,WKNavigationDelegate{
    
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
    @IBAction func GoNaver(_ sender: Any) {
        loadWebPage("http://e91996b2d5e4.ngrok.io/")
    }
    
    func loadWebPage(_ url: String){
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        webView.load(myRequest)
    }

     */
    

}
