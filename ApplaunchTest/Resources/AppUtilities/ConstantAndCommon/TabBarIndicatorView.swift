//
//  TabBarIndicatorView.swift
//  Mofitz
//
//  Created by Nitesh jha on 17/11/22.
//

import Foundation
import UIKit

class TabBarIndicatorView: UIView {
    
    // MARK: - Properties
    weak var tabBarController: UITabBarController! // Avoid retain memory cycles
    var animationDuration: Double!
    var spacing: CGFloat!
    
    // MARK: - Required Init
    init(atTabBarController tabBarController: UITabBarController,
         withItemHeight itemHeight: CGFloat = 2.0,
         withTabColor tabColor: UIColor = .orange,
         withSpacing spacing: CGFloat = 4,
         withAnimationDuration animationDuration: Double = 0.20) {
        let tabBar = tabBarController.tabBar
        
        self.tabBarController = tabBarController
        self.animationDuration = animationDuration
        self.spacing = spacing
        
        // Setup View Frame
        super.init(frame: CGRect(x: tabBar.frame.minX+spacing/2,
                                 y: tabBarController.tabBar.frame.minY+0.1,
                                 width: (tabBar.frame.size.width / CGFloat(tabBarController.viewControllers?.count ?? 0)) - spacing,
                                 height: itemHeight))
        
        // SetupUI
        self.backgroundColor = tabColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Methods
    func selectIndex(_ index: Int) {
        UIView.animate(withDuration: animationDuration) { [self] in
            guard let tabView = tabBarController.tabBar.items?[index].value(forKey: "view") as? UIView else {
                return
            }
            self.frame = CGRect(x: tabView.frame.minX+spacing/2,
                                y: tabBarController.tabBar.frame.minY+0.1,
                                width: tabView.frame.size.width-spacing,
                                height: self.frame.size.height)
        }
    }
}
