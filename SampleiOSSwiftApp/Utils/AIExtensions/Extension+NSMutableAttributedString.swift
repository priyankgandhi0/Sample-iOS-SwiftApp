//
//  Extension+NSMutableAttributedString.swift
//  SampleiOSSwiftApp
//
//  Created by iMac on 10/07/24.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func bold(_ value:String, _ font : UIFont, _ textColor : UIColor, _ underline : Int = 0) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : font,
            .foregroundColor :  textColor,
            .backgroundColor : UIColor.clear,
            .underlineStyle : underline
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
