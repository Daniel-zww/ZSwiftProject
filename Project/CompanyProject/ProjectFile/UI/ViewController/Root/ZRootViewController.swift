//
//  ZRootViewController.swift
//  CompanyProject
//
//  Created by Daniel on 17/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class ZRootViewController: UINavigationController, UINavigationControllerDelegate {

    // MARK: - PrivateProperty
    
    // MARK: - SuperMethod
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.innerInit()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.innerInit()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.navigationBar.isTranslucent = true
        //设置导航栏透明
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //设置导航栏分割线
        self.navigationBar.shadowImage = UIImage()
        //设置导航栏样式
        self.navigationBar.barStyle = UIBarStyle.default
        self.navigationBar.tintColor = kColorNavTitle
        self.navigationBar.barTintColor = kColorNavBackground
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: kColorNavTitle,
                                                  NSFontAttributeName: ZFont.boldFontWithSize(size: kFontSizeDefault)]
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
}
