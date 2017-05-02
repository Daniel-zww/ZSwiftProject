//
//  ThemeProtocol.swift
//  CompanyProject
//
//  Created by Daniel on 17/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

/// 皮肤协议
protocol ThemeProtocol {
    var viewBackgroudColor: UIColor {get}
    var viewLineColor: UIColor {get}
    var viewTitleTextColor: UIColor {get}
    var viewContentTextColor: UIColor {get}
    var viewDescribeTextColor: UIColor {get}
    
    var navLineColor: UIColor {get}
    var navBackgroudColor: UIColor {get}
    var navForegroundColor: UIColor {get}
    
    var tabLineColor: UIColor {get}
    var tabBackgroudColor: UIColor {get}
    var tabForegroundColor: UIColor {get}
}






