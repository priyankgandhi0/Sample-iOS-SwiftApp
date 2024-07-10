//
//  Extension+CGFloat.swift
//  SampleiOSSwiftApp
//
//  Created by iMac on 10/07/24.
//

import QuartzCore
import Foundation
import UIKit

extension CGFloat
{
    func proportionalFontSize() -> CGFloat {
        var sizeToCheckAgainst = self
        if(IS_IPAD_DEVICE())    {
            sizeToCheckAgainst += 12
        }
        else {
            if(IS_IPHONE_6P_OR_6SP()) {
                sizeToCheckAgainst += 1
            }
            else if(IS_IPHONE_11P()) {
                sizeToCheckAgainst -= 1
            }
            else if(IS_IPHONE_11_OR_11PROMAX()) {
                sizeToCheckAgainst += 1
            }
            else if(IS_IPHONE_12_OR_12PRO()) {
                sizeToCheckAgainst += 0
            }
            else if(IS_IPHONE_12_PRO_MAX()) {
                sizeToCheckAgainst += 1
            }
            else if(IS_IPHONE_12_MINI()) {
                sizeToCheckAgainst -= 1
            }
            else if(IS_IPHONE_6_OR_6S()) {
                sizeToCheckAgainst -= 1
            }
            else if(IS_IPHONE_5_OR_5S()) {
                sizeToCheckAgainst -= 4
            }
            else if(IS_IPHONE_4_OR_4S()) {
                sizeToCheckAgainst -= 2
            }
        }
        return sizeToCheckAgainst
    }
    
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
