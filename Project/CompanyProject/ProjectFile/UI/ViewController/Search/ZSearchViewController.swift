//
//  ZSearchViewController.swift
//  CompanyProject
//
//  Created by Daniel on 21/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class ZSearchViewController: ZBaseViewController, UISearchControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    // MARK: - PrivateProperty
    
    private var searchController: UISearchController?
    private var tvMain: ZTableView?
    private var arrayMain: Array<Any>?
    
    // MARK: - SuperMethod
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = kLocalSearch
        self.innerInit()
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
        self.searchController?.delegate = nil
        self.searchController?.searchResultsUpdater = nil
        self.searchController = nil
        self.arrayMain = nil
    }
    deinit {
        self.setViewNil()
    }
    
    // MARK: - PrivateMethod
    
    private func innerInit() {
        self.tvMain = ZTableView(frame: kViewItemFrame)
        self.tvMain?.dataSource = self
        self.tvMain?.delegate = self
        self.tvMain?.rowHeight = 44
        self.view.addSubview(self.tvMain!)
        
        let searchResultsVC: ZSearchResultsViewController = ZSearchResultsViewController()
        searchResultsVC.view.frame = kViewItemFrame
        searchResultsVC.hidesBottomBarWhenPushed = true
        
        self.searchController = UISearchController(searchResultsController: searchResultsVC)
        self.searchController?.delegate = self
        self.searchController?.searchResultsUpdater = searchResultsVC as UISearchResultsUpdating
        self.searchController?.searchBar.placeholder = kLocalSearch
        
        var searchBarFrame = self.searchController!.searchBar.frame
        searchBarFrame.size.height = kAppNavHeight
        self.searchController?.searchBar.frame = searchBarFrame
        self.tvMain?.tableHeaderView = self.searchController!.searchBar
        
        self.reloadData()
    }
    private func reloadData() {
        self.arrayMain = Array()
        for index in 1...100 {
            self.arrayMain?.append(index)
        }
        self.tvMain?.reloadData()
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
        cell?.textLabel?.text = "\(self.arrayMain![indexPath.row])"
        return cell!
    }
    
    // MARK: - UISearchControllerDelegate
    
    func willPresentSearchController(_ searchController: UISearchController) {
        
    }
    func didPresentSearchController(_ searchController: UISearchController) {
        
    }
    func willDismissSearchController(_ searchController: UISearchController) {
        
    }
    func didDismissSearchController(_ searchController: UISearchController) {
        
    }
    func presentSearchController(_ searchController: UISearchController) {
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
