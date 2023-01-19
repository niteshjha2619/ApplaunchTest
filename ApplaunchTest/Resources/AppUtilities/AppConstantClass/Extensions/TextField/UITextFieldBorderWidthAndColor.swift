//
//  UITextFieldBorderWidthAndColor.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation
import UIKit

class UITextFieldBorderWidthAndColor: UITextFieldSubLayerBorderWidthAndColor {
    @IBInspectable override var borderWidth: CGFloat {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable override var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
