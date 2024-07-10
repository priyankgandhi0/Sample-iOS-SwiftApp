//
//  AppDelegate.swift
//  SampleiOSSwiftApp
//
//  Created by iMac on 09/07/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigation: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.APP_WHITE_COLOR
        appearance.titleTextAttributes = [.foregroundColor: Colors.APP_HEADER_TEXT_COLOR,.font: UIFont.boldSystemFont(ofSize: 20.0)]
        appearance.largeTitleTextAttributes = [.foregroundColor: Colors.APP_HEADER_TEXT_COLOR]
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: Colors.APP_HEADER_TEXT_COLOR,.font: UIFont.boldSystemFont(ofSize: 20.0)]
        UINavigationBar.appearance().tintColor = Colors.APP_WHITE_COLOR
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().isTranslucent = false
        
        return true
    }


}

