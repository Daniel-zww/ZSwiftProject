//
//  ZBaseViewController.swift
//  CompanyProject
//
//  Created by Daniel on 21/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import BFKit

class ZBaseViewController: UIViewController {
    
    // MARK: - PrivateProperty
    
    
    private var viewNavBack: ZView?
    private var imageNavLine: UIImageView?
    private var viewNavBackAlpha: CGFloat = 1.0
    
    // MARK: - PublicProperty
    
    public let cellId: String = "cellId"
    ///记录ViewController是否消失 YES消失,NO未消失
    public var isDisappear: Bool = false
    
    // MARK: - SuperProperty
    
    override var shouldAutorotate: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait;
    }
    
    // MARK: - SuperMethod

    override func viewDidLoad() {
        super.viewDidLoad()
        self.privateInit()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isDisappear = false
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.isDisappear = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.y = 0
        self.view.h = kAppFrameHeight
    }
    
    // MARK: - PrivateMethod
    
    private func privateInit() {
        //self.definesPresentationContext = true
        self.edgesForExtendedLayout = UIRectEdge.all
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.view.backgroundColor = kColorViewBack1
        
        self.navigationItem.leftBarButtonItem = nil
        
        self.publicInit()
    }
    private func publicInit() {
        if self.navigationController != nil {
            if self.navigationController!.viewControllers.count > 2 {
                self.setBackButtonWithTitle(nil)
            } else if self.navigationController!.viewControllers.count == 2 {
                self.setBackButtonWithTitle(self.navigationController?.viewControllers.first?.title)
            }
        }
        self.viewNavBack = ZView(frame: kViewNavFrame)
        self.viewNavBack?.tag = 99999
        self.viewNavBack?.backgroundColor = kColorNavBackground
        self.view.addSubview(self.viewNavBack!)
        self.view.bringSubview(toFront: self.viewNavBack!)
        
        self.imageNavLine = ZImageView.getDLineView()
        self.imageNavLine?.frame = CGRect(x: 0, y: self.viewNavBack!.h-kLineHeight, width: self.viewNavBack!.w, height: kLineHeight)
        self.viewNavBack?.addSubview(self.imageNavLine!)
    }
    deinit {
        self.setViewNil()
    }
    private func setViewNil() {
        self.imageNavLine = nil
        self.viewNavBack = nil
    }
    
    // MARK: - PrivateButton
    
    private func setBackButtonWithTitle(_ title: String?) -> () {
        self.navigationItem.leftBarButtonItem = nil
        var newTitle: String? = title
        if newTitle == nil {
            newTitle = kLocalReturn
        }
        let btnBack = self.getBackButton(title: newTitle)
        btnBack.addTarget(self, action: #selector(btnBackClick), for: UIControlEvents.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnBack)
    }
    @objc private func btnBackClick() -> () {
        self.navigationController?.popViewController(animated: true)
    }
    private func getBackButton(title: String?) -> UIButton {
        let btnBack = UIButton(type: UIButtonType.custom)
        btnBack.frame = CGRect(x: 0, y: 0, width: 50, height: 44)
        btnBack.setTitle(title, for: UIControlState.normal)
        btnBack.setTitle(title, for: UIControlState.highlighted)
        btnBack.setTitleColor(kColorNavButton, for: UIControlState.normal)
        btnBack.setTitleColor(kColorNavButton, for: UIControlState.highlighted)
        btnBack.setImage(UIImage(named: "btn_back"), for: UIControlState.normal)
        btnBack.setImage(UIImage(named: "btn_back"), for: UIControlState.highlighted)
        btnBack.contentHorizontalAlignment = .left
        btnBack.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        btnBack.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        btnBack.titleLabel?.font = ZFont.fontWithSize(size: kFontSizeMax)
        return btnBack
    }
    
    // MARK: - PublicButton
    
    public func setBackButton() -> () {
        self.navigationItem.leftBarButtonItem = nil
        let btnBack = self.getBackButton(title: kLocalReturn)
        btnBack.addTarget(self, action: #selector(btnLeftClick), for: UIControlEvents.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnBack)
    }
    public func setCloseButton() -> () {
        self.navigationItem.leftBarButtonItem = nil
        let btnClose = UIBarButtonItem(title: kLocalClose, style: UIBarButtonItemStyle.done, target: self, action: #selector(btnLeftClick))
        btnClose.tintColor = kColorMain
        self.navigationItem.leftBarButtonItem = btnClose
    }
    @objc open func btnLeftClick() -> () {
        
    }
    
    // MARK: - PublicMethod
    
    ///导航栏设置透明
    public func setNavBarAlpha(alpha: CGFloat) {
        self.viewNavBack?.alpha = alpha
        self.imageNavLine?.alpha = alpha
    }
    ///导航栏分割线设置透明
    public func setNavLineAlpha(alpha: CGFloat) {
        self.imageNavLine?.alpha = alpha
    }
    ///设置数据模型
    open func setViewDataWithModel(model: ModelEntity) {
        
    }
    
    // MARK: - NotificationCenter
    
    /// 注册主题
    public func registerThemeNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setThemeChange(sender:)), name: keyNotificationNameTheme, object: nil)
    }
    public func removeThemeNotification() {
        NotificationCenter.default.removeObserver(self, name: keyNotificationNameTheme, object: nil)
    }
    open func setThemeChange(sender: Notification) {
        guard let theme = sender.object as? ThemeProtocol else {
            return
        }
        self.view.backgroundColor = theme.viewBackgroudColor
    }
    /// 注册键盘显示隐藏
    public func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setKeyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setKeyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    public func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc private func setKeyboardWillShow(sender: Notification) {
        guard let userInfo = sender.userInfo else {
            self.setKeyboardChange(0)
            return
        }
        let keyboardFrame: NSValue = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        self.setKeyboardChange(keyboardFrame.cgRectValue.height)
    }
    @objc private func setKeyboardWillHide(sender: Notification) {
        self.setKeyboardChange(0)
    }
    open func setKeyboardChange(_ height: CGFloat) {
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
