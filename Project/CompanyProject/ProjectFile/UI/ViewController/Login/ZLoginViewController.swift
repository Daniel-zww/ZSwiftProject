//
//  ZLoginViewController.swift
//  CompanyProject
//
//  Created by Daniel on 21/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class ZLoginViewController: ZBaseViewController {

    // MARK: - PrivateProperty
    
    // MARK: - SuperMethod
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.innerInit()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setCloseButton()
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
        let btnLogin = ZButton(type: UIButtonType.custom)
        btnLogin.setTitle(kLocalLogin, for: UIControlState.normal)
        btnLogin.setTitleColor(kColorRed, for: UIControlState.normal)
        btnLogin.border(color: kColorRed, radius: 3, width: 1)
        btnLogin.frame = CGRect(x: kAppFrameWidth/2-50, y: 300, width: 100, height: 30)
        btnLogin.addTarget(self, action: #selector(btnLoginClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btnLogin)
    }
    private func setReloadData() {
        
    }
    override func btnLeftClick() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func btnLoginClick() {
        sns.postLogin("13658067608", "qqqqqq", { [weak self] (result) in
            ZProgressHUD.dismiss()
            ZProgressHUD.showSuccess("登录成功")
            
            let user = ModelUser.create(properties: result!) as? ModelUser
            if user != nil {
                let _ = user?.save()
                AppDelegate.loginin(user!)
            }
            
            self?.dismiss(animated: true, completion: nil)
        }, { (message) in
            ZProgressHUD.dismiss()
            ZProgressHUD.showError(message)
        }) { (task) -> Void in
            ZProgressHUD.show("正在登录...")
            ZLog("taskIdentifier: \(String(task!.taskIdentifier))")
        }
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
