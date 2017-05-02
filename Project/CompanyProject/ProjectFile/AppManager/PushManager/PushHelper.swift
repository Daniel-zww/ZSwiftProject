//
//  PushHelper.swift
//  CompanyProject
//
//  Created by Daniel on 01/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class PushHelper: NSObject {

    // MARK: - PublicMethod
    
    public static func setPushContentWithUserInfo(userInfo: [AnyHashable : Any]?) {
        guard let userInfo = userInfo else {
            return
        }
        ZLog(userInfo)
    }
    public static func setPushViewControllerWithUrl(url: URL?) {
        guard let url = url else {
            return
        }
        ZLog(url)
    }
}
