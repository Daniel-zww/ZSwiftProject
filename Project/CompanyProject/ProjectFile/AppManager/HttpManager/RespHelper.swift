//
//  RespHelper.swift
//  CompanyProject
//
//  Created by Daniel on 29/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import Alamofire

fileprivate let kResponseCodeKey: String  = "resultCode"
fileprivate let kResponseMsgKey: String = "resultMsg"
fileprivate let kResponseDataKey: String  = "result"

class RespHelper: NSObject {

    // MARK: - PublicProperty
    
    public var code: Int = HttpCode.kSNSReturnSuccess
    public var message: String?
    public var success: Bool = false
    public var body: Any?
    
    // MARK: - PublicMethod
    
    /// 处理字符串的方法
    public static func sharedWithStringResponse(_ response: DataResponse<String>) -> RespHelper {
        let resp: RespHelper = RespHelper()
        let json = response.result.value
        if json == nil {
            resp.setRespDataErrorWithObject(resp: resp)
            return resp
        }
        guard let jsonData = json!.data(using: String.Encoding.utf8) else {
            resp.setRespDataErrorWithObject(resp: resp)
            return resp
        }
        do {
            let dicResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
            if dicResult == nil {
                resp.setRespDataErrorWithObject(resp: resp)
                return resp
            } else {
                let code = dicResult![kResponseCodeKey]
                switch code {
                case is String:
                    resp.code = (code as! String).intValue
                    break
                case is Int:
                    resp.code = code as! Int
                    break
                case is Int8:
                    resp.code = code as! Int
                    break
                case is Int32:
                    resp.code = code as! Int
                    break
                case is Int64:
                    resp.code = code as! Int
                    break
                default:
                    break
                }
                resp.message = resp.getMessageWithCode(resp.code)
                resp.body = dicResult![kResponseDataKey]
                resp.success = resp.code == HttpCode.kSNSReturnSuccess
            }
        } catch let error {
            resp.body = nil
            resp.success = false
            resp.code = error.code
            resp.message = error.localizedDescription
            return resp
        }
        return resp
    }
    public static func sharedWithDictionaryResponse(_ response: Any?) -> RespHelper {
        let resp: RespHelper = RespHelper()
        if response == nil || response is NSNull || response is String {
            resp.code = HttpCode.kSNSReturnServerDataError
            resp.message = HttpCode.kSNSReturnServerDataErrorText
            resp.body = nil
            resp.success = false
        } else {
            if let dicResult = response as? Dictionary<String, Any> {
                let code = dicResult[kResponseCodeKey]
                switch code {
                case is String:
                    resp.code = (code as! String).intValue
                    break
                case is Int:
                    resp.code = code as! Int
                    break
                case is Int8:
                    resp.code = code as! Int
                    break
                case is Int32:
                    resp.code = code as! Int
                    break
                case is Int64:
                    resp.code = code as! Int
                    break
                default:
                    break
                }
                resp.message = resp.getMessageWithCode(resp.code)
                resp.body = dicResult[kResponseDataKey]
                resp.success = resp.code == HttpCode.kSNSReturnSuccess
            } else {
                resp.code = HttpCode.kSNSReturnServerDataError
                resp.message = HttpCode.kSNSReturnServerDataErrorText
                resp.body = nil
                resp.success = false
            }
        }
        return resp
    }
    /// 处理错误的方法
    public static func sharedWithError(_ error: Error) -> RespHelper {
        let resp: RespHelper = RespHelper()
        resp.body = nil
        resp.success = false
        resp.code = error.code
        resp.message = resp.getMessageWithCode(resp.code)
        return resp
    }
    /// 处理异常的方法
    public static func sharedWithException() -> RespHelper {
        let resp: RespHelper = RespHelper()
        resp.setRespErrorWithObject(resp: resp)
        return resp
    }
    
    // MARK: - PrivateMethod
    
