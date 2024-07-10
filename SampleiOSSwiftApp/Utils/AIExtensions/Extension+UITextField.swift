//
//  Extension+UITextField.swift
//  SampleiOSSwiftApp
//
//  Created by iMac on 10/07/24.
//

import Foundation
import UIKit

extension UITextField
{
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.blue.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.autocapitalizationType = UITextAutocapitalizationType.none;
        self.autocorrectionType = UITextAutocorrectionType.no;
                
        if self.tag == 0 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
            self.leftViewMode = UITextField.ViewMode.always;
            self.leftView = view;
            
            self.tintColor = Colors.APP_HEADER_TEXT_COLOR
            self.textColor = Colors.APP_HEADER_TEXT_COLOR
            self.backgroundColor = UIColor.clear
            
            let iVar = class_getInstanceVariable(UITextField.self, "_placeholderLabel")!
            let placeholderLabel = object_getIvar(self, iVar) as? UILabel
            placeholderLabel?.textColor = .lightGray
            
            //self.font = UIFont(name: FONT_MPLUS_REGULAR, size: 16)
            self.font = UIFont.systemFont(ofSize: 16.0)
        }else if self.tag == 1 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.frame.height))
            self.leftViewMode = UITextField.ViewMode.always;
            self.leftView = view;
            
            self.tintColor = Colors.APP_HEADER_TEXT_COLOR
            self.textColor = Colors.APP_HEADER_TEXT_COLOR
            self.backgroundColor = UIColor.clear
            let iVar = class_getInstanceVariable(UITextField.self, "_placeholderLabel")!
            let placeholderLabel = object_getIvar(self, iVar) as? UILabel
            placeholderLabel?.textColor = .lightGray
            self.font = UIFont.systemFont(ofSize: 16.0)
            
        }else if self.tag == 2 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.height))
            self.leftViewMode = UITextField.ViewMode.always;
            self.leftView = view;
            
            self.tintColor = Colors.APP_HEADER_TEXT_COLOR
            self.textColor = Colors.APP_HEADER_TEXT_COLOR
            self.backgroundColor = UIColor.clear
            let iVar = class_getInstanceVariable(UITextField.self, "_placeholderLabel")!
            let placeholderLabel = object_getIvar(self, iVar) as? UILabel
            placeholderLabel?.textColor = .lightGray
            self.font = UIFont.systemFont(ofSize: 16.0)
            
        }
        
        
    }
    
    func applyCornerRadious()
    {
        self.layer.cornerRadius = self.frame.size.width/16
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
    }
    
    var isEmpty: Bool {
        return (self.text?.trimString() ?? "").isEmpty
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
}
