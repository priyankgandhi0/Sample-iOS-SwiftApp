//
//  Extension+UIApplication.swift
//  SampleiOSSwiftApp
//
//  Created by iMac on 10/07/24.
//

import Foundation
import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return self.connectedScenes
        // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
        // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
        // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
        // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
    /*function will return reference to tabbarcontroller */
    func tabbarController() -> UIViewController? {
        guard let vcs = keyWindow?.rootViewController?.children else { return nil }
        for vc in vcs {
            if  let _ = vc as? UITabBarController {
                return vc
            }
        }
        return nil
    }
}

