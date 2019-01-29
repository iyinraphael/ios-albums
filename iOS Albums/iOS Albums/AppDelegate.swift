//
//  AppDelegate.swift
//  iOS Albums
//
//  Created by Iyin Raphael on 1/28/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let modelController = AlbumController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        modelController.testDecodingExample()
        return true
    }
    
    
    
}

