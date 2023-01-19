//
//  EndPoints.swift
//  Mofitz
//
//  Created by Nitesh jha on 17/12/22.
//

import Foundation
//MARK: - EndPoints
extension EndPoints {
    private var baseURL: String { return "https://weboneservices.com/future-backoffice/public/api/" }
    private var fullPath: String {
        var endPoints: String = ""
        switch self {
        case .login:
            endPoints = "customer/login"
        case .signup:
            endPoints = "customer/signup"
        case .verifyOTP:
            endPoints = "customer/verify-Otp"
        case .forgetPassword:
            endPoints = "customer/forgot-password"
        case .resendOTP:
            endPoints = "customer/resend-Otp"
        case .changePassword:
            endPoints = "customer/change-password"
        case .getprofile:
            endPoints = "customer/costomer-profile"
        case .updateProfile:
            endPoints = "customer/update-profile"
        case .dashboard:
            endPoints = "customer/dashboard"
        }
        return baseURL + endPoints
    }
    
    var url: URL {
        guard let url = URL(string: fullPath) else {
            preconditionFailure("The url used in \(EndPoints.self) is not valid")
        }
        return url
    }
}

//MARK: - Parameters
extension Parameter {
    public var rawValue: String {
        switch self {
        case .email:
            return "email"
        case .password:
            return "password"
        case .otp:
            return "otp"
        case .customerId:
            return "customer_id"
        case .name:
            return "name"
        case .newPassword:
            return "new_password"
        case .mobile:
            return "mobile"
        case .image:
            return "image"
        case .dob:
            return "dob"
        case .height:
            return "height"
        case .weight:
            return "weight"
        case .gender:
            return "gender"
        }
    }
}

