//
//  ZImagePickerViewController.swift
//  CompanyProject
//
//  Created by Daniel on 18/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary
import AVFoundation

class ZImagePickerViewController: UIImagePickerController {

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
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        self.navigationBar.tintColor = kColorNavButton
        self.navigationBar.barTintColor = kColorNavBackground
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: kColorNavTitle]
    }
    private func reloadData() {
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
