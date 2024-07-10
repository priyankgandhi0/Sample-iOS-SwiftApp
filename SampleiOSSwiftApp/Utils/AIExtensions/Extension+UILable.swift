//
//  Extension+UILable.swift
//  SampleiOSSwiftApp
//
//  Created by iMac on 10/07/24.
//

import Foundation
import UIKit

extension UILabel {
    
    func retrieveTextHeight () -> CGFloat {
        let attributedText = NSAttributedString(string: self.text!, attributes: [NSAttributedString.Key.font:self.font!])

        let rect = attributedText.boundingRect(with: CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        return ceil(rect.size.height)
    }
    
    func setLineHeight(_ lineHeight: CGFloat) {
        self.setLineHeight(lineHeight, withAlignment: .center)
        
    }
    
    func setLineHeight(_ lineHeight: CGFloat, withAlignment alignment:NSTextAlignment) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineHeight
            style.alignment = alignment
            
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
        }
    }
    
    func setBetweenSpace() {
        setBetweenSpace(space: 1.5)
    }
    func setBetweenSpace(space:CGFloat) {
        let text = self.text
        
        if let text = text {
            
            let attributeString = NSMutableAttributedString(string: text)
            
            attributeString.addAttribute(NSAttributedString.Key.kern, value: GET_PROPORTIONAL_WIDTH(space), range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
        }
    }
    
}
