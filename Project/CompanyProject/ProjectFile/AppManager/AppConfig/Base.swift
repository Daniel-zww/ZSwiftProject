//
//  Base.swift
//  CompanyProject
//
//  Created by Daniel on 17/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

// MARK: - Public

///DEBUG
public func ZLog(_ format: String?) {
    #if DEBUG
        if format != nil {
            debugPrint(String("[\(format!)]")!)
        }
    #else
        
    #endif
}
public func ZLog(_ format: Any?) {
    #if DEBUG
        if format != nil {
            debugPrint("[\(format!)]")
        }
    #else
        
    #endif
}
//随机生成图片地址
public let kRandomImageName: String = (String("\(Date(timeIntervalSinceReferenceDate: 0))\(arc4random())\(arc4random()).jpeg")?.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "jpeg", with: ".jpeg"))!

///View宽度-不包括状态栏
public let kAppFrameWidth: CGFloat = UIScreen.main.bounds.size.width
///View高度-不包括状态栏
public let kAppFrameHeight: CGFloat = UIScreen.main.bounds.size.height

///VIEW视图铺满屏幕[包括导航栏高度]
public let kViewMainFrame: CGRect = CGRect(x: 0, y: 0, width: kAppFrameWidth, height: kAppFrameHeight)
///VIEW视图铺满屏幕[不包括导航栏高度&不包括TABBAR]
public let kViewTabFrame: CGRect = CGRect(x: 0, y: kAppTopHeight, width: kAppFrameWidth, height: kAppFrameHeight-kAppTabbarHeight-kAppTopHeight)
///VIEW视图铺满屏幕[不包括导航栏高度]
public let kViewItemFrame: CGRect = CGRect(x: 0, y: kAppTopHeight, width: kAppFrameWidth, height: kAppFrameHeight-kAppTopHeight)
///VIEW视图导航屏幕[包括导航栏高度]
public let kViewNavFrame: CGRect = CGRect(x: 0, y: 0, width: kAppFrameWidth, height: kAppTopHeight)

///获取App版本
public var kAppVersion: String {
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
    if let appVersion = version {
        switch appVersion {
        case is NSNumber: return (appVersion as! NSNumber).toFloatString
        case is String: return appVersion as! String
        default: break
        }
    }
    return "1.0.0"
}
///获取App名称
public let kAppName: String = Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
///手机操作系统版本
public let kAppSystemVersion: Float = UIDevice.current.systemVersion.floatValue

///项目APPID
public let kAppId: String = "1107825213"
///项目App地址
public let kAppUrl: String = "itms-apps://itunes.apple.com/app/id\(kAppId)"
///项目App地址
public let kAppVersionUrl: String = "https://itunes.apple.com/cn/lookup?id=\(kAppId)"

//是否IPad
public let kIsIPadDevice: Bool = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
//是否IPhone
public let kIsIPhoneDevice: Bool = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)

