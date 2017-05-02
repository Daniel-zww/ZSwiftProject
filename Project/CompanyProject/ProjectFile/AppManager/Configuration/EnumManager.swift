//
//  EnumManager.swift
//  CompanyProject
//
//  Created by Daniel on 17/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

///服务器地址枚举
enum ZServerType: Int {
    ///默认值
    case None = 0
    ///参数需要加密
    case Encrypt = 1
}
///性别枚举
enum ZSexType: Int {
    ///默认
    case None = 0
    ///男
    case Male = 1
    ///女
    case FeMale = 2
}
///支付通知回调
enum ZOpenURLType: Int {
    ///默认OpenURL
    case None = 0
    ///腾讯OpenURL
    case Tencent = 1
    ///微信OpenURL
    case WeChat = 2
    ///支付宝OpenURL
    case Ali = 3
}
///支付平台
enum ZPayWayType: Int {
    ///余额
    case BalancePay = 0
    ///苹果
    case ApplePay = 1
    ///微信
    case WeChatPay = 2
    ///支付宝
    case AliPay = 3
    ///银联
    case UnionPay = 4
}
///Thouch3DType
enum ZShortcutItemType: String {
    ///默认
    case None
    ///打开
    case Open
}
///背景状态
enum ZBackgroundState: Int {
    ///默认
    case None = 0
    ///加载中
    case Loading = 1
    ///未登录
    case NoLogin = 2
    ///无数据
    case NoData = 3
    ///错误
    case Fail = 4
}
