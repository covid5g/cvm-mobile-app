//
//  Storyboard.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import UIKit

enum Storyboards: String {
    case main = "Main"
    case symptoms = "Symptoms"
    func get() -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}

struct Covid5G<T: UIViewController> {
    
    var storyboard: Storyboards
    var storyboardId: String
    //swiftlint:disable force_cast
    func get() -> T {
        return storyboard.get().instantiateViewController(withIdentifier: storyboardId) as! T
    }
}

struct Storyboard {
    
    struct Main {
        static let disclaimerVC = Covid5G<DisclaimerVC>(storyboard: .main, storyboardId: "DisclaimerVC")
        static let locationDisclaimerVC = Covid5G<LocationDisclaimerVC>(storyboard: .main, storyboardId: "LocationDisclaimerVC")
        static let authenticateVC = Covid5G<AuthenticateVC>(storyboard: .main, storyboardId: "AuthenticateVC")
        static let registerVC = Covid5G<RegisterVC>(storyboard: .main, storyboardId: "RegisterVC")
        static let loginVC = Covid5G<LoginVC>(storyboard: .main, storyboardId: "LoginVC")
    }
    
    struct Symptoms {
        static let profileVC = Covid5G<ProfileVC>(storyboard: .main, storyboardId: "ProfileVC")
    }
    
}
