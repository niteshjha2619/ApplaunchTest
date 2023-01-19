//
//  DocumentPickerHelper.swift
//  NetworkManager
//
//  Created by Creative Kids on 09/08/21.
//

import Foundation
import UIKit

protocol UIDocumentPickerExtendedDelegate {
    func docPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL)
}

//require UINavigationControllerDelegate also (already installed in above extension)
extension UIViewController: UIDocumentPickerDelegate {
    func openDocumentPicker(_ documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: {
            documentPicker.delegate = self
        })
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        controller.dismiss(animated: true, completion: nil)
        guard let viewC = self as? UIDocumentPickerExtendedDelegate else { return }
        viewC.docPicker(controller, didPickDocumentAt: url)
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
extension UITableViewCell: UIDocumentPickerDelegate {
    func openDocumentPicker(_ documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return}
        firstScene.windows.first?.rootViewController?.present(documentPicker,animated: true,completion: {
            documentPicker.delegate = self
        })
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        controller.dismiss(animated: true, completion: nil)
        guard let viewC = self as? UIDocumentPickerExtendedDelegate else { return }
        viewC.docPicker(controller, didPickDocumentAt: url)
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
