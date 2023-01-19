//
//  AppConstant.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation
import UIKit
//import DropDown


let kAppName                    = "MoFitz"
let kIsTutorialAlreadyShown       = "isTutorialAlreadyShown"
let kIsUserLoggedIn              = "isUserLoggedIn"
let kLoggedInAccessToken          = "access_token"
let kLoggedInUserDetails          = "loggedInUserDetails"
let kLoggedInUserId              = "loggedInUserId"
let kLatitude                   = "latitude"
let kLongitude                  = "longitude"
let kIsOtpVerified              = "is_mobile_verified"
let kIsProfileCreated           = "is_profile_create"
let kIs_Active                 = "is_active"
let kIs_Notification            = "is_notification"
let kIsAppInstalled             = "isAppInstalled"
let kAccessToken                = "Authorization"
let kDeviceToken                = "device_token"
let kUserClass                  = "class"
let iosDeviceType               = "1"
let iosDeviceTokan              = "123456789"
let kLoginUserID                = "USERID"
let kKey                       = "key"
let kResponse                   = "response"
let kMessage                    = "message"
let kProfilePicture              = "profilePic"
let kMedia                      = "media"
let kMediaType                   = "media_type"
let kIsEmailVerified              = "is_email_verify"
let kIsProfileCreate              = "is_profile_create"
let kMediaFiles                  = "media_files"
let kLocation                    = "location"
let kIsProfilePicture             = "is_profile_picture"
let kMediafiles                  = "media_files"
let kOtpVerification              = "user/otp_verification"
let kData                       = "data"

let kBaseUrl                    = "https://weboneservices.com/future-backoffice/public/api/"
let kImageBaseUrl               = "https://weboneservices.com/future-backoffice/public/"
let kScreenWidth                = UIScreen.main.bounds.size.width
let kScreenHeight               = UIScreen.main.bounds.size.height
let iimageCache                 = NSCache<NSString, AnyObject>()
var kSharedAppDelegate          = UIApplication.shared.delegate as? AppDelegate

//MARK: - Parameters
public enum Parameter {
    case email
    case password
    case otp
    case customerId
    case name
    case newPassword
    case mobile
    case image
    case dob
    case height
    case weight
    case gender
}
//MARK: - EndPoints
enum EndPoints {
    case login
    case signup
    case verifyOTP
    case forgetPassword
    case resendOTP
    case changePassword
    case getprofile
    case updateProfile
    case dashboard
    
}

struct ValidationError {
    static let email = "Please enter your email"
    static let validEmail = "Please enter your valid email"
    static let password = "Please enter your password"
    static let validPassword = "Password must be atleast 6 characters"
    static let name = "Please enter your name"
    static let validName = "Please enter valid name"
    static let OTP1 = "All fields are required, Please enter first"
    static let OTP2 = "All fields are required, Please enter second"
    static let OTP3 = "All fields are required, Please enter third"
    static let OTP4 = "All fields are required, Please enter fourth"
    static let oldPassword = "Please enter old password"
    static let newPassword = "Please enter new password"
    static let confirmPassword = "Pleaase enter confirm Password"
    static let passwordNotMatch = "New password and confirm password does not match"
    static let enterOtp = "Please enter otp"
    static let mobileNumber = "Please enter mobile number"
    static let validMobile = "Mobile number shoulb be 10 digit"
    static let dob = "Please enter date of birth"
    static let height = "Please enter height"
    static let weight = "Please enter weight"
    static let gender = "Please select gender"
}

func print_debug(items: Any) {
    print(items)
}
func Localised(_ aString:String) -> String {
    return NSLocalizedString(aString, comment: aString)
}
enum OpenMediaType: Int {
    case camera = 0
    case photoLibrary = 1
    case videoCamera = 2
    case videoLibrary = 3
}

enum ScreenFrom {
    case Login
    case Signup
    case ChangePassword
    case Forgot
}
enum StatusCode: String {
    case Success = "200"
    case EmailRegistered = "408"
    case OTPNotVerified = "405"
    case InvalidPass = "406"
    case EmailNotFound = "407"
    case InvalidOTP = "401"
    case UnauthenticateUser = "402"
}

//MARK:- CHECK DEVICE TYPE
public extension UIDevice {
    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
public func Log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
#if DEBUG
    guard let object = object else { return }
    print("***** \(Date()) \(filename.components(separatedBy: "/").last ?? "") (line: \(line)) :: \(funcname) :: \(object)")
#endif
}

//MARK: Create Attributred Text
func createAttributedText(normalText:String, boldText:String) -> NSAttributedString{
    
    let attributedString = NSMutableAttributedString()
    let attrsMedium = [NSAttributedString.Key.font : UIFont(name: FONTS.poppinsMedium, size: 15), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
    let mediumString = NSMutableAttributedString(string: normalText, attributes:attrsMedium as [NSAttributedString.Key : Any])
    let attrs = [NSAttributedString.Key.font : UIFont(name: FONTS.poppinsBold, size: 15), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
    let boldString = NSMutableAttributedString(string: boldText, attributes:attrs as [NSAttributedString.Key : Any])
    attributedString.append(mediumString)
    attributedString.append(boldString)
    return attributedString
}
//func showDropDown(sender: UIView, dataSources:[String], handler: @escaping (_ selectedIndex: Int, _ item: String) -> Void){
//    let dropDown = DropDown()
//    dropDown.anchorView = sender
//    dropDown.dataSource = dataSources
//    dropDown.selectionAction = { (index: Int, item: String) in
//        handler(index, item)
//    }
//    dropDown.show()
//}
extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }
    
    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }
    
    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }
    
    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
}
