//
//  Common.swift
//  Car Service Booking App
//
//  Created by Aditya Mathur on 09/02/21.
//


/*import Foundation
import UIKit
//import MaterialComponents.MaterialTextControls_OutlinedTextFields

extension UIColor {
    
    class func color(fromHexString hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).lowercased()
        
        if (cString.hasPrefix("#")) {
            cString = cString.replacingOccurrences(of: "#", with: "")
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class var red: UIColor {
        get {
            return UIColor.color(fromHexString: "#F04E37")
        }
    }
    
    class var orange: UIColor {
        get {
            return UIColor.color(fromHexString: "#EC561F")
        }
    }
    
    class var yellow: UIColor {
        get {
            return UIColor.color(fromHexString: "#FEC353")
        }
    }
    
    class var pink: UIColor {
        get {
            return UIColor.color(fromHexString: "#FC2D3F")
        }
    }
    
    class var green: UIColor {
        get {
            return UIColor.color(fromHexString: "#54BD89")
        }
    }
    
    class var gray: UIColor {
        get {
            return UIColor.color(fromHexString: "#E0E0E0")
        }
    }
    
    class var lightGray: UIColor {
        get {
            return UIColor.color(fromHexString: "#888888")
        }
    }
    
    class var darkText: UIColor {
        get {
            return UIColor.color(fromHexString: "#888888")
        }
    }
    
    class var text: UIColor {
        get {
            return UIColor.color(fromHexString: "#374752")
        }
    }
    
    class var lightText: UIColor {
        get {
            return UIColor.color(fromHexString: "#888888")
        }
    }
    
    class var veryLightText: UIColor {
        get {
            return UIColor.color(fromHexString: "#BABABA")
        }
    }
    
    class var grayText: UIColor {
        get {
            return UIColor.color(fromHexString: "#888888")
        }
    }
    
}

extension UIFont {
    
    enum FontStyle {
        case normal
        case italic
    }
    
    enum FontWeight {
        case regular
        case light
        case medium
        case bold
        case black
    }
    
    private static func getTitleFontName(_ style: FontStyle, _ weight: FontWeight) -> String {
        
        switch style {
        case .normal:
            switch weight {
            case .regular:
                return "RubikRoman-Regular"
            case .light:
                return "Rubik-Light"
            case .medium:
                return "RubikRoman-Medium"
            case .bold:
                return "RubikRoman-Bold"
            case .black:
                return "RubikRoman-Black"
            }
        case .italic:
            switch weight {
            case .regular:
                return "RubikItalic-Regular"
            case .light:
                return "Rubik-LightItalic"
            case .medium:
                return "RubikItalic-Medium"
            case .bold:
                return "RubikItalic-Bold"
            case .black:
                return "RubikItalic-Black"
            }
        }
        
    }
    
    private static func getBodyFontName(_ style: FontStyle, _ weight: FontWeight) -> String {
        
        switch style {
        case .normal:
            switch weight {
            case .regular:
                return "NunitoSans-Regular"
            case .light:
                return "NunitoSans-Light"
            case .medium:
                return "NunitoSans-SemiBold"
            case .bold:
                return "NunitoSans-Bold"
            case .black:
                return "NunitoSans-Black"
            }
        case .italic:
            switch weight {
            case .regular:
                return "NunitoSans-Italic"
            case .light:
                return "NunitoSans-LightItalic"
            case .medium:
                return "NunitoSans-SemiBoldItalic"
            case .bold:
                return "NunitoSans-BoldItalic"
            case .black:
                return "NunitoSans-BlackItalic"
            }
        }
        
    }
    
    private static func getErrorFontName(_ style: FontStyle, _ weight: FontWeight) -> String {
        
        switch style {
        case .normal:
            switch weight {
            case .regular:
                return "Montserrat-Regular"
            case .light:
                return "Montserrat-Light"
            case .medium:
                return "Montserrat-Medium"
            case .bold:
                return "Montserrat-Bold"
            case .black:
                return "Montserrat-Black"
            }
        case .italic:
            switch weight {
            case .regular:
                return "Montserrat-Italic"
            case .light:
                return "Montserrat-LightItalic"
            case .medium:
                return "Montserrat-MediumItalic"
            case .bold:
                return "Montserrat-BoldItalic"
            case .black:
                return "Montserrat-BlackItalic"
            }
        }
        
    }
    
    static func appTitleFont(size: CGFloat, style: FontStyle, weight: FontWeight) -> UIFont {
        
        let font = UIFont(name: getTitleFontName(style, weight), size: size)
        if font != nil {
            return font!
        }
        return UIFont.systemFont(ofSize: 17, weight: .regular)
        
    }
    
    static func appBodyFont(size: CGFloat, style: FontStyle, weight: FontWeight) -> UIFont {
        
        let font = UIFont(name: getBodyFontName(style, weight), size: size)
        if font != nil {
            return font!
        }
        return UIFont.systemFont(ofSize: 17, weight: .regular)
        
    }
    
    static func appErrorFont(size: CGFloat, style: FontStyle, weight: FontWeight) -> UIFont {
        
        let font = UIFont(name: getErrorFontName(style, weight), size: size)
        if font != nil {
            return font!
        }
        return UIFont.systemFont(ofSize: 17, weight: .regular)
        
    }
    
}

extension MDCOutlinedTextField {
    
    func setAppTheme() {
        setOutlineColor(.orange, for: .editing)
        setOutlineColor(.veryLightText, for: .normal)
        
        setFloatingLabelColor(.orange, for: .normal)
        setFloatingLabelColor(.orange, for: .editing)
        setNormalLabelColor(.veryLightText, for: .normal)
        setNormalLabelColor(.red, for: .editing)
        
        label.font = UIFont.appBodyFont(size: 14, style: .normal, weight: .regular)
        
        font = UIFont.appBodyFont(size: 14, style: .normal, weight: .regular)
        setTextColor(.text, for: .normal)
        tintColor = .red
        
        leadingAssistiveLabel.textColor = .red
        leadingAssistiveLabel.font = UIFont.appErrorFont(size: 10, style: .normal, weight: .regular)
        
        trailingAssistiveLabel.textColor = .red
        trailingAssistiveLabel.font = UIFont.appErrorFont(size: 10, style: .normal, weight: .regular)
    }
    
    func showError(_ text: String) {
        setOutlineColor(.red, for: .editing)
        setOutlineColor(.red, for: .normal)
        leadingAssistiveLabel.text = text
    }
    
    func hideError() {
        setOutlineColor(.blue, for: .editing)
        setOutlineColor(.veryLightText, for: .normal)
        leadingAssistiveLabel.text = nil
    }
    
}

extension UIButton {
    
    func setFilledTheme(_ title: String) {
        layer.masksToBounds = true
        layer.cornerRadius = 8
        backgroundColor = .blue
        setTitle(title.uppercased(), for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.appTitleFont(size: 16, style: .normal, weight: .medium)
    }
    
}

extension UIAlertController {
    
    class func errorAlert(_ message: String?, from parent: UIViewController) {
        errorAlert(message: message, from: parent)
    }
    
    class func errorAlert(title: String = "Oops!", message: String?, from parent: UIViewController, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
        parent.present(alertController, animated: true, completion: nil)
    }
    
    class func messageAlert(_ message: String?, from parent: UIViewController) {
        messageAlert(message: message, from: parent)
    }
    
    class func messageAlert(title: String = "Please Note!", message: String?, from parent: UIViewController, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
        parent.present(alertController, animated: true, completion: nil)
    }
    
}

extension UIView {
    
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var widthConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    func getConstraint(for identfier: String) -> NSLayoutConstraint? {
        return constraints.first(where: { $0.identifier == identfier })
    }
    
    func addRippleEffect() {
        /*! Creates a circular path around the view*/
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        /*! Position where the shape layer should be */
        let shapePosition = CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height / 2.0)
        let rippleShape = CAShapeLayer()
        rippleShape.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        rippleShape.path = path.cgPath
        rippleShape.fillColor = UIColor.clear.cgColor
        rippleShape.strokeColor = UIColor.darkGray.cgColor
        rippleShape.lineWidth = 4
        rippleShape.position = shapePosition
        rippleShape.opacity = 0
        
        /*! Add the ripple layer as the sublayer of the reference view */
        layer.addSublayer(rippleShape)
        /*! Create scale animation of the ripples */
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(2, 2, 1))
        /*! Create animation for opacity of the ripples */
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        opacityAnim.fromValue = 1
        opacityAnim.toValue = nil
        /*! Group the opacity and scale animations */
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnim, opacityAnim]
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.duration = CFTimeInterval(0.7)
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = true
        rippleShape.add(animation, forKey: "rippleEffect")
    }
    
    func makeConstraints(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, topMargin: CGFloat, leftMargin: CGFloat, rightMargin: CGFloat, bottomMargin: CGFloat, width: CGFloat, height: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topMargin).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: leftMargin).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -rightMargin).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomMargin).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach{ addSubview($0) }
    }
    
    
    func addshadow(top: Bool, left: Bool, bottom: Bool, right: Bool, shadowRadius: CGFloat = 2.0, shadowColor: UIColor) {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 1.0
        self.layer.shadowColor = shadowColor.cgColor
        
        let path = UIBezierPath()
        var x: CGFloat = 0
        var y: CGFloat = 0
        var viewWidth = self.frame.width
        var viewHeight = self.frame.height
        if (!top) {
            y+=(shadowRadius+1)
        }
        if (!bottom) {
            viewHeight-=(shadowRadius+1)
        }
        if (!left) {
            x+=(shadowRadius+1)
        }
        if (!right) {
            viewWidth-=(shadowRadius+1)
        }
        path.move(to: CGPoint(x: x, y: y))
        path.addLine(to: CGPoint(x: x, y: viewHeight))
        path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
        path.addLine(to: CGPoint(x: viewWidth, y: y))
        path.close()
        self.layer.shadowPath = path.cgPath
    }
}

