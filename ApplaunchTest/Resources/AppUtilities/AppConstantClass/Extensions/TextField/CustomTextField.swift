//
//  CustomTextField.swift
//  Mofitz
//
//  Created by Nitesh jha on 16/11/22.
//

import Foundation
import UIKit

class NJTextField: UITextField, UITextFieldDelegate{
    var myPlaceholder = UILabel()
    var myImage = UIImageView()
    var myCenter:NSLayoutConstraint?
    var myLeading:NSLayoutConstraint?
    var spacing = 15
    var padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    var image:UIImage?
    required init?(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
        self.delegate = self
        
        padding = UIEdgeInsets(top: 0, left: CGFloat(spacing), bottom: 0, right: CGFloat(spacing))
        myPlaceholder.font = .systemFont(ofSize: 13)
        myPlaceholder.text = "\(self.placeholder ?? "")"
        myPlaceholder.textColor = #colorLiteral(red: 0.662745098, green: 0.662745098, blue: 0.662745098, alpha: 1)
        myPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myPlaceholder.backgroundColor = .white
        self.placeholder = ""
        self.addSubview(myImage)
        self.addSubview(myPlaceholder)
        let lead =  myPlaceholder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(15))
        lead.identifier = "labelLead"
        NSLayoutConstraint.activate([myImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),myImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),myPlaceholder.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),lead
        ])
        self.myCenter =  self.constraints.filter{
            $0.secondAttribute == .centerY
        }[1]
        self.myLeading =  self.constraints.filter{
            $0.firstAttribute == .leading
        }[1]
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    func initiateAnim(){
        if (self.text?.count ?? 0) < 1{
            self.myCenter?.constant = -self.frame.height/2
            self.myLeading?.constant = 15
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn]) {
                self.layoutIfNeeded()
            }
            self.isHidden = false
        }
    }
    func animHide(){
        self.myCenter?.constant = 0
        self.myLeading?.constant = CGFloat(spacing)
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn]) {
            self.myPlaceholder.layoutIfNeeded()
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        initiateAnim()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.text!.count < 1 {
            self.animHide()
        }
    }
    func addTextFieldImage(_ image : UIImage = #imageLiteral(resourceName: "Referral")){
        self.leftViewMode = .always
        let imageView = UIImageView()
        imageView.image = image
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),imageView.heightAnchor.constraint(equalToConstant: 24),imageView.widthAnchor.constraint(equalToConstant: 24)])
        if (imageView.image != nil) {
            spacing = 35
            padding = UIEdgeInsets(top: 0, left: CGFloat(spacing), bottom: 0, right: CGFloat(spacing))
            self.myLeading?.constant = CGFloat(spacing)
        }
    }
    
    func addTextFieldImages(_ image : UIImage = #imageLiteral(resourceName: "Referral")){
        self.leftViewMode = .always
        let imageView = UIImageView()
        imageView.image = image
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),imageView.heightAnchor.constraint(equalToConstant: 24),imageView.widthAnchor.constraint(equalToConstant: 24)])
        if (imageView.image != nil) {
            spacing = 40
            padding = UIEdgeInsets(top: 0, left: CGFloat(spacing), bottom: 0, right: CGFloat(spacing))
            self.myLeading?.constant = CGFloat(spacing)
        }
    }
    
    
}

