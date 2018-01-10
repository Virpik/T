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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        async {
            timeLog {
                let file1Json = Data(fileName: "file1")?.json
                let file1String = Data(fileName: "file1")?.string
                
                let file2Json = Data(fileName: "file2")?.json
                let file2String = Data(fileName: "file2")?.string
                
                print("file1String: \(file1String != nil)")
                print("file1Json: \(file1Json != nil)")
                print("file2String: \(file2String != nil)")
                print("file2Json: \(file2Json != nil)")
            }
        }
        
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

