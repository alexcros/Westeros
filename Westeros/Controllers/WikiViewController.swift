//
//  WikiViewController.swift
//  Westeros
//
//  Created by Alexandre on 17/9/18.
//  Copyright © 2018 Alexandre. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Model
    var model: House
    
    // MARK: - Initialization
    init(model: House) {
        
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update house changes
        NotificationCenter.default.addObserver(self, selector: #selector(houseDidChange), name: .houseDidChangeNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        syncModelWithView()
    }
    
    // MARK: Notifications
    @objc func houseDidChange(notification: Notification) {
        // get house info
        guard let info = notification.userInfo,
            let house = info[Constants.HouseKey] as? House else { return }
        
        // update house
        self.model = house
        
        syncModelWithView()
        
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        title = model.name
        let request: URLRequest = URLRequest(url: model.wikiUrl)
        spinner.startAnimating()
        
        webView.load(request)
    }
    
}

extension WikiViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
 
        spinner.stopAnimating()
        
        spinner.isHidden = true
    }
    
    // cancel / allow link navigation
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let type = navigationAction.navigationType
        
        switch type {
        case .linkActivated, .formSubmitted,.formResubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
    
}
