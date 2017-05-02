//
//  Utils.swift
//  CompanyProject
//
//  Created by Daniel on 26/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class Utils: NSObject {
    ///创建目录
    open class func createDirectory(path: String) {
        if FileManager.default.fileExists(atPath: path) == false {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                ZLog(error)
            }
        }
    }
    ///删除目录
    open class func deleteDirectory(path: String) {
        if FileManager.default.fileExists(atPath: path) == true {
            do {
                let url = URL(fileURLWithPath: path)
                try FileManager.default.removeItem(at: url)
            } catch let error {
                ZLog(error)
            }
        }
    }
    ///图片保存到本地
    open class func writeImage(image: UIImage?, path: String?) -> Data? {
        if image == nil || path == nil {
            return nil
        }
        var imageData: Data?
        do {
            let url = URL(fileURLWithPath: path!)
            imageData = UIImageJPEGRepresentation(image!, 0.2)
            if let imageData = imageData {
                try imageData.write(to: url, options: Data.WritingOptions.atomic)
            }
        } catch let error {
            ZLog(error)
        }
        return imageData
    }
    ///判断微信是否安装
    open class func isWXAppInstalled() -> Bool {
        if UIApplication.shared.canOpenURL(URL(string: "weixin://")!) {
            return true
        }
        return false
    }
    ///判断QQ是否安装
    open class func isQQAppInstalled() -> Bool {
        if UIApplication.shared.canOpenURL(URL(string: "qq://")!) {
            return true
        }
        return false
    }
}