    private func setRespErrorWithObject(resp: RespHelper) {
        resp.body = nil
        resp.success = false
        resp.code = HttpCode.kSNSReturnServerDecryptDataError
        resp.message = HttpCode.kSNSReturnServerDecryptDataErrorText
    }
    private func setRespDataErrorWithObject(resp: RespHelper) {
        resp.body = nil
        resp.success = false
        resp.code = HttpCode.kSNSReturnServerDataError
        resp.message = HttpCode.kSNSReturnServerDataErrorText
    }
    private func getMessageWithCode(_ code: Int) -> String {
        switch (code) {
        case HttpCode.kSNSReturnServerDataError:
            return HttpCode.kSNSReturnServerDataErrorText
        case HttpCode.kSNSReturnServerTokenExpired:
            return HttpCode.kSNSReturnServerTokenExpiredText
            
        case HttpCode.kSNSReturnServer1:
            return HttpCode.kSNSReturnServer1Text
        case HttpCode.kSNSReturnServer2:
            return HttpCode.kSNSReturnServer2Text
        case HttpCode.kSNSReturnServer3:
            return HttpCode.kSNSReturnServer3Text
        case HttpCode.kSNSReturnServer4:
            return HttpCode.kSNSReturnServer4Text
        case HttpCode.kSNSReturnServer5:
            return HttpCode.kSNSReturnServer5Text
        case HttpCode.kSNSReturnServer6:
            return HttpCode.kSNSReturnServer6Text
        case HttpCode.kSNSReturnServer7:
            return HttpCode.kSNSReturnServer7Text
        case HttpCode.kSNSReturnServer8:
            return HttpCode.kSNSReturnServer8Text
        case HttpCode.kSNSReturnServer9:
            return HttpCode.kSNSReturnServer9Text
        case HttpCode.kSNSReturnServer10:
            return HttpCode.kSNSReturnServer10Text
        case HttpCode.kSNSReturnServer11:
            return HttpCode.kSNSReturnServer11Text
            
        case HttpCode.kSNSReturnServer3840:
            return HttpCode.kSNSReturnServer3840Text
        case HttpCode.kSNSReturnServerNSFileLockingError:
            return HttpCode.kSNSReturnServerNSFileLockingErrorText
        case HttpCode.kSNSReturnServerNSFileReadUnknownError:
            return HttpCode.kSNSReturnServerNSFileReadUnknownErrorText
        case HttpCode.kSNSReturnServerNSFileReadNoPermissionError:
            return HttpCode.kSNSReturnServerNSFileReadNoPermissionErrorText
        case HttpCode.kSNSReturnServerNSFileReadInvalidFileNameError:
            return HttpCode.kSNSReturnServerNSFileReadInvalidFileNameErrorText
        case HttpCode.kSNSReturnServerNSFileReadCorruptFileError:
            return HttpCode.kSNSReturnServerNSFileReadCorruptFileErrorText
        case HttpCode.kSNSReturnServerNSFileReadNoSuchFileError:
            return HttpCode.kSNSReturnServerNSFileReadNoSuchFileErrorText
        case HttpCode.kSNSReturnServerNSFileReadInapplicableStringEncodingError:
            return HttpCode.kSNSReturnServerNSFileReadInapplicableStringEncodingErrorText
        case HttpCode.kSNSReturnServerNSFileReadUnsupportedSchemeError:
            return HttpCode.kSNSReturnServerNSFileReadUnsupportedSchemeErrorText
        case HttpCode.kSNSReturnServerNSFileReadTooLargeError:
            return HttpCode.kSNSReturnServerNSFileReadTooLargeErrorText
        case HttpCode.kSNSReturnServerNSFileReadUnknownStringEncodingError:
            return HttpCode.kSNSReturnServerNSFileReadUnknownStringEncodingErrorText
        case HttpCode.kSNSReturnServerNSFileWriteUnknownError:
            return HttpCode.kSNSReturnServerNSFileWriteUnknownErrorText
        case HttpCode.kSNSReturnServerNSFileWriteNoPermissionError:
            return HttpCode.kSNSReturnServerNSFileWriteNoPermissionErrorText
        case HttpCode.kSNSReturnServerNSFileWriteInvalidFileNameError:
            return HttpCode.kSNSReturnServerNSFileWriteInvalidFileNameErrorText
        case HttpCode.kSNSReturnServerNSFileWriteInapplicableStringEncodingError:
            return HttpCode.kSNSReturnServerNSFileWriteInapplicableStringEncodingErrorText
        case HttpCode.kSNSReturnServerNSFileWriteUnsupportedSchemeError:
            return HttpCode.kSNSReturnServerNSFileWriteUnsupportedSchemeErrorText
        case HttpCode.kSNSReturnServerNSFileWriteOutOfSpaceError:
            return HttpCode.kSNSReturnServerNSFileWriteOutOfSpaceErrorText
        case HttpCode.kSNSReturnServerNSFileWriteVolumeReadOnlyError:
            return HttpCode.kSNSReturnServerNSFileWriteVolumeReadOnlyErrorText
        case HttpCode.kSNSReturnServerNSKeyValueValidationError:
            return HttpCode.kSNSReturnServerNSKeyValueValidationErrorText
        case HttpCode.kSNSReturnServerNSFormattingError:
            return HttpCode.kSNSReturnServerNSFormattingErrorText
        case HttpCode.kSNSReturnServerNSUserCancelledError:
            return HttpCode.kSNSReturnServerNSUserCancelledErrorText
        case HttpCode.kSNSReturnServerNSPropertyListReadUnknownVersionError:
            return HttpCode.kSNSReturnServerNSPropertyListReadUnknownVersionErrorText
        case HttpCode.kSNSReturnServerNSPropertyListReadStreamError:
            return HttpCode.kSNSReturnServerNSPropertyListReadStreamErrorText
        case HttpCode.kSNSReturnServerNSPropertyListWriteStreamError:
            return HttpCode.kSNSReturnServerNSPropertyListWriteStreamErrorText
        case HttpCode.kSNSReturnServerNSPropertyListErrorMaximum:
            return HttpCode.kSNSReturnServerNSPropertyListErrorMaximumText
        case HttpCode.kSNSReturnServerNSExecutableNotLoadableError:
            return HttpCode.kSNSReturnServerNSExecutableNotLoadableErrorText
        case HttpCode.kSNSReturnServerNSExecutableArchitectureMismatchError:
            return HttpCode.kSNSReturnServerNSExecutableArchitectureMismatchErrorText
        case HttpCode.kSNSReturnServerNSExecutableRuntimeMismatchError:
            return HttpCode.kSNSReturnServerNSExecutableRuntimeMismatchErrorText
        case HttpCode.kSNSReturnServerNSExecutableLoadError:
            return HttpCode.kSNSReturnServerNSExecutableLoadErrorText
        case HttpCode.kSNSReturnServerNSExecutableLinkError:
            return HttpCode.kSNSReturnServerNSExecutableLinkErrorText
        case HttpCode.kSNSReturnServerNSExecutableErrorMaximum:
            return HttpCode.kSNSReturnServerNSExecutableErrorMaximumText
            
        case HttpCode.kSNSReturn200:
            return HttpCode.kSNSReturn200Text
        case HttpCode.kSNSReturn201:
            return HttpCode.kSNSReturn201Text
        case HttpCode.kSNSReturn202:
            return HttpCode.kSNSReturn202Text
        case HttpCode.kSNSReturn203:
            return HttpCode.kSNSReturn203Text
        case HttpCode.kSNSReturn204:
            return HttpCode.kSNSReturn204Text
            
        case HttpCode.kSNSReturn301:
            return HttpCode.kSNSReturn301Text
        case HttpCode.kSNSReturn302:
            return HttpCode.kSNSReturn302Text
        case HttpCode.kSNSReturn303:
            return HttpCode.kSNSReturn303Text
        case HttpCode.kSNSReturn304:
            return HttpCode.kSNSReturn304Text
        case HttpCode.kSNSReturn305:
            return HttpCode.kSNSReturn305Text
        case HttpCode.kSNSReturn306:
            return HttpCode.kSNSReturn306Text
            
        case HttpCode.kSNSReturn400:
            return HttpCode.kSNSReturn400Text
        case HttpCode.kSNSReturn401:
            return HttpCode.kSNSReturn401Text
        case HttpCode.kSNSReturn402:
            return HttpCode.kSNSReturn402Text
        case HttpCode.kSNSReturn403:
            return HttpCode.kSNSReturn403Text
        case HttpCode.kSNSReturn404:
            return HttpCode.kSNSReturn404Text
        case HttpCode.kSNSReturn407:
            return HttpCode.kSNSReturn407Text
        case HttpCode.kSNSReturn415:
            return HttpCode.kSNSReturn415Text
            
        case HttpCode.kSNSReturn500:
            return HttpCode.kSNSReturn500Text
        case HttpCode.kSNSReturn501:
            return HttpCode.kSNSReturn501Text
        case HttpCode.kSNSReturn502:
            return HttpCode.kSNSReturn502Text
        case HttpCode.kSNSReturn503:
            return HttpCode.kSNSReturn503Text
            
        case HttpCode.kSNSReturnWechat40001:
            return HttpCode.kSNSReturnWechat40001Text
        case HttpCode.kSNSReturnWechat40002:
            return HttpCode.kSNSReturnWechat40002Text
        case HttpCode.kSNSReturnWechat40003:
            return HttpCode.kSNSReturnWechat40003Text
        case HttpCode.kSNSReturnWechat40004:
            return HttpCode.kSNSReturnWechat40004Text
        case HttpCode.kSNSReturnWechat40007:
            return HttpCode.kSNSReturnWechat40007Text
        case HttpCode.kSNSReturnWechat40008:
            return HttpCode.kSNSReturnWechat40008Text
        case HttpCode.kSNSReturnWechat40009:
            return HttpCode.kSNSReturnWechat40009Text
        case HttpCode.kSNSReturnWechat40010:
            return HttpCode.kSNSReturnWechat40010Text
        case HttpCode.kSNSReturnWechat40011:
            return HttpCode.kSNSReturnWechat40011Text
        case HttpCode.kSNSReturnWechat40012:
            return HttpCode.kSNSReturnWechat40012Text
        case HttpCode.kSNSReturnWechat40013:
            return HttpCode.kSNSReturnWechat40013Text
        case HttpCode.kSNSReturnWechat40014:
            return HttpCode.kSNSReturnWechat40014Text
        case HttpCode.kSNSReturnWechat40015:
            return HttpCode.kSNSReturnWechat40015Text
        case HttpCode.kSNSReturnWechat40016:
            return HttpCode.kSNSReturnWechat40016Text
        case HttpCode.kSNSReturnWechat40017:
            return HttpCode.kSNSReturnWechat40017Text
        case HttpCode.kSNSReturnWechat40018:
            return HttpCode.kSNSReturnWechat40018Text
        case HttpCode.kSNSReturnWechat40019:
            return HttpCode.kSNSReturnWechat40019Text
        case HttpCode.kSNSReturnWechat40020:
            return HttpCode.kSNSReturnWechat40020Text
        case HttpCode.kSNSReturnWechat40023:
            return HttpCode.kSNSReturnWechat40023Text
        case HttpCode.kSNSReturnWechat40024:
            return HttpCode.kSNSReturnWechat40024Text
        case HttpCode.kSNSReturnWechat40025:
            return HttpCode.kSNSReturnWechat40025Text
        case HttpCode.kSNSReturnWechat40026:
            return HttpCode.kSNSReturnWechat40026Text
        case HttpCode.kSNSReturnWechat40027:
            return HttpCode.kSNSReturnWechat40027Text
        case HttpCode.kSNSReturnWechat40029:
            return HttpCode.kSNSReturnWechat40029Text
        case HttpCode.kSNSReturnWechat40030:
            return HttpCode.kSNSReturnWechat40030Text
        case HttpCode.kSNSReturnWechat40036:
            return HttpCode.kSNSReturnWechat40036Text
        case HttpCode.kSNSReturnWechat40037:
            return HttpCode.kSNSReturnWechat40037Text
        case HttpCode.kSNSReturnWechat40039:
            return HttpCode.kSNSReturnWechat40039Text
        case HttpCode.kSNSReturnWechat40048:
            return HttpCode.kSNSReturnWechat40048Text
        case HttpCode.kSNSReturnWechat40054:
            return HttpCode.kSNSReturnWechat40054Text
        case HttpCode.kSNSReturnWechat40055:
            return HttpCode.kSNSReturnWechat40055Text
        case HttpCode.kSNSReturnWechat40066:
            return HttpCode.kSNSReturnWechat40066Text
        case HttpCode.kSNSReturnWechat41001:
            return HttpCode.kSNSReturnWechat41001Text
        case HttpCode.kSNSReturnWechat41002:
            return HttpCode.kSNSReturnWechat41002Text
        case HttpCode.kSNSReturnWechat41003:
            return HttpCode.kSNSReturnWechat41003Text
        case HttpCode.kSNSReturnWechat41004:
            return HttpCode.kSNSReturnWechat41004Text
        case HttpCode.kSNSReturnWechat41005:
            return HttpCode.kSNSReturnWechat41005Text
        case HttpCode.kSNSReturnWechat41006:
            return HttpCode.kSNSReturnWechat41006Text
        case HttpCode.kSNSReturnWechat41007:
            return HttpCode.kSNSReturnWechat41007Text
        case HttpCode.kSNSReturnWechat41008:
            return HttpCode.kSNSReturnWechat41008Text
        case HttpCode.kSNSReturnWechat41009:
            return HttpCode.kSNSReturnWechat41009Text
        case HttpCode.kSNSReturnWechat41010:
            return HttpCode.kSNSReturnWechat41010Text
        case HttpCode.kSNSReturnWechat42001:
            return HttpCode.kSNSReturnWechat42001Text
        case HttpCode.kSNSReturnWechat42002:
            return HttpCode.kSNSReturnWechat42002Text
        case HttpCode.kSNSReturnWechat42003:
            return HttpCode.kSNSReturnWechat42003Text
        case HttpCode.kSNSReturnWechat43001:
            return HttpCode.kSNSReturnWechat43001Text
        case HttpCode.kSNSReturnWechat43002:
            return HttpCode.kSNSReturnWechat43002Text
        case HttpCode.kSNSReturnWechat43003:
            return HttpCode.kSNSReturnWechat43003Text
        case HttpCode.kSNSReturnWechat43004:
            return HttpCode.kSNSReturnWechat43004Text
        case HttpCode.kSNSReturnWechat44001:
            return HttpCode.kSNSReturnWechat44001Text
        case HttpCode.kSNSReturnWechat44002:
            return HttpCode.kSNSReturnWechat44002Text
        case HttpCode.kSNSReturnWechat44003:
            return HttpCode.kSNSReturnWechat44003Text
        case HttpCode.kSNSReturnWechat44004:
            return HttpCode.kSNSReturnWechat44004Text
        case HttpCode.kSNSReturnWechat44005:
            return HttpCode.kSNSReturnWechat44005Text
        case HttpCode.kSNSReturnWechat45001:
            return HttpCode.kSNSReturnWechat45001Text
        case HttpCode.kSNSReturnWechat45002:
            return HttpCode.kSNSReturnWechat45002Text
        case HttpCode.kSNSReturnWechat45003:
            return HttpCode.kSNSReturnWechat45003Text
        case HttpCode.kSNSReturnWechat45004:
            return HttpCode.kSNSReturnWechat45004Text
        case HttpCode.kSNSReturnWechat45005:
            return HttpCode.kSNSReturnWechat45005Text
        case HttpCode.kSNSReturnWechat45006:
            return HttpCode.kSNSReturnWechat45006Text
        case HttpCode.kSNSReturnWechat45007:
            return HttpCode.kSNSReturnWechat45007Text
        case HttpCode.kSNSReturnWechat45008:
            return HttpCode.kSNSReturnWechat45008Text
        case HttpCode.kSNSReturnWechat45009:
            return HttpCode.kSNSReturnWechat45009Text
        case HttpCode.kSNSReturnWechat45010:
            return HttpCode.kSNSReturnWechat45010Text
        case HttpCode.kSNSReturnWechat45011:
            return HttpCode.kSNSReturnWechat45011Text
        case HttpCode.kSNSReturnWechat45012:
            return HttpCode.kSNSReturnWechat45012Text
        case HttpCode.kSNSReturnWechat45016: 
            return HttpCode.kSNSReturnWechat45016Text
        case HttpCode.kSNSReturnWechat45017: 
            return HttpCode.kSNSReturnWechat45017Text
        case HttpCode.kSNSReturnWechat45018: 
            return HttpCode.kSNSReturnWechat45018Text
        case HttpCode.kSNSReturnWechat50001: 
            return HttpCode.kSNSReturnWechat50001Text
        default: return HttpCode.kSNSReturnServerDefaultText
        }
    }
    
}
