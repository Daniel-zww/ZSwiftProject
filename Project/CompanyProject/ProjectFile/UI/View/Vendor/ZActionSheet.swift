//
//  ZActionSheet.swift
//  CompanyProject
//
//  Created by Daniel on 19/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class ZActionSheet: NSObject {

    /// 弹出提示框-自定义按钮
    public class func showAction(_ title: String?, _ message: String?, _ buttons: [String], _ completion: @escaping (_: (_ btnIndex: Int) -> Void)) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        let actionCancel = UIAlertAction(title: kLocalCancel, style: UIAlertActionStyle.cancel) { (action) in
        }
        actionCancel.tag = 0
        alertVC.addAction(actionCancel)
        for index in 1...buttons.count {
            let action = UIAlertAction(title: buttons[index-1], style: UIAlertActionStyle.default, handler: { (action) in
                completion(action.tag)
            })
            action.tag = index
            alertVC.addAction(action)
        }
        UIApplication.shared.keyWindow?.rootViewController?.present(alertVC, animated: true, completion: {
        })
    }
}
