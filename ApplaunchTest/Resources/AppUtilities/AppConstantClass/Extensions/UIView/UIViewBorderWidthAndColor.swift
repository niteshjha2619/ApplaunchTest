//
//  UIViewBorderWidthAndColor.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation
import UIKit

class UIViewBorderWidthAndColor: UIView {
    @IBInspectable  override var borderWidth: CGFloat {
        didSet {
            layer.borderWidth = borderWidth1
        }
    }
    @IBInspectable override  var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor1?.cgColor
        }
    }
}
