//
//  KeyManager.swift
//  CompanyProject
//
//  Created by Daniel on 17/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

/// 默认游客UserId
public let keyUserDefaultId: String = "1"

/// AppScheme
public let kekMyAppScheme: String = "cp111111111"
/// AppScheme Host
public let kekMyAppSchemeHost: String = "cpCompamyProject"
/// AppScheme Desc
public let kekMyAppSchemeDesc: String = "CDCompamyProject"

/// 腾讯扣扣登录,分享,收藏
public let keyTencentQQAppId: String = ""
public let keyTencentQQAppKey: String = ""
public let keyTencentQQAuthURLHostKey: String = "response_from_qq"

/// 腾讯BUG平台
public let keyTencentBuglyAppId: String = ""
public let keyTencentBuglyGroupId: String = ""

/// Share分享平台
public let keyShare_AppKey: String = ""
public let keyShare_AppSecret: String = ""

/// UMeng平台AppKey
public let keyUMengAppKey: String = ""
/// UMeng类型
public let keyUMengTypeKey: String = "kUMessageAliasTypeCompanyProject"

/// 微信登录,分享,收藏,支付
public let keyWeChatAppId: String = ""
public let keyWeChatAppSecret: String = ""
public let keyWeChatDescription: String = kekMyAppSchemeDesc
/// 商户号，填写商户对应参数
public let keyWechatMCHID: String = ""
/// 商户API密钥，填写相应参数
public let keyWechatPARTNERID: String = ""
/// 支付结果回调页面
public let keyWechatNOTIFYURL: String = "https://www.wutongsx.com"
/// 微信回调
public let keyWechatAuthURLHostKey: String = "platformId=wechat"
/// 统一下单的接口链接
public let keyWechatPARURL: String = "https://api.mch.weixin.qq.com/pay/unifiedorder"
/**
 接口1地址: /sns/oauth2/access_token
 接口1说明: 通过code换取access_token、refresh_token和已授权scope
 
 接口2地址: /sns/oauth2/refresh_token
 接口2说明: 刷新或续期access_token使用
 
 接口3地址: /sns/auth
 接口3说明: 检查access_token有效性
 */
public let keyWeChatScopeBase: String = "snsapi_base"
/*
 接口地址: /sns/userinfo
 接口说明: 用户登录
 */
public let keyWeChatScopeUserInfo: String = "snsapi_userinfo"

/// 支付宝支付
public let keyALIPID: String = ""
public let keyALISeller: String = ""
public let keyALIKey: String = ""
public let keyALIAlgorithm: String = "RSA"
public let keyALIPrivateKey: String = ""
public let keyALIAuthURLHostKey: String = "safepay"
//应用注册scheme,在SosoBand-Info.plist定义URL types
public let keyALIAppScheme: String = kekMyAppScheme
//支付结果回调页面
public let keyALINotifyURL: String = "https://www.wutongsx.com"




/// 设备Token
public let keySQLiteDeviceToken: String = "keyDeviceToken"




/// 主题改变
public let keyNotificationNameTheme: NSNotification.Name = NSNotification.Name(rawValue: "keyNotificationNameTheme")
/// 键盘状态改变
public let keyNotificationNameKeyboard: NSNotification.Name = NSNotification.Name(rawValue: "keyNotificationNameKeyboard")
/// 登录状态改变
public let keyNotificationNameLoginChange: NSNotification.Name = NSNotification.Name(rawValue: "keyNotificationNameLoginChange")
/// 用户信息改变
public let keyNotificationNameUserInfoChange: NSNotification.Name = NSNotification.Name(rawValue: "keyNotificationNameUserInfoChange")
/// 审核状态改变
public let keyNotificationAppAuditStatusChange: NSNotification.Name = NSNotification.Name(rawValue: "keyNotificationAppAuditStatusChange")
/// App数量改变
public let keyNotificationAppNumberChange: NSNotification.Name = NSNotification.Name(rawValue: "keyNotificationAppNumberChange")

