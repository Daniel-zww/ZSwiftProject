//
//  ColorManager.swift
//  CompanyProject
//
//  Created by Daniel on 21/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

// MARK: - Public

///颜色
public func kColorRGB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
}
///颜色
public func kColorRGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
}
///透明色
public let kColorClear = UIColor.clear

///视图背景颜色->白色
public let kColorViewBack1: UIColor =  kColorRGB(255, 255, 255)
///视图背景颜色->灰色
public let kColorViewBack2: UIColor =  kColorRGB(238, 238, 238)

///表格CELL背景色
public let kColorTVCBackground: UIColor = UIColor.clear
//表格分割线颜色->1PX细线
public let kColorTVCLine1: UIColor =  kColorRGB(226, 226, 226)
//表格分割线颜色->1+PX粗线
public let kColorTVCLine2: UIColor =  kColorRGB(248, 248, 248)

///主色调
public let kColorMain: UIColor = kColorRGB(251, 107, 33)
///导航栏背景色
public let kColorNavBackground: UIColor = kColorRGB(255, 255, 255)
///导航栏文字颜色
public let kColorNavTitle: UIColor = kColorRGB(15, 15, 15)
///导航栏按钮颜色
public let kColorNavButton: UIColor = kColorMain
///Tabbar选中颜色
public let kColorTabbarSelectItem: UIColor = kColorMain
///Tabbar未颜色
public let kColorTabbarUnSelectItem: UIColor = kColorRGB(196, 196, 196)

///黑色
public let kColorBlack: UIColor = kColorRGB(47, 47, 47)
///蓝色
public let kColorBlue = kColorRGB(46, 167, 233)
///白色
public let kColorWhite: UIColor = kColorRGB(255, 255, 255)
///灰色
public let kColorGray: UIColor = kColorRGB(170, 170, 170)
///红色
public let kColorRed: UIColor = kColorRGB(252, 23, 33)


