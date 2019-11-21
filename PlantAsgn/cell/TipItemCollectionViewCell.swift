//
//  TipItemCollectionViewCell.swift
//  PlantAsgn
//
//  Created by Sandi on 11/17/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit

class TipItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentTipView: UIView!
    @IBOutlet weak var viewIcon: UIView!
    
    @IBOutlet weak var imgTiptype: UIImageView!
    
    @IBOutlet weak var lblTipType: UILabel!
    
    @IBOutlet weak var lblTipvalue: UILabel!
    
    var mData: [String: Any]? {
        didSet{
            let tipType = mData?.keys.first
            
            lblTipType.text = "\(tipType?.prefix(1).capitalized ?? "")\(tipType?.dropFirst() ?? "")"
            lblTipvalue.text = mData?.values.first as? String
            
            switch tipType {
            case "temperature":
                imgTiptype.image = UIImage(named: "icons8-temperature")
                contentTipView.backgroundColor = UIColor(named: "Color-primary-green")
            break;
            case "light":
                imgTiptype.image = UIImage(named: "icons8-sun")
                contentTipView.backgroundColor = UIColor(named: "Color-dark-green")
            break;
            case "placement":
                imgTiptype.image = UIImage(named: "icons8-potted_plant")
                contentTipView.backgroundColor = UIColor(named: "Color-medium-green")
            break;
            default:
                imgTiptype.image = UIImage(named: "icons8-potted_plant")
                contentTipView.backgroundColor = UIColor(named: "Color-medium-green")
            }
        }
    }
//    var mData: String? {
//        didSet{
//            lblTipvalue.text = mData ?? ""
//        }
//    }
//
//    var mBGColor: String? {
//        didSet{
//            contentTipView.backgroundColor = UIColor(named: mBGColor ?? "")
//        }
//    }
//
//    var icon: String? {
//        didSet{
//            imgTiptype.image = UIImage(named: icon ?? "")
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentTipView.layer.cornerRadius = 20
        
        viewIcon.layer.cornerRadius = 15
    }

}
