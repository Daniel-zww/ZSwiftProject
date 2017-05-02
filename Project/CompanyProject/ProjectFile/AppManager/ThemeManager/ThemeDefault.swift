//
//  ThemeDefault.swift
//  CompanyProject
//
//  Created by Daniel on 20/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class ThemeDefault: ThemeProtocol {
    var viewBackgroudColor: UIColor {
        get {
            return UIColor.white
        }
    }
    var viewLineColor: UIColor {
        get {
            return UIColor(222, 222, 222)
        }
    }
    var viewTitleTextColor: UIColor {
        get {
            return UIColor(20, 20, 20)
        }
    }
    var viewContentTextColor: UIColor {
        get {
            return UIColor(120, 120, 120)
        }
    }
    var viewDescribeTextColor: UIColor {
        get {
            return UIColor(170, 170, 170)
        }
    }
    
    var navLineColor: UIColor {
        get {
            return UIColor(222, 222, 222)
        }
    }
    var navBackgroudColor: UIColor {
        get {
            return UIColor.white
        }
    }
    var navForegroundColor: UIColor {
        get {
            return UIColor(80, 80, 80)
        }
    }
    
    var tabLineColor: UIColor {
        get {
            return UIColor(222, 222, 222)
        }
    }
    var tabBackgroudColor: UIColor {
        get {
            return UIColor.white
        }
    }
    var tabForegroundColor: UIColor {
        get {
            return UIColor(80, 80, 80)
        }
    }
}
