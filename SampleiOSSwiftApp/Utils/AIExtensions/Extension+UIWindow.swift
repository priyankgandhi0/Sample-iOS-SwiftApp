//
//  Extension+UIWindow.swift
//  SampleiOSSwiftApp
//
//  Created by iMac on 10/07/24.
//

import Foundation
import UIKit

extension UIWindow
{
   var visibleViewController: UIViewController? {
       return UIWindow.getVisibleViewControllerFrom(vc: self.rootViewController)
   }
   
   static func getVisibleViewControllerFrom(vc: UIViewController?) -> UIViewController?
   {
       if let nc = vc as? UINavigationController {
           return UIWindow.getVisibleViewControllerFrom(vc: nc.visibleViewController)
       } else if let tc = vc as? UITabBarController {
           return UIWindow.getVisibleViewControllerFrom(vc: tc.selectedViewController)
       } else {
           if let pvc = vc?.presentedViewController {
               return UIWindow.getVisibleViewControllerFrom(vc: pvc)
           } else {
               return vc
           }
       }
   }
}
