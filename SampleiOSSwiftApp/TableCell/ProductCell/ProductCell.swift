//
//  ProductCell.swift
//  SampleiOSSwiftApp
//
//  Created by iMac on 09/07/24.
//

import UIKit
import SwiftyJSON
import SDWebImage

class ProductCell: UITableViewCell {
    static var nib : UINib {
        get {
            return UINib(nibName: AICellNames.PRODUCT_CELL, bundle: Bundle.main)
        }
    }
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblStar: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewMain.applyCornerRadius(8.0)
        viewMain.applyShadowDefault()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setProductData(_ dict : JSON){
        imgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgProduct.sd_setImage(with: URL(string: dict["thumbnail"].stringValue), placeholderImage: UIImage(named: "ic_place"))
        lblTitle.text = dict["brand"].stringValue == "" ? dict["title"].stringValue : "\(dict["title"].stringValue) | \(dict["brand"].stringValue)"
        lblCategory.text = dict["category"].stringValue.capitalized
        lblAmount.text = "$\(String(format: "%.2f", dict["discountPercentage"].doubleValue))"
        lblStar.text = "\(dict["rating"].doubleValue)"
    }
}
