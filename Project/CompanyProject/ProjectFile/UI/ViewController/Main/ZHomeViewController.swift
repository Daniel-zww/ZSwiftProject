//
//  ZHomeViewController.swift
//  CompanyProject
//
//  Created by Daniel on 21/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import BFKit

class ZHomeViewController: ZBaseViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - PrivateProperty
    
    private var tvMain: ZTableView?
    private var arrayMain: Array<Any>?
    
    // MARK: - SuperMethod
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = kLocalHome
        self.innerInit()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        if (self.view.window != nil) && self.isViewLoaded {
            self.setViewNil()
        }
    }
    private func setViewNil() {
        tvMain?.delegate = nil
        tvMain?.dataSource = nil
        tvMain = nil
        arrayMain = nil
    }
    deinit {
        self.setViewNil()
    }
    
    // MARK: - PrivateMethod
    
    private func innerInit() {
        self.arrayMain = ["登录","注销"]
        self.tvMain = ZTableView(frame: kViewTabFrame)
        self.tvMain?.dataSource = self
        self.tvMain?.delegate = self
        self.view.addSubview(self.tvMain!)
        
        weak var weakSelf = self
        self.tvMain?.addDGRefreshHeader(refreshBlock: {
            weakSelf?.reloadData()
        })
        self.reloadData()
    }
    private func reloadData() {
       self.tvMain?.endDGRefreshHeader()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayMain == nil {
            return 0
        }
        return self.arrayMain!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ZTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? ZTableViewCell
        if cell == nil {
            cell = ZTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = self.arrayMain![indexPath.row] as? String
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let itemVC = ZLoginViewController()
            let itemRVC = ZRootViewController(rootViewController: itemVC)
            self.present(itemRVC, animated: true, completion: nil)
            break
        case 1:
            AppDelegate.loginout()
            break
        default:
            break
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