extension UIImage {
    
    class var cardImage: UIImage? {
        get {
            if let img = UIImage(named: "card.png") {
                return img.resizableImage(withCapInsets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), resizingMode: .stretch)
            }
            return nil
        }
    }
    
    class var selectedCardImage: UIImage? {
        get {
            if let img = UIImage(named: "card-selected.png") {
                return img.resizableImage(withCapInsets: UIEdgeInsets(top: 26, left: 16, bottom: 16, right: 26), resizingMode: .stretch)
            }
            return nil
        }
    }
    
    class var copounImage: UIImage? {
        get {
            if let img = UIImage(named: "copoun.png") {
                return img.resizableImage(withCapInsets: UIEdgeInsets(top: 16, left: 38, bottom: 16, right: 38), resizingMode: .stretch)
            }
            return nil
        }
    }
    
    class var zigzag: UIImage? {
        get {
            if let img = UIImage(named: "zigzagSeprator.png") {
                return img.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .tile)
            }
            return nil
        }
    }
    
    class var zigzagInverted: UIImage? {
        get {
            if let img = UIImage(named: "zigzagSepratorInverted.png") {
                return img.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .tile)
            }
            return nil
        }
    }
    
}

extension NSNumber {
    
    func currency() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_IN")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: self)
    }
    
    func percent() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        formatter.multiplier = NSNumber(integerLiteral: 1)
        return formatter.string(from: self)
    }
    
}

