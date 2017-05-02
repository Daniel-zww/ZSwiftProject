//
//  ZFont.swift
//  CompanyProject
//
//  Created by Daniel on 24/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class ZFont: UIFont {
    
    // MARK: - SuperMethod
    
    
    // MARK: - PrivateMethod
    
    private func innerInit() {
        
    }
    
    // MARK: - PublicMethod
    
    public class func fontWithSize(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    public class func boldFontWithSize(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
}
