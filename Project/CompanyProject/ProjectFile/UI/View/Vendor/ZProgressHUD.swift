//
//  ZProgressHUD.swift
//  CompanyProject
//
//  Created by Daniel on 18/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import QuartzCore
import BXProgressHUD

fileprivate let kNotificationMessageLabelFont = UIFont(name: "HelveticaNeue-Light", size: 17)
fileprivate let kNotificationMessageCancelFont = UIFont(name: "HelveticaNeue-Light", size: 13)
fileprivate let kNotificationMessageTagMJAlertView: NSInteger = 1812
fileprivate let kNotificationMessagePadding: CGFloat = 10
fileprivate let kNotificationMessagePosition: CGFloat = 400
fileprivate let kNotificationMessageLabelHeight: CGFloat = 40
fileprivate let kNotificationMessageCancelButtonHeight: CGFloat = 30
fileprivate let kNotificationMessageSeparatorHeight: CGFloat = 1
fileprivate let kNotificationMessageHeightFromBottom: CGFloat = 20
fileprivate let kNotificationMessageMaxWidth: CGFloat = 290
fileprivate let kNotificationMessageAfterDelay: TimeInterval = 3

class ZProgressHUD: NSObject {

    /// 显示等待进度
    public class func show(_ message: String?) {
        if let view = UIApplication.shared.keyWindow {
            let _ = BXProgressHUD.Builder(forView: view).text(message!).mode(.indeterminate).show()
        }
    }
    /// 隐藏等待进度
    public class func dismiss() {
        if let view = UIApplication.shared.keyWindow {
            let huds = BXProgressHUD.allHUDsForView(view)
            huds.forEach { (hud) in
                hud.hide()
            }
        }
    }
    /// 显示等待进度
    public class func showInView(_ view: UIView, _ message: String?) {
        let _ = BXProgressHUD.Builder(forView: view).text(message!).mode(.indeterminate).show()
    }
    /// 隐藏等待进度
    public class func dismissInView(_ view: UIView) {
        let huds = BXProgressHUD.allHUDsForView(view)
        huds.forEach { (hud) in
            hud.hide()
        }
    }
    
