//
//  Activity Indicator.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation
import UIKit


var activityIndicator: UIActivityIndicatorView?

func startLoading(isLoading: Bool) {
    DispatchQueue.main.async {
        if isLoading == true {
            activityIndicator = UIActivityIndicatorView()
            activityIndicator?.center = kSceneDelegateWindow!.windows.first!.center
            activityIndicator?.hidesWhenStopped = true
            activityIndicator?.style = .large
            activityIndicator?.color = .darkGray
            DispatchQueue.main.async {
                if let activityIndicator = activityIndicator {
                    kSceneDelegateWindow?.windows.first?.addSubview(activityIndicator)
                    activityIndicator.startAnimating()
                }
            }
        } else {
            DispatchQueue.main.async {
                activityIndicator?.stopAnimating()
                kSceneDelegateWindow?.windows.first?.backgroundColor = .white
                activityIndicator?.removeFromSuperview()
                activityIndicator = nil
            }
        }
    }
}
