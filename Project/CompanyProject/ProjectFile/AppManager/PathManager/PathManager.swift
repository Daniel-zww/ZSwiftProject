//
//  PathManager.swift
//  CompanyProject
//
//  Created by Daniel on 20/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

/// 文件地址管理
class PathManager: NSObject {
    /// 单例模式
    static let sharedInstance: PathManager = {
        let instance = PathManager()
        // Setup
        return instance
    }()
    /// 创建用户目录
    open class func createFileDir() {
        let userPath = self.getDocumentPath().appendingPathComponent(UserSetting.getUserId())
        self.createFileDir(userPath)
    }
    /// 删除用户目录
    open class func removeFileDir() {
        let userPath = self.getDocumentPath().appendingPathComponent(UserSetting.getUserId())
        Utils.deleteDirectory(path: userPath)
        
        self.createFileDir(userPath)
    }
    /// 创建用户目录
    private class func createFileDir(_ userPath: String) {
        Utils.createDirectory(path: userPath)
    }
     
    /// 获取Document目录地址
    open class func getDocumentPath() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
    }
    /// 获取Cache目录地址
    open class func getCachePath() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
    }
    /// 获取Library目录地址
    open class func getLibraryPath() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
    }
    /// 获取图片下载缓存地址
    open class func getPictureFilePath() -> String {
        return self.getCachePath().appendingPathComponent("default").appendingPathComponent("com.hackemist.SDWebImageCache.default")
    }
    
}
