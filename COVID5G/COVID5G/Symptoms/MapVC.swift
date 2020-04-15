//
//  MapVC.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import CoreLocation
import WebKit
import UIKit
import Foundation

class MapVC: UIViewController {

    var navigatorGeolocation = NavigatorGeolocation();
    var web: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let webViewConfiguration = WKWebViewConfiguration();
        navigatorGeolocation.setUserContentController(webViewConfiguration: webViewConfiguration);
        web = WKWebView(frame:.zero , configuration: webViewConfiguration)
        web.navigationDelegate = self;
        navigatorGeolocation.setWebView(webView: web);
        view.addSubview(web);
        web.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            web.topAnchor.constraint(equalTo: view.topAnchor),
            web.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            web.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            web.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        let url = URL(string: "https://d2x9e7sottht8j.cloudfront.net/map")!
        web.load(URLRequest(url: url))
    }
}


extension MapVC: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript(navigatorGeolocation.getJavaScripToEvaluate());
    }
}
