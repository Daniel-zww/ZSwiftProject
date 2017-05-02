//
//  ZTableView.swift
//  CompanyProject
//
//  Created by Daniel on 30/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh
import MJRefresh

class ZTableView: UITableView {
    
    private var viewBackground: ZBackgroundView?
    
    open var onBackgroundClickBlock: ((_ state: ZBackgroundState) -> Void)?
    
    // MARK: - SuperMethod
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init() {
        self.init(frame: CGRect.zero, style: UITableViewStyle.plain)
    }
    convenience init(frame: CGRect) {
        self.init(frame: frame, style: UITableViewStyle.plain)
    }
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.innerInit()
    }
    deinit {
        self.viewBackground = nil
        self.delDGRefreshHeader()
        self.delMJRefreshHeader()
        self.delMJRefreshFooter()
    }
    
    // MARK: - PrivateMethod

    private func innerInit() {
        self.backgroundColor = kColorViewBack1
        self.separatorStyle = .none
        self.viewBackground = ZBackgroundView(frame: self.bounds)
        self.viewBackground?.backgroundColor = self.backgroundColor
        self.viewBackground?.onButtonClickBlock = {[weak self] (state) -> Void in
            if self?.onBackgroundClickBlock != nil {
                self?.onBackgroundClickBlock?(state)
            }
        }
        self.backgroundView = self.viewBackground
    }
    
    // MARK: - PublicMethod
    
    open func addDGRefreshHeader(refreshBlock: @escaping () -> Void) {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        self.dg_addPullToRefreshWithActionHandler({
            refreshBlock()
        }, loadingView: loadingView)
        self.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        self.dg_setPullToRefreshBackgroundColor(self.backgroundColor!)
    }
    open func endDGRefreshHeader() {
        self.dg_stopLoading()
    }
    open func delDGRefreshHeader() {
        self.dg_removePullToRefresh()
    }
    open func addMJRefreshHeader(refreshBlock: @escaping () -> Void) {
        if self.mj_header == nil {
            self.mj_header = MJRefreshHeader.init(refreshingBlock: {
                refreshBlock()
            })
        }
    }
    open func addMJRefreshFooter(refreshBlock: @escaping () -> Void) {
        if self.mj_footer == nil {
            self.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
                refreshBlock()
            })
        }
    }
    open func endMJRefreshHeader() {
        if self.mj_header != nil {
            self.mj_header.endRefreshing()
        }
    }
    open func delMJRefreshHeader() {
        if self.mj_header != nil {
            self.mj_header.removeFromSuperview()
        }
    }
    open func endMJRefreshFooter() {
        if self.mj_footer != nil {
            self.mj_footer.endRefreshing()
        }
    }
    open func delMJRefreshFooter() {
        if self.mj_footer != nil {
            self.mj_footer.removeFromSuperview()
        }
    }
}
