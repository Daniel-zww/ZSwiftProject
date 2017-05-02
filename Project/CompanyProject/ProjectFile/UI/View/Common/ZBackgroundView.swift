//
//  ZBackgroundView.swift
//  CompanyProject
//
//  Created by Daniel on 25/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import BFKit

class ZBackgroundView: ZView {

    private var imgW: CGFloat = 0
    private var imgH: CGFloat = 0
    private var aiView: UIActivityIndicatorView?
    private var imgLogo: UIImageView?
    private var lbDesc: UILabel?
    private var viewState: ZBackgroundState = .None
    
    open var onButtonClickBlock: ((_ state: ZBackgroundState) -> Void)?
    
    override init() {
        super.init(frame: CGRect.zero)
        self.innerInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.innerInit()
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        self.setViewNil()
        onButtonClickBlock = nil
    }
    private func setViewNil() {
        aiView?.stopAnimating()
        aiView?.removeFromSuperview()
        imgLogo?.removeFromSuperview()
        lbDesc?.removeFromSuperview()
        aiView = nil
        imgLogo = nil
        lbDesc = nil
    }
    /// 初始化
    private func innerInit() {
        self.backgroundColor = kColorClear
        self.isUserInteractionEnabled = false
    }
    /// 初始化加载对象
    private func initActivityIndicatorView() {
        if self.aiView != nil {
            self.aiView?.stopAnimating()
            self.aiView?.removeFromSuperview()
        }
        self.aiView = UIActivityIndicatorView()
        self.aiView?.color = kColorMain
        self.aiView?.isUserInteractionEnabled = false
        self.addSubview(self.aiView!)
    }
    /// 初始化图片
    private func initImageView() {
        self.imgLogo = UIImageView()
        self.imgLogo?.isUserInteractionEnabled = true
        self.addSubview(self.imgLogo!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(btnOperClick(sender:)))
        self.imgLogo?.addGestureRecognizer(tap)
    }
    /// 初始化描述
    private func initLabel() {
        self.lbDesc = UILabel()
        self.lbDesc?.font = ZFont.fontWithSize(size: kFontSizeSmall)
        self.lbDesc?.lineBreakMode = .byTruncatingTail
        self.lbDesc?.numberOfLines = 1
        self.lbDesc?.textColor = kColorGray
        self.addSubview(self.lbDesc!)
    }
    /// 背景图片点击事件
    @objc private func btnOperClick(sender: UIGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.ended {
            if self.onButtonClickBlock != nil {
                self.onButtonClickBlock?(self.viewState)
            }
        }
    }
    /// 改变背景状态
    open func setViewStateWithState(state: ZBackgroundState) {
        self.viewState = state
        self.setViewNil()
        self.isUserInteractionEnabled = true
        self.imgW = 480 / 2.0
        self.imgH = 402 / 2.0
        switch state {
        case .None:
            self.isUserInteractionEnabled = false
            break
        case .NoLogin:
            self.initImageView()
            self.imgLogo?.image = UIImage(named: "icon_nologin_bg")
            break
        case .NoData:
            self.initImageView()
            self.imgLogo?.image = UIImage(named: "icon_nodata_bg")
            
            break
        case .Fail:
            self.initImageView()
            self.imgLogo?.image = UIImage(named: "icon_fail_bg")
            break
        case .Loading:
            self.isUserInteractionEnabled = false
            self.initActivityIndicatorView()
            self.aiView?.startAnimating()
            break
        }
        self.setViewFrame()
    }
    /// 设置坐标
    private func setViewFrame() {
        if self.imgLogo != nil {
            let imgX = self.w / 2 - self.imgW / 2
            let imgY = self.h / 2 - self.imgH / 2
            self.imgLogo?.frame = CGRect(x: imgX, y: imgY, width: self.imgW, height: self.imgH)
        }
        if self.aiView != nil {
            let aiS: CGFloat = 30
            let aiX = self.w / 2 - aiS / 2
            let aiY = self.h / 2 - aiS / 2
            self.aiView?.frame = CGRect(x: aiX , y: aiY, width: aiS, height: aiS)
        }
    }

}
