//
//  UISearchBar.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation
import UIKit

extension UISearchBar {
    var textField: UITextField? {
        return value(forKey: "searchField") as? UITextField
    }
    
    func setSearchIcon(image: UIImage) {
        setImage(image, for: .search, state: .normal)
    }
    func setClearIcon(image: UIImage) {
        setImage(image, for: .clear, state: .normal)
    }
    
}
