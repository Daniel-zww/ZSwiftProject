//
//  UserSetting.swift
//  CompanyProject
//
//  Created by Daniel on 29/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

/// 所有用户信息缓存对象
fileprivate var dicAllUserSettings: Dictionary<String, Any>?
/// 登录用户信息缓存对象
fileprivate var dicCurrUserSettings: Dictionary<String, Any>?
/// 登录用户ID
fileprivate var strCurrUserId: String = kUserDefaultId
/// 用户默认ID
fileprivate let kUserDefaultId = "1"

/// 用户管理类
class UserSetting: NSObject {

    /// 登录
    open class func login(_ value: ModelUser) {
        if dicCurrUserSettings == nil {
            dicCurrUserSettings = Dictionary<String, Any>()
        }
        if dicAllUserSettings == nil {
            dicAllUserSettings = Dictionary<String, Any>()
        }
        // 设置登录信息
        self.setAutoLogin(true)
        strCurrUserId = String(stringInterpolationSegment: value.userId)
        self.setUserId(strCurrUserId)
        self.setUserModel(value)
        //最后一次登录时间
        dicCurrUserSettings?["LastDate"] = Date(timeIntervalSinceNow: 0).toString
        //保存用户信息
        dicAllUserSettings?[strCurrUserId] = dicCurrUserSettings
        //设置历史登录信息
        self.setHisLogin(strCurrUserId)
        //保存
        self.save()
        
        ZLog("login user: \(String(describing: dicCurrUserSettings))")
    }
    /// 注销
    open class func del() {
        //关闭自动登录
        self.setAutoLogin(false)
        dicAllUserSettings?[strCurrUserId] = dicCurrUserSettings
        //设置历史登录信息
        self.setHisLogin(kUserDefaultId)
        //保存
        self.save()
        //重新加载
        self.reload()
    }
    /// 加载
    open class func reload() {
        dicCurrUserSettings = nil
        dicAllUserSettings = nil
        //获取数据
        dicAllUserSettings = KeyChain.loadLogin()
        if dicAllUserSettings == nil {
            dicAllUserSettings = Dictionary<String, Any>()
            dicCurrUserSettings = Dictionary<String, Any>()
            return
        }
        //历史登录信息
        let hisLogin = self.getHisLogin()
        if hisLogin.first != nil {
            dicCurrUserSettings = dicAllUserSettings?[hisLogin.first!] as? Dictionary<String, Any>
        } else {
            dicCurrUserSettings = dicAllUserSettings?[kUserDefaultId] as? Dictionary<String, Any>
        }
        if dicCurrUserSettings == nil {
            dicCurrUserSettings = Dictionary<String, Any>()
        }
        //更新登录时间
        dicCurrUserSettings?["LastDate"] = Date(timeIntervalSinceNow: 0).toString
        //设置当前登录用户ID
        let userId = dicCurrUserSettings?["UserId"] as? String
        strCurrUserId = userId == nil ? kUserDefaultId : userId!
        
        ZLog("reload user: \(String(describing: dicCurrUserSettings))")
    }
    /// 保存登录信息
    private class func save() {
        if dicAllUserSettings != nil {
            //更新当前登录用户设置
            dicAllUserSettings?[strCurrUserId] = dicCurrUserSettings
            KeyChain.saveLogin(dicAllUserSettings!)
        }
    }
    /// 设置历史登录用户
    private class func setHisLogin(_ userId: String) {
        var hisLogin = self.getHisLogin()
        if hisLogin.first != nil && hisLogin.first! != userId {
            let index = hisLogin.index(of: userId)
            if index != nil {
                hisLogin.remove(at: index!)
            }
        }
        hisLogin.insert(kUserDefaultId, at: 0)
        dicAllUserSettings?["HisLogin"] = hisLogin
    }
    /// 获取历史登录用户
    private class func getHisLogin() -> Array<String> {
        var userIds = dicAllUserSettings?["HisLogin"] as? Array<String>
        if userIds == nil {
            userIds = Array<String>()
        }
        return userIds!
    }
    /// 设置是否自动登录
    open class func getAutoLogin() -> Bool {
        return dicCurrUserSettings?["AutoLogin"] as! Bool
    }
    /// 获取是否自动登录
    private class func setAutoLogin(_ value: Bool) {
        dicCurrUserSettings?["AutoLogin"] = value
    }
    /// 获取用户ID
    open class func getUserId() -> String {
        let userId = dicCurrUserSettings?["UserId"] as? String
        strCurrUserId = userId == nil ? kUserDefaultId : userId!
        return strCurrUserId
    }
    /// 设置用户ID
    private class func setUserId(_ value: String?) {
        dicCurrUserSettings?["UserId"] = value == nil ? kUserDefaultId : value
    }
    /// 获取登录用户
    open class func getUserModel() -> ModelUser {
        let dicUser = dicCurrUserSettings?["UserInfo"] as? [String : Any]
        if dicUser == nil {
            return ModelUser.create() as! ModelUser
        }
        let model = ModelUser.create(properties: dicUser!) as! ModelUser
        return model
    }
    /// 设置登录用户
    private class func setUserModel(_ value: ModelUser) {
        let keys = value.entity.attributesByName.keys.sorted()
        dicCurrUserSettings?["UserInfo"] = value.dictionaryWithValues(forKeys: keys)
    }
    /// 获取字体大小
    open class func getFontSize() -> Int {
        return dicCurrUserSettings?["FontSize"] as! Int
    }
    /// 设置字体大小
    open class func setFontSize(_ value: Int) {
        dicCurrUserSettings?["FontSize"] = value
    }
    /// 获取主题
    open class func getTheme() -> ThemeType {
        if let theme = dicCurrUserSettings?["Theme"] {
            return theme as! ThemeType
        }
        return ThemeType.themeDefault
    }
    /// 设置主题
    open class func setTheme(_ value: ThemeType) {
        dicCurrUserSettings?["Theme"] = value
    }
}

/// 登录用户ID
public let kLoginUserId: String = UserSetting.getUserId()



