//
//  GradientTextColor.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation
import UIKit
func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {

      UIGraphicsBeginImageContext(gradientLayer.bounds.size)
      gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return UIColor(patternImage: image!)
}
func getGradientLayer(bounds : CGRect, color1:UIColor, color2:UIColor) -> CAGradientLayer{
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    // gradient colors in order which they will visually appear
//    gradient.colors = [UIColor.red.cgColor,UIColor.blue.cgColor, UIColor.green.cgColor]
    gradient.colors = [color1,color2]
    
    // Gradient from left to right
    gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
    return gradient
}
