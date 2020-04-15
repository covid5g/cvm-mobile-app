//
//  AppDelegate.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/14/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        coordinator = MainCoordinator.shared
        coordinator?.appDelegateDidLoad(withWindow: self.window)
        return true
    }



}

