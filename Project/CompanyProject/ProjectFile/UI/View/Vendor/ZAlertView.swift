//
//  ZAlertView.swift
//  CompanyProject
//
//  Created by Daniel on 18/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class ZAlertView: NSObject {
    
    /// 弹出提示框-一个按钮
    public class func showAlertOne(_ message: String) {
        self.showAlert(kLocalPrompt, message, nil, kLocalDetermine) { (btnIndex) in }
    }
    /// 弹出提示框-一个按钮
    public class func showAlertOne(_ message: String, _ completion: @escaping (_: () -> Void)) {
        self.showAlert(kLocalPrompt, message, nil, kLocalDetermine) { (btnIndex) in
            completion()
        }
    }
    /// 弹出提示框-一个按钮
    public class func showAlertOne(_ title: String, _ message: String, _ completion: @escaping (_: () -> Void)) {
        self.showAlert(title, message, nil, kLocalDetermine) { (btnIndex) in
            completion()
        }
    }
    /// 弹出提示框-两个按钮
    public class func showAlertTwo(_ message: String, _ completion: @escaping (_: (_ btnIndex: Int) -> Void)) {
        self.showAlert(kLocalPrompt, message, [kLocalDetermine], kLocalCancel) { (btnIndex) in
            completion(btnIndex)
        }
    }
    /// 弹出提示框-两个按钮
    public class func showAlertTwo(_ title: String, _ message: String, _ completion: @escaping (_: (_ btnIndex: Int) -> Void)) {
        self.showAlert(title, message, [kLocalDetermine], kLocalCancel) { (btnIndex) in
            completion(btnIndex)
        }
    }
    /// 弹出提示框-自定义按钮
    public class func showAlert(_ message: String, _ buttons: [String]?, _ cancel: String, _ completion: @escaping (_: (_ btnIndex: Int) -> Void)) {
        self.showAlert(kLocalPrompt, message, buttons, cancel) { (btnIndex) in
            completion(btnIndex)
        }
    }
    /// 弹出提示框-自定义按钮
    public class func showAlert(_ title: String, _ message: String, _ buttons: [String]?, _ cancel: String, _ completion: @escaping (_: (_ btnIndex: Int) -> Void)) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let actionCancel = UIAlertAction(title: cancel, style: UIAlertActionStyle.cancel) { (action) in
            completion(action.tag)
        }
        actionCancel.tag = 0
        alertVC.addAction(actionCancel)
        if buttons != nil && buttons!.count > 0 {
            for index in 1...buttons!.count {
                let action = UIAlertAction(title: buttons![index-1], style: UIAlertActionStyle.default, handler: { (action) in
                    completion(action.tag)
                })
                action.tag = index
                alertVC.addAction(action)
            }
        }
        UIApplication.shared.keyWindow?.rootViewController?.present(alertVC, animated: true, completion: {
        })
    }
}