    /// 显示等待进度
    public class func showInView(_ message: String?, _ task: URLSessionTask?, _ cancelBlock: () -> Void) {
        
    }
    /// 显示成功提示信息
    public class func showSuccess(_ message: String?) {
        self.addMJNotifierWithText(message!, true, kColorRGBA(0, 0, 0, 0.6), textColor: kColorWhite)
    }
    /// 显示错误提示信息
    public class func showError(_ message: String?) {
        self.addMJNotifierWithText(message!, true, kColorRGBA(249, 65, 55, 0.6), textColor: kColorWhite)
    }
    /// 添加通知提示消息
    private class func addMJNotifierWithText(_ text: String, _ shouldDismiss: Bool, _ backgroundColor: UIColor, textColor: UIColor) {
        let screenBounds = UIApplication.shared.keyWindow?.bounds
        let width = CGFloat.greatestFiniteMagnitude
        let notifierRect = kNotificationMessageLabelFont?.sizeOfString(string: text, constrainedToWidth: Double(width))
        let notifierWidth = min(notifierRect!.width, CGFloat(kNotificationMessageMaxWidth))
        let xOffset = (screenBounds!.width - notifierWidth) / 2
        var notifierHeight = kNotificationMessageLabelHeight
        if shouldDismiss == false {
            notifierHeight = notifierHeight + kNotificationMessageCancelButtonHeight + kNotificationMessageSeparatorHeight
        }
        let yOffset = screenBounds!.height - notifierHeight - kNotificationMessageHeightFromBottom
        let finalFrame = CGRect(x: xOffset, y: yOffset, width: notifierWidth, height: notifierHeight)
        var notifierView = self.checkIfNotifierExistsAlready()
        if notifierView == nil {
            notifierView = UIView(frame: CGRect(x: xOffset, y: screenBounds!.height, width: notifierWidth, height: notifierHeight))
            notifierView?.backgroundColor = backgroundColor
            notifierView?.tag = kNotificationMessageTagMJAlertView
            notifierView?.clipsToBounds = true
            notifierView?.layer.cornerRadius = 5.0
            UIApplication.shared.keyWindow?.addSubview(notifierView!)
            UIApplication.shared.keyWindow?.bringSubview(toFront: notifierView!)
            
            let textLabel = UILabel(frame: CGRect(x: kNotificationMessagePadding, y: 0, width: notifierWidth - 2*kNotificationMessagePadding, height: kNotificationMessageLabelHeight))
            textLabel.adjustsFontSizeToFitWidth = true
            textLabel.backgroundColor = kColorClear
            textLabel.textAlignment = NSTextAlignment.center
            textLabel.textColor = textColor
            textLabel.minimumScaleFactor = 0.7
            textLabel.text = text
            notifierView?.addSubview(textLabel)
            
            if shouldDismiss == true {
                self.perform(#selector(dismissMJNotifier) , with: nil, afterDelay: kNotificationMessageAfterDelay)
            } else {
                let separatorImageView = UIImageView(frame: CGRect(x: 0.0, y: textLabel.frame.height, width: notifierWidth, height: kNotificationMessageSeparatorHeight))
                separatorImageView.backgroundColor = backgroundColor
                notifierView?.addSubview(separatorImageView)
                
                let btnCancel = UIButton(type: UIButtonType.custom)
                btnCancel.frame = CGRect(x: 0.0, y: separatorImageView.frame.maxY, width: notifierWidth, height: kNotificationMessageCancelButtonHeight)
                btnCancel.backgroundColor = backgroundColor
                btnCancel.setTitle(kLocalCancel, for: UIControlState.normal)
                btnCancel.titleLabel?.font = kNotificationMessageCancelFont
                btnCancel.addTarget(self, action: #selector(dismissMJNotifier), for: UIControlEvents.touchUpInside)
                notifierView?.addSubview(btnCancel)
            }
            self.startEntryAnimation(notifierView!, finalFrame)
        } else {
            notifierView?.backgroundColor = backgroundColor
            self.updateNotifierWithAnimation(notifierView!, text: text, { (finished) in
                var atLastFrame = finalFrame
                atLastFrame.origin.y = finalFrame.origin.y + 8
                notifierView!.frame = atLastFrame
                var textLabel: UILabel?
                for subview in notifierView!.subviews {
                    if subview.isKind(of: UILabel.classForCoder()) {
                        textLabel = subview as? UILabel
                    }
                    if subview.isKind(of: UIImageView.classForCoder()) || subview.isKind(of: UIButton.classForCoder()) {
                        subview.removeFromSuperview()
                    }
                }
                textLabel?.text = text
                textLabel?.frame = CGRect(x: kNotificationMessagePadding, y: 0.0, width: notifierWidth - 2 * kNotificationMessagePadding, height: kNotificationMessageLabelHeight)
                if shouldDismiss == false {
                    let separatorImageView = UIImageView(frame: CGRect(x: 0.0, y: textLabel!.frame.height, width: notifierView!.frame.width, height: kNotificationMessageSeparatorHeight))
                    separatorImageView.backgroundColor = backgroundColor
                    notifierView?.addSubview(separatorImageView)
                    
                    let btnCancel = UIButton(type: UIButtonType.custom)
                    btnCancel.frame = CGRect(x: 0.0, y: separatorImageView.frame.maxY, width: notifierView!.frame.width, height: kNotificationMessageCancelButtonHeight)
                    btnCancel.backgroundColor = backgroundColor
                    btnCancel.setTitle(kLocalCancel, for: UIControlState.normal)
                    btnCancel.titleLabel?.font = kNotificationMessageCancelFont
                    btnCancel.addTarget(self, action: #selector(dismissMJNotifier), for: UIControlEvents.touchUpInside)
                    notifierView?.addSubview(btnCancel)
                }
                UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    notifierView!.alpha = 1
                    notifierView!.frame = finalFrame
                }, completion: { (finished) in
                })
            })
            if shouldDismiss == true {
                self.perform(#selector(dismissMJNotifier) , with: nil, afterDelay: kNotificationMessageAfterDelay)
            }
        }
    }
    private class func checkIfNotifierExistsAlready() -> UIView? {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(dismissMJNotifier), object: nil)
        weak var notifier: UIView? = nil
        let subviews = UIApplication.shared.keyWindow?.subviews
        if subviews != nil {
            subviews!.forEach({ (view) in
                if view.tag == kNotificationMessageTagMJAlertView && view.isKind(of: UIView.classForCoder()) {
                    notifier = view
                }
            })
        }
        return notifier
    }
    @objc private class func dismissMJNotifier() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(dismissMJNotifier), object: self)
        weak var notifier: UIView? = nil
        let subviews = UIApplication.shared.keyWindow?.subviews
        if subviews != nil {
            subviews!.forEach({ (view) in
                if view.tag == kNotificationMessageTagMJAlertView && view.isKind(of: UIView.classForCoder()) {
                    notifier = view
                }
            })
        }
        if notifier != nil {
            self.startExitAnimation(notifier!)
        }
    }
    
    // MARK: - Animation Part
    
    private class func updateNotifierWithAnimation(_ notifierView: UIView, text: String, _ completion: @escaping (_: (_ finished: Bool) -> Void)) {
        var finalFrame = notifierView.frame
        finalFrame.origin.y = finalFrame.origin.y + 8
        
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            notifierView.alpha = 0
            notifierView.frame = finalFrame
        }) { (finished) in
            completion(finished)
        }
    }
    private class func startEntryAnimation(_ notifierView: UIView, _ finalFrame: CGRect) {
        let finalYOffset = finalFrame.origin.y
        var newFinalFrame = finalFrame
        newFinalFrame.origin.y = finalFrame.origin.y - 15
        let transform = self.transformWithXAxisValue(-0.1, 45)
        notifierView.layer.zPosition = kNotificationMessagePosition
        notifierView.layer.transform = transform
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            notifierView.frame = finalFrame
            
            let transform = self.transformWithXAxisValue(0.1, 15)
            notifierView.layer.zPosition = kNotificationMessagePosition
            notifierView.layer.transform = transform
        }) { (finished) in
            UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                var atLastFrame = finalFrame
                atLastFrame.origin.y = finalYOffset
                notifierView.frame = atLastFrame
                
                let transform = self.transformWithXAxisValue(0, 90)
                notifierView.layer.zPosition = kNotificationMessagePosition
                notifierView.layer.transform = transform
            }, completion: { (finished) in
                
            })
        }
    }
    private class func startExitAnimation(_ notifierView: UIView) {
        let screenBounds = UIApplication.shared.keyWindow!.bounds
        var notifierFrame = notifierView.frame
        let finalYOffset = notifierFrame.origin.y - 12
        notifierFrame.origin.y = finalYOffset
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            notifierView.frame = notifierFrame
            
            let transform = self.transformWithXAxisValue(0.1, 30)
            notifierView.layer.zPosition = kNotificationMessagePosition
            notifierView.layer.transform = transform
        }) { (finished) in
            UIView.animate(withDuration: 0.15, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                var atLastFrame = notifierView.frame
                atLastFrame.origin.y = screenBounds.height
                notifierView.frame = atLastFrame
                
                let transform = self.transformWithXAxisValue(-1, 90)
                notifierView.layer.zPosition = kNotificationMessagePosition
                notifierView.layer.transform = transform
            }, completion: { (finished) in
                notifierView.removeFromSuperview()
            })
        }
    }
    private class func transformWithXAxisValue(_ xValue: CGFloat, _ valueOfAngle: CGFloat) -> CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000
        transform = CATransform3DRotate(transform, valueOfAngle * CGFloat(Double.pi) / 180.0, xValue, 0, 0)
        return transform
    }
}
