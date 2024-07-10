//
//  Extension+UIView.swift
//  SampleiOSSwiftApp
//
//  Created by iMac on 10/07/24.
//

import Foundation
import UIKit

extension UIView
{
    // HEIGHT / WIDTH
    func changeStatusBarBackgroundColor(color:UIColor) {
        if #available(iOS 13.0, *) {
            
            let statusBarHeight = UIApplication.shared.connectedScenes
                .filter {$0.activationState == .foregroundActive }
                .map {$0 as? UIWindowScene }
                .compactMap { $0 }
                .first?.windows
                .filter({ $0.isKeyWindow }).first?
                .windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            self.addSubview(statusbarView)
            
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: self.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: self.centerXAnchor).isActive = true
            
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }
    
    var width:CGFloat {
        return self.frame.size.width
    }
    var height:CGFloat {
        return self.frame.size.height
    }
    var xPos:CGFloat {
        return self.frame.origin.x
    }
    var yPos:CGFloat {
        return self.frame.origin.y
    }
    
    
    // ROTATE
    func rotate(_ angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        self.transform = self.transform.rotated(by: radians);
    }
    
    
    // BORDER
    func applyBorder(_ color:UIColor, width:CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func applyCircle() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) * 0.5
        self.layer.masksToBounds = true
    }
    
    func Shadow()
    {
        self.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        self.layer.cornerRadius = 3.0
        self.layer.masksToBounds = true
        self.layer.shadowOffset = CGSize(width: -1,height: 1)
        self.layer.shadowOpacity = 0.3
    }
    
    func applyCircleWithRadius(_ radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    // CORNER RADIUS
    func applyCornerRadius(_ radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func applyCornerRadiusDefault() {
        self.applyCornerRadius(5.0)
    }
    
    func applyShadowDefault()    {
        self.applyShadowWithColor(UIColor.black, opacity: 0.1, radius: 5)
    }
    
    func applyShadowWithColor(_ color:UIColor)    {
        self.applyShadowWithColor(color, opacity: 0.1, radius: 5)
    }
    
    func applyShadowWithColor(_ color:UIColor, opacity:Float, radius: CGFloat)    {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = radius
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
    func applyShadowWithColorHeight(_ color:UIColor, opacity:Float, radius: CGFloat)    {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: -1, height: 5)
        self.layer.shadowRadius = radius
        self.clipsToBounds = false
    }
    func layerGradient() {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPoint(x: 0, y: 0)
        layer.cornerRadius = CGFloat(frame.width / 20)
        
        let color0 = UIColor(red:250.0/255, green:250.0/255, blue:250.0/255, alpha:0.5).cgColor
        let color1 = UIColor(red:200.0/255, green:200.0/255, blue: 200.0/255, alpha:0.1).cgColor
        let color2 = UIColor(red:150.0/255, green:150.0/255, blue: 150.0/255, alpha:0.1).cgColor
        let color3 = UIColor(red:100.0/255, green:100.0/255, blue: 100.0/255, alpha:0.1).cgColor
        let color4 = UIColor(red:50.0/255, green:50.0/255, blue:50.0/255, alpha:0.1).cgColor
        let color5 = UIColor(red:0.0/255, green:0.0/255, blue:0.0/255, alpha:0.1).cgColor
        let color6 = UIColor(red:150.0/255, green:150.0/255, blue:150.0/255, alpha:0.1).cgColor
        
        layer.colors = [color0,color1,color2,color3,color4,color5,color6]
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func animShow(superView:UIView){
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn],
                       animations: {
            self.center.y -= self.bounds.height
            self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
        superView.isHidden = false
    }
    func animHide(superView:UIView){
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear],
                       animations: {
            self.center.y += self.bounds.height
            self.layoutIfNeeded()
            
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
            superView.isHidden = true
        })
    }
    
    
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.insertSubview(blurEffectView, at: 0)
    }
    
    /// Remove UIBlurEffect from UIView
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func addDashedBorder(_ radius:CGFloat) {
        let color = Colors.APP_HEADER_TEXT_COLOR.withAlphaComponent(0.5).cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [4,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: radius).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -10), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func constrainToEdges(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        
        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0)
        
        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0)
        
        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint])
    }
    
    func screenshot() -> UIImage {
        
        if(self is UIScrollView) {
            let scrollView = self as! UIScrollView
            
            let savedContentOffset = scrollView.contentOffset
            let savedFrame = scrollView.frame
            
            UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, true, 0)
            scrollView.contentOffset = .zero
            self.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
            
            scrollView.contentOffset = savedContentOffset
            scrollView.frame = savedFrame
            
            return image!
        }
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
        
    }
}
