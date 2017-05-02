//
//  ThemeType.swift
//  CompanyProject
//
//  Created by Daniel on 17/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

/// 主题类型枚举
enum ThemeType {
    case themeDefault
    case themeWhite
    case themeBlack
    
    var theme: ThemeProtocol {
        get {
            switch self {
            case .themeDefault: return ThemeDefault()
            case .themeWhite: return ThemeWhite()
            case .themeBlack: return ThemeBlack()
            }
        }
    }
}