class InfoContainingButton: UIButton {
    
    var info: [String : Any]!
    
}

extension URL {
    
    var uti: String {
        return (try? self.resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier ?? "public.data"
    }
    
}

class UAString: NSObject {
    
    var userAgent: String!
    
    private func DarwinVersion() -> String {
        var sysinfo = utsname()
        uname(&sysinfo)
        let dv = String(bytes: Data(bytes: &sysinfo.release, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
        return "Darwin/\(dv)"
    }
    
    private func CFNetworkVersion() -> String {
        let dictionary = Bundle(identifier: "com.apple.CFNetwork")?.infoDictionary!
        let version = dictionary?["CFBundleShortVersionString"] as! String
        return "CFNetwork/\(version)"
    }
    
    private func deviceVersion() -> String {
        let currentDevice = UIDevice.current
        return "\(currentDevice.systemName)/\(currentDevice.systemVersion)"
    }
    
    private func deviceName() -> String {
        var sysinfo = utsname()
        uname(&sysinfo)
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
    private func appNameAndVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let name = dictionary["CFBundleName"] as! String
        return "\(name)/\(version)"
    }
    
    override init() {
        
        super.init()
        
        userAgent = "\(appNameAndVersion()) \(deviceName()) \(deviceVersion()) \(CFNetworkVersion()) \(DarwinVersion())"
        
    }
    
}

extension UIButton {
    
    func alignVertical(spacing: CGFloat = 6.0) {
        guard let imageSize = imageView?.image?.size,
              let text = titleLabel?.text,
              let font = titleLabel?.font
        else { return }
        
        titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageSize.width,
            bottom: -(imageSize.height + spacing),
            right: 0.0
        )
        
        let titleSize = text.size(withAttributes: [.font: font])
        imageEdgeInsets = UIEdgeInsets(
            top: -(titleSize.height + spacing),
            left: 0.0,
            bottom: 0.0,
            right: -titleSize.width
        )
        
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
        contentEdgeInsets = UIEdgeInsets(
            top: edgeOffset,
            left: 0.0,
            bottom: edgeOffset,
            right: 0.0
        )
    }
    
}

extension String {
    
    var numberValue: NSNumber? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: self)
    }
    
    func getHTMLAttributedString(fontFamily: String = "Nunito Sans", fontName: String = "NunitoSans-Regular", fontSize: Int = 14) -> NSAttributedString {
        let modifiedFont = String(format:"<span style=\"font-family: '%@', '%@'; font-size:%dpx\">%@</span>",fontFamily, fontName, fontSize, self)
        let attrStr = try! NSMutableAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        return attrStr
    }
    
    func strikeThrough()->NSAttributedString{
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

extension Date {
    
    func timeAgo() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        return String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current)
    }
    
    func daysAgo() -> Int {
        let diffs = Calendar.current.dateComponents([.day], from: self, to: Date())
        return diffs.day ?? 0
    }
    
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat = 20){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

func addBoldText(fullString: NSString, boldPartsOfString: Array<NSString>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
    let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
    let boldFontAttribute = [NSAttributedString.Key.font:boldFont!]
    let boldString = NSMutableAttributedString(string: "\(fullString)\n" as String, attributes:nonBoldFontAttribute)
    for i in 0 ..< boldPartsOfString.count {
        boldString.addAttributes(boldFontAttribute, range: fullString.range(of: boldPartsOfString[i] as String))
    }
    return boldString
}
func getDevice() -> String {
   var systemInfo = utsname()
   uname(&systemInfo)
   let machineMirror = Mirror(reflecting: systemInfo.machine)
   let identifier = machineMirror.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8 , value != 0 else { return identifier }
       return identifier + String(UnicodeScalar(UInt8(value)))
   }
   return identifier
}
*/
