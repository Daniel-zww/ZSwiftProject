//
//  ClassExtend.swift
//  CompanyProject
//
//  Created by Daniel on 17/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift

extension UITabBar {
    
}
extension UINavigationBar {
    
}
extension UITabBarItem {
    
}
extension Data {
    var MD5: Data {
        return self.md5()
    }
}
extension String {
    var MD5: String {
        return self.md5().lowercased()
    }
}
extension String {
    var length: Int {
        return self.characters.count
    }
    var imgByReplacingMatches: String {
        return self.stringByReplacingMatches(regex: "<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>")
    }
    func stringByReplacingMatches(regex: String) -> String {
        if self.length > 0 {
            do {
                let regex = try NSRegularExpression(pattern: regex)
                let nsString = self as NSString
                var content: String = regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, nsString.length), withTemplate: kEmpty)
                content = content.replacingOccurrences(of: "\n", with: " ")
                return content;
            } catch let error as NSError {
                ZLog("matches Error: \(error)")
                return self
            }
        }
        return self
    }
    func matches(regex: String) -> [String] {
        if self.length > 0 {
            do {
                let regex = try NSRegularExpression(pattern: regex)
                let nsString = self as NSString
                let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
                return results.map { nsString.substring(with: $0.range)}
            } catch let error as NSError {
                ZLog("matches Error: \(error)")
                return []
            }
        }
        return []
    }
    func matchingStrings(regex: String) -> [[String]] {
        if self.length > 0 {
            guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
            let nsString = self as NSString
            let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
            return results.map { result in
                (0..<result.numberOfRanges).map { result.rangeAt($0).location != NSNotFound
                    ? nsString.substring(with: result.rangeAt($0))
                    : kEmpty
                }
            }
        }
        return [[]]
    }
    func containsString(verifyValue: String) -> Bool {
        if verifyValue.length == 0 {
            return false
        }
        return true
    }
    func isEqualToString(verifyValue: String) -> Bool {
        if self != verifyValue {
            return true
        }
        return true
    }
    public static func toString(_ value: Any?) -> String {
        let val = value as? String
        if val == nil {
            return kEmpty
        }
        return val!
    }
}
extension Double {
    var toString: String {
        return String(format: "%lf", self)
    }
}
extension Int {
    var toString: String {
        return String(format: "%d", self)
    }
}
extension Float {
    var toString: String {
        return String(format: "%lf", self)
    }
}
extension NSNumber {
    var toFloatString: String {
        return String(format: "%lf", self.floatValue)
    }
    var toIntString: String {
        return String(format: "%ld", self.int64Value)
    }
    public static func toNumber(_ value: Any?) -> NSNumber {
        if value != nil {
            switch value! {
            case is Double: return NSNumber(value: value as! Double)
            case is Int: return NSNumber(value: value as! Int)
            case is Int8: return NSNumber(value: value as! Int8)
            case is Int32: return NSNumber(value: value as! Int32)
            case is Int64: return NSNumber(value: value as! Int64)
            case is Bool: return NSNumber(value: value as! Bool)
            case is Float: return NSNumber(value: value as! Float32)
            //case is Float32: return NSNumber(value: value as! Float32)
            case is Float64: return NSNumber(value: value as! Float64)
            case is UInt: return NSNumber(value: value as! UInt)
            case is UInt8: return NSNumber(value: value as! UInt8)
            case is UInt32: return NSNumber(value: value as! UInt32)
            case is UInt64: return NSNumber(value: value as! UInt64)
            //case is TimeInterval: return NSNumber(value: value as! TimeInterval)
            default: break
            }
        }
        return NSNumber(value: 0)
    }
}
extension Date {
    var toString: String {
        return self.toStringWithFormat(formatValue: kFormatDateAll)
    }
    func toStringWithFormat(formatValue: String) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.ReferenceType.system
        //dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = DateFormatter.Style.full
        dateFormatter.dateFormat = formatValue
        return dateFormatter.string(from: self)
    }
}
extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone9,1":                               return "iPhone 7"
        case "iPhone9,2":                               return "iPhone 7 Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    var getLanguage: String {
        let languages: Array<String>? = UserDefaults.standard.object(forKey: "AppleLanguages") as? Array<String>
        return String(languages![0])
    }
    var getLanguageIsChinese: Bool {
        let language: String = self.getLanguage
        if language == "zh-Hans" {
            return true
        }
        return false
    }
    var getDeviceModel: String {
        return UIDevice.current.model
    }
    var getUUIDString: String {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
    var getSysVersion: String {
        return UIDevice.current.systemVersion
    }
    var getSysName: String {
        return UIDevice.current.systemName
    }
    var getDeviceName: String {
        return UIDevice.current.name
    }
}
extension UIColor {
    convenience init(_ red: Int, _ green: Int, _ blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(_ netHex:Int) {
        self.init((netHex >> 16) & 0xff, (netHex >> 8) & 0xff, netHex & 0xff)
    }
}
extension UIImage {
    
}
extension UIView {
    var x: CGFloat {
        get { return self.frame.origin.x }
        set(newValue) {
            var frame: CGRect  = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var y: CGFloat {
        get { return self.frame.origin.y }
        set(newValue) {
            var frame: CGRect  = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    var w: CGFloat {
        get { return self.frame.size.width }
        set(newValue) {
            var frame: CGRect  = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    var h: CGFloat {
        get { return self.frame.size.height }
        set(newValue) {
            var frame: CGRect  = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    func setViewTheme(theme: ThemeProtocol) {
        
    }
}
extension UIImageView {
    open class func getDLineView() -> UIImageView {
        let imgLine = UIImageView()
        imgLine.backgroundColor = kColorTVCLine1
        return imgLine
    }
}
public protocol UserDefaultSettable {
    var uniqueKey: String { get }
}
public extension UserDefaultSettable where Self: RawRepresentable, Self.RawValue == String {
    public func store(value: Any?){
        UserDefaults.standard.set(value, forKey: uniqueKey)
    }
    public var storedValue: Any? {
        return UserDefaults.standard.value(forKey: uniqueKey)
    }
    // 为所有的key加上枚举名作为命名空间，避免重复
    public var uniqueKey: String {
        return "\(Self.self).\(rawValue)"
    }
}
extension UserDefaults {
    enum ZUserData: String, UserDefaultSettable {
        case name
    }
}
extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
extension UIFont {
    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        return (string as NSString).boundingRect(with: CGSize(width: width, height: Double.greatestFiniteMagnitude),
                                                         options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                         attributes: [NSFontAttributeName: self],
                                                         context: nil).size
    }
}
extension UIAlertAction {
    
    private struct AssociatedKeys {
        static var tagKey = "ZAlertActionTag"
    }
    
    var tag: Int {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tagKey) as! Int
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.tagKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


