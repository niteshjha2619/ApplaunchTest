//
//  Constant.swift
//  RajputIndianCuisineiOS
//
//  Created by Mrinal Tyagi on 15/01/22.
//

import Foundation
import UIKit

let deepLinkInfoNotification = "DeepLinkInfoNotification"
struct ScreenSize {
    static let SCREEN               = UIScreen.main.bounds
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONESE          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE8          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE8PLUS         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_XS         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad
}

struct iOSVersion {
    static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS7 = (iOSVersion.SYS_VERSION_FLOAT < 8.0 && iOSVersion.SYS_VERSION_FLOAT >= 7.0)
    static let iOS8 = (iOSVersion.SYS_VERSION_FLOAT >= 8.0 && iOSVersion.SYS_VERSION_FLOAT < 9.0)
    static let iOS9 = (iOSVersion.SYS_VERSION_FLOAT >= 9.0 && iOSVersion.SYS_VERSION_FLOAT < 10.0)
    static let iOS10 = (iOSVersion.SYS_VERSION_FLOAT >= 10.0 && iOSVersion.SYS_VERSION_FLOAT < 11.0)
    static let iOS11 = (iOSVersion.SYS_VERSION_FLOAT >= 11.0 && iOSVersion.SYS_VERSION_FLOAT < 12.0)
}


struct DeviceOrientation {
    static let IS_PORTRAIT = UIDevice.current.orientation.isPortrait
    static let IS_LANDSCAPE = UIDevice.current.orientation.isLandscape
}

let KAppleLanguage = "AppleLanguages"

struct Constants {
    
    //    static let selectedRestaurantID = "selectedRestaurantID"
    static let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
    static let mainStoryboard2: UIStoryboard = UIStoryboard(name: "ChannelPatner",bundle: nil)
    
    static let BankStoryboard: UIStoryboard = UIStoryboard(name: "BankDetails",bundle: nil)
    
    static let dashBoardStoryBoard : UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
  static let captureLeadStoryBoard : UIStoryboard = UIStoryboard(name: "CaptureLead", bundle: nil)
  static let dashboardStoryBoard : UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
  static let channelPatner : UIStoryboard = UIStoryboard(name: "ChannelPatner", bundle: nil)

    //SellMarketPlace
    static let SellMarketPlaceStoryboard: UIStoryboard = UIStoryboard(name: "SellMarketPlace",bundle: nil)
    
    static let APP_NAME = "MoFitZ"
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let tabForceChangeNotification = "tabForceChangeNotification"
    
    static let isLoginSkipped = "isLoginSkipped"
    
    static let isfinishLaunch = "isfinishLaunch"
    
    static let sessionToken = "sessionToken"
    
    static let SegmentNotifications = "segment"
    
    static func isUserAuthenticated()->Bool{
        return UserDefaults.standard.bool(forKey: Constants.AuthenticUser)
    }
    
    
    static let BASE_URL = "https://weboneservices.com/future-backoffice/public/api/"
    
    
    static let Device_UUID = UIDevice.current.identifierForVendor?.uuidString.replacingOccurrences(of: "-", with: "")
    static let AuthenticUser = "UserAuthenticated"
    
    static let USERID = "UserId"
    static let isLoggedIn = "UserLoggedIn"
    static let isIntroDone = "isIntroDone"
    static let ProfileData = "userProfileData"
    static let SavedProfileData = "savedUserProfileDataa"
    
    
    static let currencySymbol = "$"
    
}

struct TableCellIdentifier {
    static let videoCell = "VideoTableViewCell"
    static let profileDetailsCell = "ProfileDetailsTableViewCell"
    static let settingTableCell = "SettingsTableViewCell"
    static let subscriptionTableCell = "SubscriptionListTableViewCell"
}
struct CollectionCellIdentifier {
    static let segmentCell = "SegmentCollectionViewCell"
    static let bannerCell = "BannerCollectionViewCell"
}


