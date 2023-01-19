//
//  UIViewController.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation
import UIKit

enum Storyboard: String{
    case Registration = "Main"
    case Home = "Home"
    case Subscription = "Subscriptions"
    
}

extension UIViewController{
    var isRootController: Bool {
        return (self.navigationController?.viewControllers.count ?? 0) == 1
    }
    
    static var storyboardID:String {
        return String(describing: self)
    }
    
    static func getControllerObject<T : UIViewController>(storyboard: String, type: T.Type ) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: self.storyboardID) as! T
        return controller
    }
    
    static func getController(storyboard: Storyboard) -> Self {
        return getControllerObject(storyboard: storyboard.rawValue, type: self)
    }
    func shareApp(appUrl urlString:String, sorceView: UIView, sender: UIButton? = nil){
        if let urlStr = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            let objectsToShare = [urlStr]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //if iPhone
            if UIDevice.isPhone {
                self.present(activityVC, animated: true, completion: nil)
            }
            else {
                //In iPad Change Rect to position Popover
                if let btn = sender{
                    activityVC.popoverPresentationController?.sourceRect = btn.frame
                    activityVC.popoverPresentationController?.sourceView = sorceView
                }
                self.present(activityVC, animated: true, completion: nil)
            }
        }
    }
    func showPopUp(title: String, message: String, optionTypeCancel: String, optionTypeOther: String, complitationHandler: @escaping ((Int) -> ())){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: optionTypeCancel, style: .default){ _ in
            alert.dismiss(animated: true, completion: nil)
        }
        let Logout = UIAlertAction.init(title: optionTypeOther, style: .destructive){ _ in
            alert.dismiss(animated: true){
                //self.logoutApi()
                complitationHandler(1)
            }
        }
        alert.addAction(cancel)
        alert.addAction(Logout)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    func popToController<T: UIViewController>(controllerType: T.Type) {
        let controllers = (self.navigationController?.viewControllers ?? []).reversed()
        for controller in controllers {
            if controller.isKind(of: controllerType) {
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    func showPopUp(storyboard: Storyboard, controllerType type: UIViewController.Type) {
        let controller = type.self.getController(storyboard: storyboard)
        self.showPopUp(controller)
    }
    
    func showPopUp(_ controller: UIViewController) {
        controller.modalTransitionStyle     = UIModalTransitionStyle.crossDissolve
        controller.modalPresentationStyle   = UIModalPresentationStyle.overFullScreen
        controller.view.backgroundColor     = UIColor.darkGray.withAlphaComponent(0.5)
        self.present(controller, animated: true, completion: nil)
    }
    
    //   MARK:- Chamge Status Bar Color
    func statusBarColor(headerColor:UIColor){
        let statusBarView = UIView()
        if UIDevice.current.orientation.isLandscape {
            statusBarView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
            self.view.addSubview(statusBarView)
        }else{
            if #available(iOS 13.0, *){
                let height = (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate).window?.windowScene?.statusBarManager?.statusBarFrame.height ?? CGFloat()
                let width = kScreenHeight > kScreenWidth ? kScreenHeight : kScreenWidth
                statusBarView.frame = CGRect(x: 0, y: 0, width: width, height: height)
                statusBarView.backgroundColor = headerColor
            }else{
                statusBarView.frame = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as! CGRect
                statusBarView.backgroundColor = headerColor
            }
            self.view.addSubview(statusBarView)
        }
    }
    
    func getStatusBarHeight() -> CGFloat{
        if #available(iOS 13.0, *){
            let height = (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate).window?.windowScene?.statusBarManager?.statusBarFrame.height ?? CGFloat()
            return height
        }else{
            let rect = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as! CGRect
            return(rect.height)
        }
    }
    func showAlert(withTitle title: String, withMessage message:String, completion: @escaping (Int)->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
            completion(1)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(ok)
        alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    func showAlertWithOK(withTitle title: String, withMessage message:String, completion: @escaping (Int)->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.dismiss(animated: true) {
                completion(1)
            }
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
extension UIViewController {
    var alertController: UIAlertController? {
        guard let alert = UIApplication.topViewController() as? UIAlertController else { return nil }
        return alert
    }
    func showSimpleAlert(message:String) {
        let title = kAppName
        let alert = UIAlertController(title: title, message: message,preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    static func getStoryboardID()->String
    {
        return String.init(describing: self)
    }
    //    static func storyboardID()->String
    //     {
    //       return String.init(describing: self)
    //       }
}


