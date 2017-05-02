//
//  ZLabel.swift
//  CompanyProject
//
//  Created by Daniel on 21/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class ZLabel: UILabel {

    // MARK: - SuperMethod
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init() {
        super.init(frame: CGRect.zero)
        self.innerInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.innerInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.innerInit()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    // MARK: - PrivateMethod
    
    private func innerInit() {
        
    }
    
    // MARK: - PublicMethod
}
