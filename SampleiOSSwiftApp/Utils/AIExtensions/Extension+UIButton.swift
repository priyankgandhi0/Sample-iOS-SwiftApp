//
//  Extension+UIButton.swift
//  SampleiOSSwiftApp
//
//  Created by iMac on 10/07/24.
//

import Foundation
import UIKit


extension UIButton {
    func underlineButton(text: String, color:UIColor) {
        let titleString = NSMutableAttributedString(string: text)
        titleString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSMakeRange(0, text.count))
        titleString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, text.count))
        self.setAttributedTitle(titleString, for: .normal)
    }
    
    func setBetweenSpace() {
        setBetweenSpace(space: 1.5)
    }
    func setBetweenSpace(space:CGFloat) {
        let text = self.titleLabel?.text
        
        if let text = text {
            
            let attributeString = NSMutableAttributedString(string: text)
            
            attributeString.addAttribute(NSAttributedString.Key.kern, value: GET_PROPORTIONAL_WIDTH(space), range: NSMakeRange(0, text.count))
            self.setAttributedTitle(attributeString, for: .normal)
        }
    }

}
