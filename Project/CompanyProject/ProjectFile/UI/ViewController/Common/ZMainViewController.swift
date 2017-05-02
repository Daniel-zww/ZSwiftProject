//
//  ZMainViewController.swift
//  CompanyProject
//
//  Created by Daniel on 21/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import BFKit

class ZMainViewController: UITabBarController, UITabBarControllerDelegate {

    // MARK: - PrivateProperty
    
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
        self.innerInit()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setItemIcon()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        if (self.view.window != nil) && self.isViewLoaded {
            self.setViewNil()
        }
    }
    private func setViewNil() {
        
    }
    deinit {
        self.setViewNil()
    }
    
    // MARK: - PrivateMethod
    
    private func innerInit() {
        self.delegate = self
        
        let imgLine = UIImageView.getDLineView()
        imgLine.frame = CGRect(x: 0, y: 0, width: self.tabBar.w, height: kLineHeight)
        self.tabBar.addSubview(imgLine)

        self.tabBar.isTranslucent = true
        self.tabBar.shadowImage = UIImage(color: kColorClear)
        self.tabBar.backgroundImage = UIImage(color: kColorWhite)
        self.tabBar.tintColor = kColorTabbarSelectItem
        self.tabBar.barTintColor = kColorTabbarUnSelectItem
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = kColorTabbarUnSelectItem
        }
    }
    private func setItemIcon() {
        if self.viewControllers == nil || self.viewControllers!.count == 0 {
            let vcHome = AppDelegate.getVCWithIdentifier("VCHomeSID")!
            self.addChildWithViewController(vcHome, imageName: "tabbar_btn_item1", selectedImageName: "tabbar_btn_item1_pre", title: kLocalHome)
            let vcRootHome: ZRootViewController = ZRootViewController(rootViewController: vcHome)
            
            let vcUser = AppDelegate.getVCWithIdentifier("VCUserSID")!
            self.addChildWithViewController(vcUser, imageName: "tabbar_btn_item5", selectedImageName: "tabbar_btn_item5_pre", title: kLocalUser)
            let vcRootUser: ZRootViewController = ZRootViewController(rootViewController: vcUser)
            
            self.viewControllers = [vcRootHome, vcRootUser]
            self.selectedIndex = 0
        }
    }
    private func addChildWithViewController(_ vc: UIViewController, imageName: String, selectedImageName: String, title: String) {
        vc.tabBarItem = nil
        let tabBarItem: UITabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage(named: selectedImageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        if #available(iOS 10.0, *) {
            tabBarItem.badgeColor = kColorMain
        }
        tabBarItem.setTitleTextAttributes([NSFontAttributeName: ZFont.boldFontWithSize(size: kFontSizeMin)], for: UIControlState.normal)
        tabBarItem.setTitleTextAttributes([NSFontAttributeName: ZFont.boldFontWithSize(size: kFontSizeMin)], for: UIControlState.selected)
        vc.tabBarItem = tabBarItem
    }
    
    // MARK: - UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
