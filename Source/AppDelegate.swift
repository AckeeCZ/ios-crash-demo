//
//  AppDelegate.swift
//  crash-reporting-demo
//
//  Created by Jakub Olejník on 01/06/2017.
//
//

import UIKit
import Framework
import Fabric
import Crashlytics
import HockeySDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        configureHockeyApp()
        configureCrashlytics()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        
        return true
    }

    private func configureCrashlytics() {
        Fabric.with([Crashlytics.self])
    }
    
    private func configureHockeyApp() {
        BITHockeyManager.shared().configure(withIdentifier: "d740a3052128452cab42666459f4b8b5")
        BITHockeyManager.shared().start()
        BITHockeyManager.shared().authenticator.authenticateInstallation()
    }
}
