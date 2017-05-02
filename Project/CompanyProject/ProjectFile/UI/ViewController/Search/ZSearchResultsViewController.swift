//
//  ZSearchResultsViewController.swift
//  CompanyProject
//
//  Created by Daniel on 18/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class ZSearchResultsViewController: ZBaseViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {

    // MARK: - PrivateProperty
    
    private var tvMain: ZTableView?
    private var searchText: String?
    private var arrayMain: Array<Any>?
    private var arraySearch: Array<Any>?
    private let tvFrame: CGRect = kViewItemFrame
    // MARK: - SuperMethod
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = kLocalUser
        self.innerInit()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerKeyboardNotification()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeKeyboardNotification()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        if (self.view.window != nil) && self.isViewLoaded {
            self.setViewNil()
        }
    }
    private func setViewNil() {
        self.tvMain?.dataSource = nil
        self.tvMain?.delegate = nil
        self.tvMain = nil
        self.searchText = nil
        self.arrayMain = nil
    }
    deinit {
        self.setViewNil()
    }
    
    // MARK: - PrivateMethod
    
    private func innerInit() {
        self.tvMain = ZTableView(frame: self.tvFrame)
        self.tvMain?.dataSource = self
        self.tvMain?.delegate = self
        self.tvMain?.rowHeight = 44
        self.view.addSubview(self.tvMain!)
        
        self.reloadData()
    }
    private func reloadData() {
        self.arrayMain = ["A","B","C","D","E","F","G","H","M","N","L"];
        self.arraySearch = self.arrayMain
        
        self.tvMain?.reloadData()
    }
    override func setKeyboardChange(_ height: CGFloat) {
        var tvFrame: CGRect = self.tvFrame
        tvFrame.size.height -= height
        self.tvMain?.frame = tvFrame
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        self.searchText = searchController.searchBar.text
        if self.searchText?.length == 0 {
            self.arraySearch = self.arrayMain?.filter({ return ($0 as! String).range(of: self.searchText!) != nil })
        } else {
            self.arraySearch = self.arrayMain
        }
        self.tvMain?.reloadData()
        ZLog(self.searchText)
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arraySearch == nil {
            return 0
        }
        return self.arraySearch!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ZTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? ZTableViewCell
        if cell == nil {
            cell = ZTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = "\(self.arraySearch![indexPath.row])"
        return cell!
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
