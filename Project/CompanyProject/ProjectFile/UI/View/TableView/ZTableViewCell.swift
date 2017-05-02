//
//  ZTableViewCell.swift
//  CompanyProject
//
//  Created by Daniel on 30/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

fileprivate let cellId: String = "cellId"

class ZTableViewCell: UITableViewCell {

    // MARK: - PrivateProperty
    
    private static let kBaseTVCH: CGFloat = 15
    
    // MARK: - PublicProperty
    
    public let cellW: CGFloat = kAppFrameWidth
    public var cellH: CGFloat = 10
    public let space: CGFloat = 14
    public let lineH: CGFloat = kLineHeight
    public let lbH: CGFloat = 20
    public let arrowW: CGFloat = kAppFrameWidth/11
    
    public var viewMain: UIView?
    
    // MARK: - SuperMethod
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init() {
        self.init(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.innerInit()
    }
    deinit {
        self.viewMain?.removeFromSuperview()
        self.viewMain = nil
    }
    
    // MARK: - PrivateMethod
    
    private func innerInit() {
        self.backgroundColor = kColorTVCBackground
        self.accessoryType = .none
        self.selectionStyle = .none
        
        self.viewMain = UIView()
        self.viewMain?.backgroundColor = kColorWhite
        self.viewMain?.isUserInteractionEnabled = true
        self.contentView.addSubview(self.viewMain!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.viewMain?.frame = self.getMainFrame()
    }
    
    // MARK: - PublicMethod
    
    open func getMainFrame() -> CGRect {
        return CGRect(x: 0, y: 0, width: self.cellW, height: self.cellH)
    }
    open func getH() -> CGFloat {
        return self.cellH
    }
    open class func getH() -> CGFloat {
        return kBaseTVCH
    }
    
}