struct MethodName {
  static let getDashboard = "DashBoard"
  static let GetDesignation = "GetDesignation"
  static let GetDSTUserReportTo  = "GetDSTUserByDesignation?designation_id="
  static let SigninWithPassword = "SigninWithPassword"
  static let SigninWithOTP = "SigninWithOTP"
  static let CreateUser = "CreateUser"
  static let GenerateOTP = "GenerateOTP"
  static let GetActiveProjects = "GetActiveProjects"
  static let CreateCaptureLead = "CreateLead"
  static let GetLeadStage = "GetLeadStages"
  static let GetUserByChannelPartnerId = "GetUserByChannelPartnerId"
  static let GetActiveDSTList = "GetActiveDSTList"
    static let LeadStageUpdate = "LeadStageUpdate"
    static let LeadAssignment = "LeadAssignment"
  static func getAllLead(userTypeId:String,pageNumber:String,searchText:String,leadstageId:Int) -> String {
    if leadstageId == -1{
    return "ViewLeadsBySource?user_type_id=\(userTypeId)&page_no=\(pageNumber)&search=\(searchText)"
    }else{
      return "ViewLeadsBySource?user_type_id=\(userTypeId)&lead_stage_id=\(leadstageId)&page_no=\(pageNumber)&search=\(searchText)"

    }
  }
  static let GetLeadAssignmentHistory = "GetLeadAssignmentHistory?lead_id="
  static let GetLeadStageHistoryByLeadId = "GetLeadStageHistoryByLeadId?lead_id="
    static let ChannelPartnersList = "ChannelPartnersList"
    static let GetUserListByUserType = "GetUserListByUserType"
  static let getChannelPAtnerById = "GetChannelPartnerById?channel_partner_id="
  static func approveChanelPAtner(patnerID:String, isApproved:Bool) -> String {
    return "approveChannelPartner?ChannelPartnerId=\(patnerID)&is_approved=\(isApproved)"
  }
  static func GetLeadListByChannelPartnerId(channel_partner_id:Int,lead_stage_id:Int,pageNo:Int,searchTxt:String) ->String{
    
    if lead_stage_id == -1{
      return "GetLeadListByChannelPartnerId?channel_partner_id=\(channel_partner_id)&page_no=\(pageNo)&search=\(searchTxt)"
    }else{
      return "GetLeadListByChannelPartnerId?channel_partner_id=\(channel_partner_id)&lead_stage_id=\(lead_stage_id)&page_no=\(pageNo)&search=\(searchTxt)"
    }
  }
    static let ChannelPartnerVerification = "ChannelPartnerVerification"
    static let CPGenerationOTPForVerification = "CPGenerationOTPForVerification"

    static let BankVerification = "BankVerification"
    static let GetCPAgreement = "GetCPAgreement"
    static let CreateChannelPartner = "CreateChannelPartner"
    static let Signout = "Signout"

}


struct Colors {
    static let bottomColor = UIColor(red: 231, green: 86, blue: 31, transparency: 0.3)
    static let bottomProfile = UIColor(hexString: "#E8ECEF")
    static let segmentSelectedColor = UIColor(hexString: "#030303")
    static let segmentDeselectedColor = UIColor(hexString: "#BABABA")
    static let THEME_Dark_RED =  #colorLiteral(red: 0.7215686275, green: 0.1254901961, blue: 0.1450980392, alpha: 1)
    static let THEME_ORANGE = #colorLiteral(red: 0.9607843137, green: 0.5411764706, blue: 0.1215686275, alpha: 1)
    static let THEME_Grey = #colorLiteral(red: 0.1490196078, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
    static let THEME_SkyBlue = #colorLiteral(red: 0.007843137255, green: 0.4901960784, blue: 0.9411764706, alpha: 1)
  
  
  static let ButtonColor =   #colorLiteral(red: 0.768627451, green: 0.0862745098, blue: 0.1098039216, alpha: 1)  
    
    static let Vegan  =  #colorLiteral(red: 0.2638585567, green: 0.4012454748, blue: 0.060865812, alpha: 1)
    static let Glutenfree =  #colorLiteral(red: 0.9637146592, green: 0.6768237948, blue: 0.1076728478, alpha: 1)
    static let Organic =   #colorLiteral(red: 0.3192655146, green: 0.4885534048, blue: 0.126709938, alpha: 1)
    static let Nuts =  #colorLiteral(red: 0.7260010839, green: 0.5099875331, blue: 0.313770175, alpha: 1)
    static let Halal =  #colorLiteral(red: 0.04785164446, green: 0.5156025887, blue: 0.05057754368, alpha: 1)
    
  //
    static let CenterTabColor =  #colorLiteral(red: 0.5960784314, green: 0.2039215686, blue: 0.003921568627, alpha: 1)
    
  static let background = UIColor(red: 0.47, green: 0.8, blue: 0.77, alpha: 1.0)
    static let popupBackground = UIColor.white
    static let primaryAction = UIColor(red: 0.14, green: 0.6, blue: 0.55, alpha: 1)
    static let applePayBackground = UIColor.black
    static let hairlineColor = UIColor.black.withAlphaComponent(0.1)
    static let descriptionFont = UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1)
    static let navigationBarTintColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
    static let heading = UIColor(red: 0.14, green: 0.6, blue: 0.55, alpha: 1)
}

struct Style {
    static func setDefaults() {
       // UINavigationBar.appearance().tintColor = Colors.THEME_RED
    }
}

struct FONTS {
  static let poppinsBold = "Poppins-Bold"
    static let poppinsMedium = "Poppins-Medium"

}

//MARK: ---------Method Constants---------
let kSharedSceneDelegate        = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
//let kSharedAppManager           = AppManager.shared
var kSharedUserDefaults         = UserDefaults.standard
let kSceneDelegateWindow = UIApplication.shared.connectedScenes.first as? UIWindowScene



let someError = "Some error has occured! Please try again"
let CheckInternet = "Please chek your internet connection"
let Right = "👉"
let InvalidEmailPAssword = "Invalid Email/Password! Please try again"
