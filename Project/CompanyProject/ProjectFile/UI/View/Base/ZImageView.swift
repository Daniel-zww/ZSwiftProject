//
//  ZImageView.swift
//  CompanyProject
//
//  Created by Daniel on 21/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import SDWebImage

class ZImageView: UIImageView {

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
    
    // MARK: - PrivateMethod
    
    private func innerInit() {
        
    }
    
    // MARK: - PublicMethod
    
    /// 设置图片-图片名称
    func setImageWithName(_ name: String) {
        self.image = UIImage(named: name)
    }
    /// 设置图片-图片URL地址
    func setImageWithUrl(_ strUrl: String) {
        guard let placeImage = UIImage(named: "new_image_default") else {
            return
        }
        self.setImageWithUrl(strUrl, placeImage) { (image) in }
    }
    /// 设置图片-图片URL地址,默认图片
    func setImageWithUrl(_ strUrl: String, _ placeImage: UIImage) {
        self.setImageWithUrl(strUrl, placeImage) { (image) in }
    }
    /// 设置图片-图片URL地址,默认图片,下载完成回调
    func setImageWithUrl(_ strUrl: String, _ placeImage: UIImage, _ completed: @escaping ((_ image: UIImage?) -> Void)) {
        self.setImageWithUrl(strUrl, placeImage, { (receivedSize, expectedSize) in }) {[weak self] (image) in
            self?.image = image
            completed(image)
        }
    }
    /// 设置图片-图片URL地址,默认图片,下载完成回调
    func setImageWithUrl(_ strUrl: String, _ placeImage: UIImage, _ progress: @escaping ((_ receivedSize: Int, _ expectedSize: Int) -> Void), _ completed: @escaping ((_ image: UIImage?) -> Void)) {
        guard let url = URL(string: strUrl) else {
            return
        }
        self.sd_setImage(with: url, placeholderImage: placeImage, options: [.retryFailed, .lowPriority, .continueInBackground], progress: { (receivedSize, expectedSize) in
            progress(receivedSize, expectedSize)
        }) {[weak self] (image, error, type, url) in
            self?.image = image
            completed(image)
        }
    }
}
