//
//  ModelEntity.swift
//  CompanyProject
//
//  Created by Daniel on 17/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import CoreData
import SwiftRecord

/// 数据模型基类
class ModelEntity: NSManagedObject {
    
    
}
/// 参数数据模型
extension ModelParams {
    open class func create(_ name: String, value: String) -> ModelParams {
        let model = ModelParams.create() as! ModelParams
        model.name = name
        model.value = value
        return model
    }
    override public class func autoIncrementingId() -> String? {
        return "name"
    }
}
/// 用户数据模型
extension ModelUser {
    override public class func autoIncrementingId() -> String? {
        return "userId"
    }
    override public class func mappings() -> [String:String] {
        return ["userId": "id",
                "nickName": "nickname"]
    }
}
/// App版本数据模型
extension ModelAppVersion {
    override public class func autoIncrementingId() -> String? {
        return "appVersion"
    }
    override public class func mappings() -> [String:String] {
        return ["appVersion": "version_num",
                "appStatus": "status"]
    }
}


