//
//  AppDelegate.swift
//  TDemo
//
//  Created by Virpik on 08/08/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import UIKit
import T

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        tLog(Date().startOfYear?.string(format: "dd/MM/YYYY"))
        tLog(Date().startOfMonth?.string(format: "dd/MM/YYYY"))
        tLog(Date().startOfWeek?.string(format: "dd/MM/YYYY"))
        tLog(Date().endOfWeek?.string(format: "dd/MM/YYYY"))
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

