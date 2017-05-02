//
//  DataApi.swift
//  CompanyProject
//
//  Created by Daniel on 17/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import Alamofire

class DataApi: NSObject {

    // MARK: - PublicProperty
    
    /**
     *  单例模式
     */
    open static let shared = DataApi()
    
    // MARK: - PublicMethod
    
    /**
     *  举报错误信息
     *
     *  param   content             错误内容
     *  param   resultBlock         返回对象
     *  param   errorBlock          错误对象
     *  param   requestBlock        请求对象
     */
    open func postErrorReport(_ content: String, _ resultBlock: @escaping () -> Void, _ errorBlock: @escaping (_ message: String?) -> Void, _ requestBlock: @escaping (_: (_ sessionTask: URLSessionTask?) -> Void)) {
        var params = [String: String]()
        params["platform"] = "0"
        params["log_time"] = Date().toString
        
        HttpHelper.shared.postRequestWithAction("share/appLog/saveAppLog", params: params, serverType: ZServerType.None, taskBlock: { (task) in
            requestBlock(task)
        }) { (resp) in
            if resp.success {
                resultBlock()
            } else {
                errorBlock(resp.message)
            }
        }
    }
    /**
     *  获取版本数据集合
     *
     *  param   version             版本号 比如1.0.0
     *  param   resultBlock         返回对象
     *  param   errorBlock          错误对象
     */
    open func getAppVersion(_ appVersion: String,  _ resultBlock: @escaping (_ currentVersion: ModelAppVersion?,_ newVersion: ModelAppVersion?) -> Void, errorBlock: @escaping (_ message: String?) -> Void) {
        var params = [String: String]()
        params["platform"] = "0"
        params["versionNum"] = appVersion
        
        HttpHelper.shared.postRequestWithAction("share/v4/appversion/queryAppVersion", params: params, serverType: ZServerType.None, taskBlock: { (task) in
        }) { (resp) in
            if resp.success {
                let dicResult = resp.body as? [String: Any]
                let dicCurrent = dicResult?["currentVersion"] as? [String: Any]
                let dicMax = dicResult?["newVersion"] as? [String: Any]
                var versionCurrent: ModelAppVersion?
                var versionNew: ModelAppVersion?
                if let dicCurrent = dicCurrent {
                    versionCurrent = ModelAppVersion.create(properties: dicCurrent) as? ModelAppVersion
                }
                if let dicMax = dicMax {
                    versionNew = ModelAppVersion.create(properties: dicMax) as? ModelAppVersion
                }
                resultBlock(versionCurrent, versionNew)
            } else {
                errorBlock(resp.message)
            }
        }
    }
    /**
     *  登录账号
     *
     *  param   account             登录账号
     *  param   password            登录密码
     *  param   resultBlock         返回对象
     *  param   errorBlock          错误对象
     *  param   requestBlock        请求对象
     */
    open func postLogin(_ account: String, _ password: String, _ resultBlock: @escaping (_ result: [String: Any]?) -> Void, _ errorBlock: @escaping (_ message: String?) -> Void, _ requestBlock: @escaping (_: (_ sessionTask: URLSessionTask?) -> Void)) {
        var params = [String: String]()
        params["account"] = account
        params["password"] = password.MD5
        
        HttpHelper.shared.postRequestWithAction("share/user/login", params: params, serverType: ZServerType.None, taskBlock: { (task) in
            requestBlock(task)
        }) { (resp) in
            if resp.success {
                let dicResult = resp.body as? [String: Any]
                resultBlock(dicResult)
            } else {
                errorBlock(resp.message)
            }
        }
    }
    /**
     *  更新用户头像
     *
     *  param   userId              用户ID
     *  param   fileData            上传图片数据流
     *  param   progressBlock       上传进度
     *  param   resultBlock         返回对象
     *  param   errorBlock          错误对象
     *  param   requestBlock        请求对象
     */
    open func postChangeUserAvatar(_ userId: String, _ fileData: Data, _ progressBlock: @escaping (_ progress: Progress) -> Void, _ resultBlock: @escaping () -> Void, _ errorBlock: @escaping (_ message: String?) -> Void, _ requestBlock: @escaping (_: (_ sessionTask: URLSessionTask?) -> Void)) {
        var params = [String: String]()
        params["userId"] = userId
        params["nickname"] = "Daniel"
        params["sex"] = "1"
        
        HttpHelper.shared.postUploadFileWithAction("share/user/updateMyInfo", params: params, fileData: fileData, serverType: ZServerType.None, taskBlock: { (task) in
            requestBlock(task)
        }, progressBlock: { (progress) in
            progressBlock(progress)
        }) { (resp) in
            if resp.success {
                resultBlock()
            } else {
                errorBlock(resp.message)
            }
        }
    }
}


