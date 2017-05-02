//
//  KeyChain.swift
//  CompanyProject
//
//  Created by Daniel on 20/04/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import Security

fileprivate let kKeyChainLoginUserKey: String = "kKeyChainLoginUserKey"

class KeyChain: NSObject {

    /// 获取定义键值
    private class func getKeychainQuery(_ service: String) -> Dictionary<String, Any> {
        var dic = Dictionary<String, Any>()
        dic[kSecClass as String] = kSecClassGenericPassword
        dic[kSecAttrServer as String] = service
        dic[kSecAttrAccount as String] = service
        dic[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlock
        return dic
    }
    /// 加载数据对象
    private class func load(_ service: String) ->Dictionary<String, Any>?  {
        var ret: Dictionary<String, Any>? = nil
        var keychainQuery = self.getKeychainQuery(service)
        keychainQuery[kSecReturnData as String] = kCFBooleanTrue
        keychainQuery[kSecMatchLimit as String] = kSecMatchLimitOne
        
        var keyData : CFTypeRef?
        let status = SecItemCopyMatching(keychainQuery as CFDictionary, &keyData)
        if status == noErr {
            ret = NSKeyedUnarchiver.unarchiveObject(with: keyData as! Data) as? Dictionary<String, Any>
        }
        return ret
    }
    /// 删除数据对象
    private class func del(_ service: String) {
        let keychainQuery = self.getKeychainQuery(service)
        SecItemDelete(keychainQuery as CFDictionary)
    }
    /// 保存数据对象
    private class func save(_ service: String, _ data: Any) {
        var keychainQuery = self.getKeychainQuery(service)
        SecItemDelete(keychainQuery as CFDictionary)
        keychainQuery[kSecValueData as String] = NSKeyedArchiver.archivedData(withRootObject: data)
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    open class func loadLogin() ->Dictionary<String, Any>? {
        return self.load(kKeyChainLoginUserKey)
    }
    open class func delLogin() {
        self.del(kKeyChainLoginUserKey)
    }
    open class func saveLogin(_ data: Any) {
        self.save(kKeyChainLoginUserKey, data)
    }
}
