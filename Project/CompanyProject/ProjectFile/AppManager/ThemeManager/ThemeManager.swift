//
//  ThemeManager.swift
//  CompanyProject
//
//  Created by Daniel on 17/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class ThemeManager: NSObject {
    
    //MARK: - Private Attribute
    
    // 默认ThemeWhite
    private var theme: ThemeProtocol = ThemeWhite()
    // 单例模式
    private static var manager: ThemeManager? = nil
    
    //MARK: - Public Method
    
    /// 单例模式
    open static func shareInstance() -> ThemeManager {
        if manager == nil {
            manager = ThemeManager()
        }
        return manager!
    }
    /// 切换主题枚举
    open static func switcherTheme(_ type: ThemeType) {
        ThemeManager.shareInstance().switcherTheme(type)
    }
    
    //MARK: - Private Method
    
    private override init() {
        
    }
    private func switcherTheme(_ type: ThemeType) {
        self.theme = type.theme
        self.themeUpdate()
    }
    private func themeUpdate() {
        NotificationCenter.default.post(name: keyNotificationNameTheme, object: self.theme)
    }
}
