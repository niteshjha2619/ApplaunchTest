//
//  UITextFieldSubLayerBorderWidthAndColor.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation
import UIKit

class UITextFieldSubLayerBorderWidthAndColor: UITextFieldPaddingView {
    @IBInspectable var sublayerBorderWidth: CGFloat = 0.0 {
        didSet {
        }
    }
    @IBInspectable var sublayerBorderColor: UIColor? {
        didSet {
        }
    }
    @IBInspectable var bottomSublayer: Bool = false {
        didSet {
        }
    }
}

