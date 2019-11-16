//
//  Cardview.swift
//  HotelBooking
//
//  Created by Sandi on 9/5/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CardView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidt: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3


    @IBInspectable var shadowOpacity: Float = 0.5
    @IBInspectable var shadowColor: UIColor? = UIColor.black


    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius

        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidt, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    
}
