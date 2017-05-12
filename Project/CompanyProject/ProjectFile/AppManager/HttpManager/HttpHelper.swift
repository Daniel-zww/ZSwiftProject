//
//  HttpHelper.swift
//  CompanyProject
//
//  Created by Daniel on 17/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import Alamofire
import AFNetworking

fileprivate let kTimeout: TimeInterval = 15
fileprivate let kPlatformKey = "Platform"
fileprivate let kPlatformValue = "iOS"
fileprivate let kAppVersionKey = "AppVersion"
fileprivate let kUserIdKey = "userId"

class HttpHelper: NSObject {

    // MARK: - PrivateProperty
    
    private static let timeout: TimeInterval = 15
    private static var requestHeaders: [String: String] {
        var headers = [String: String]()
        headers[kPlatformKey] = kPlatformValue
        headers[kAppVersionKey] = kAppVersion
        headers[kUserIdKey] = keyUserDefaultId
        return headers
    }
    
    // MARK: - PublicProperty
    
    /**
     *  单例模式
     */
    open static let shared = HttpHelper()
    
    // MARK: - PrivateMethod
    
    private static let httpManager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
    private static let urlManager = AFURLSessionManager(sessionConfiguration: URLSessionConfiguration.default)
    private static func responseLog(response: DataResponse<String>) {
        ZLog("responseString: \(String(describing: response.request?.url?.absoluteString)), : \(String(describing: response.request?.httpBody?.utf8())), : \(String(describing: response.request?.allHTTPHeaderFields)), : \(response)")
    }
    private static func responseLog(error: Error) {
        ZLog("responseString: \(error)")
    }
    private static func responseLog(error: String) {
        ZLog("responseString: \(error)")
    }
    
    // MARK: - PublicMethod
    
    /**
     *  异步请求SNS通用方法
     *
     *  @param action       路由地址
     *  @param params       请求参数
     *  @param files        本地文件地址集合
     *  @param serverType   服务器地址类型
     *  @param taskBlock    请求对象
     *  @param resultBlock  返回数据对象
     */
    public func postAFRequestWithAction(_ action: String,
                                      params: [String: Any]?,
                                      files: Array<Any>?,
                                      serverType: ZServerType,
                                      taskBlock: @escaping (_: (_ sessionTask: URLSessionTask?) -> Void),
                                      resultBlock: @escaping (_: (_ result: RespHelper) -> Void)) {
        let strUrl: String = "\(kApiServerUrl)\(action)"
        let manager = HttpHelper.httpManager
        manager.responseSerializer = AFJSONResponseSerializer()
        var contentTypes = AFHTTPResponseSerializer().acceptableContentTypes
        contentTypes?.insert("text/html")
        manager.responseSerializer.acceptableContentTypes = contentTypes
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.requestSerializer.timeoutInterval = HttpHelper.timeout
        for (key, value) in HttpHelper.requestHeaders {
            manager.requestSerializer.setValue(value, forHTTPHeaderField: key)
        }
        manager.requestSerializer.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        var task: URLSessionDataTask?
        if let images = files {
            task = manager.post(strUrl, parameters: params, constructingBodyWith: { (formData) in
                var index = 0
                for file in images {
                    switch file {
                    case is String:
                        let path = file as! String
                        if FileManager.default.fileExists(atPath: path) {
                            do {
                                let fileurl = URL(fileURLWithPath: path)
                                let fileData = try Data(contentsOf: fileurl, options: Data.ReadingOptions.alwaysMapped)
                                formData.appendPart(withFileData: fileData, name: "file", fileName: kRandomImageName, mimeType: "application/x-www-form-urlencoded; charset=UTF-8")
                            } catch { }
                        }
                        break
                    case is Data:
                        let fileData = file as! Data
                        formData.appendPart(withFileData: fileData, name: "file", fileName: kRandomImageName, mimeType: "application/x-www-form-urlencoded; charset=UTF-8")
                        break
                    default:break
                    }
                    index += 1
                }
            }, progress: { (progress) in
                
            }, success: { (task, responseObject) in
                resultBlock(RespHelper.sharedWithDictionaryResponse(responseObject))
            }, failure: { (task, error) in
                resultBlock(RespHelper.sharedWithError(error))
            })
        } else {
            task = manager.post(strUrl, parameters: params, progress: { (progress) in
                
            }, success: { (task, responseObject) in
                resultBlock(RespHelper.sharedWithDictionaryResponse(responseObject))
            }, failure: { (task, error) in
                resultBlock(RespHelper.sharedWithError(error))
            })
        }
        taskBlock(task)
    }
    /**
     *  异步请求SNS通用方法
     *
     *  @param action       路由地址
     *  @param params       请求参数
     *  @param serverType   服务器地址类型
     *  @param taskBlock    请求对象
     *  @param resultBlock  返回数据对象
     */
    public func getAFRequestWithAction(action: String,
                                     params: [String: Any]?,
                                     taskBlock: @escaping (_: (_ sessionTask: URLSessionTask?) -> Void),
                                     resultBlock: @escaping (_: (_ result: RespHelper) -> Void)) {
        let strUrl: String = "\(kApiServerUrl)\(action)"
        
        self.getAFRequestWithAction(strUrl: strUrl, params: params, taskBlock: { (task) in
            taskBlock(task)
        }) { (resp) in
            resultBlock(resp)
        }
    }
    /**
     *  异步请求SNS通用方法
     *
     *  @param strUrl       请求地址
     *  @param params       请求参数
     *  @param serverType   服务器地址类型
     *  @param taskBlock    请求对象
     *  @param resultBlock  返回数据对象
     */
    public func getAFRequestWithAction(strUrl: String,
                                       params: [String: Any]?,
                                       taskBlock: @escaping (_: (_ sessionTask: URLSessionTask?) -> Void),
                                       resultBlock: @escaping (_: (_ result: RespHelper) -> Void)) {
        if let url = URL(string: strUrl) {
            var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: HttpHelper.timeout)
            request.httpMethod = HTTPMethod.get.rawValue
            for (key, value) in HttpHelper.requestHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
            let manager = HttpHelper.urlManager
            let task = manager.dataTask(with: request, uploadProgress: { (progress) in
                
            }, downloadProgress: { (progress) in
                
            }, completionHandler: { (response, responseObject, error) in
                if error == nil {
                    resultBlock(RespHelper.sharedWithDictionaryResponse(responseObject))
                } else {
                    resultBlock(RespHelper.sharedWithError(error!))
                }
            })
            taskBlock(task)
        } else {
            resultBlock(RespHelper.sharedWithException())
        }
    }
    /**
     *  异步请求SNS通用方法
     *
     *  @param action       路由地址
     *  @param params       请求参数
     *  @param serverType   服务器地址类型
     *  @param taskBlock    请求对象
     *  @param resultBlock  返回数据对象
     */
    public func postRequestWithAction(_ action: String,
                                      params: [String: Any]?,
                                      serverType: ZServerType,
                                      taskBlock: @escaping (_: (_ sessionTask: URLSessionTask?) -> Void),
                                      resultBlock: @escaping (_: (_ result: RespHelper) -> Void)) {
        do {
            let strUrl: String = "\(kApiServerUrl)\(action)"
            if let url = URL(string: strUrl) {
                let urlRequest = try URLRequest(url: url, method: HTTPMethod.post, headers: HttpHelper.requestHeaders)
                var encodedURLRequest = try URLEncoding.default.encode(urlRequest, with: params)
                encodedURLRequest.timeoutInterval = HttpHelper.timeout
                
                let request = Alamofire.request(encodedURLRequest)
                request.responseString(completionHandler: { (response) in
                    HttpHelper.responseLog(response: response)
                    switch response.result {
                    case .success:
                        resultBlock(RespHelper.sharedWithStringResponse(response))
                    case .failure(let error):
                        resultBlock(RespHelper.sharedWithError(error))
                    }
                })
                taskBlock(request.task)
            }
        } catch {
            resultBlock(RespHelper.sharedWithException())
        }
    }
    /**
     *  异步请求SNS通用方法
     *
     *  @param action           路由地址
     *  @param params           请求参数
     *  @param file             图片数据流
     *  @param serverType       服务器地址类型
     *  @param taskBlock        请求对象
     *  @param progressBlock    上传进度
     *  @param resultBlock      返回数据对象
     */
    public func postUploadFileWithAction(_ action: String,
                                          params: [String: Any]?,
                                          fileData: Data,
                                          serverType: ZServerType,
                                          taskBlock: @escaping (_: (_ sessionTask: URLSessionTask?) -> Void),
                                          progressBlock: @escaping (_: (_ progress: Progress) -> Void),
                                          resultBlock: @escaping (_: (_ result: RespHelper) -> Void)) {
        do {
            let strUrl: String = "\(kApiServerUrl)\(action)"
            if let url = URL(string: strUrl) {
                let urlRequest = try URLRequest(url: url, method: HTTPMethod.post, headers: HttpHelper.requestHeaders)
                var encodedURLRequest = try URLEncoding.default.encode(urlRequest, with: params)
                encodedURLRequest.timeoutInterval = HttpHelper.timeout
                
                Alamofire.upload(multipartFormData: { (multipartFormData) in
                    multipartFormData.append(fileData, withName: "file", fileName: kRandomImageName, mimeType: "application/x-www-form-urlencoded; charset=UTF-8")
                }, with: encodedURLRequest) { (encodingResult) in
                    switch encodingResult {
                    case .success(let encodingResult, _, _):
                        encodingResult.uploadProgress(closure: { (progress) in
                            progressBlock(progress)
                        })
                        encodingResult.responseString { (response) in
                            HttpHelper.responseLog(response: response)
                            switch response.result {
                            case .success:
                                resultBlock(RespHelper.sharedWithStringResponse(response))
                            case .failure(let error):
                                resultBlock(RespHelper.sharedWithError(error))
                            }
                        }
                        taskBlock(encodingResult.task)
                    case .failure(let error):
                        HttpHelper.responseLog(error: error)
                        resultBlock(RespHelper.sharedWithError(error))
                    }
                }
            }
        } catch {
            resultBlock(RespHelper.sharedWithException())
        }
    }
    /**
     *  异步请求SNS通用方法
     *
     *  @param action           路由地址
     *  @param params           请求参数
     *  @param files            图片数据流集合
     *  @param serverType       服务器地址类型
     *  @param taskBlock        请求对象
     *  @param progressBlock    上传进度
     *  @param resultBlock      返回数据对象
     */
    public func postUploadFilesWithAction(_ action: String,
                                          params: [String: Any]?,
                                          files: Array<Data>,
                                          serverType: ZServerType,
                                          taskBlock: @escaping (_: (_ sessionTask: URLSessionTask?) -> Void),
                                          progressBlock: @escaping (_: (_ progress: Progress) -> Void),
                                          resultBlock: @escaping (_: (_ result: RespHelper) -> Void)) {
        do {
            let strUrl: String = "\(kApiServerUrl)\(action)"
            if let url = URL(string: strUrl) {
                let urlRequest = try URLRequest(url: url, method: HTTPMethod.post, headers: HttpHelper.requestHeaders)
                var encodedURLRequest = try URLEncoding.default.encode(urlRequest, with: params)
                encodedURLRequest.timeoutInterval = HttpHelper.timeout
                
                Alamofire.upload(multipartFormData: { (multipartFormData) in
                    for index in 0...files.count {
                        multipartFormData.append(files[index], withName: "answerImg\(index)", fileName: kRandomImageName, mimeType: "application/x-www-form-urlencoded; charset=UTF-8")
                    }
                }, with: encodedURLRequest) { (encodingResult) in
                    switch encodingResult {
                    case .success(let encodingResult, _, _):
                        encodingResult.uploadProgress(closure: { (progress) in
                            progressBlock(progress)
                        })
                        encodingResult.responseString { (response) in
                            HttpHelper.responseLog(response: response)
                            switch response.result {
                            case .success:
                                resultBlock(RespHelper.sharedWithStringResponse(response))
                            case .failure(let error):
                                resultBlock(RespHelper.sharedWithError(error))
                            }
                        }
                        taskBlock(encodingResult.task)
                    case .failure(let error):
                        HttpHelper.responseLog(error: error)
                        resultBlock(RespHelper.sharedWithError(error))
                    }
                }
            }
        } catch {
            resultBlock(RespHelper.sharedWithException())
        }
    }
    /**
     *  异步请求SNS通用方法
     *
     *  @param action       路由地址
     *  @param params       请求参数
     *  @param serverType   服务器地址类型
     *  @param taskBlock    请求对象
     *  @param resultBlock  返回数据对象
     */
    public func getRequestWithAction(_ action: String,
                                     params: [String: Any]?,
                                     serverType: ZServerType,
                                     taskBlock: @escaping (_: (_ sessionTask: URLSessionTask?) -> Void),
                                     resultBlock: @escaping (_: (_ result: RespHelper) -> Void)) {
        do {
            let strUrl: String = "\(kApiServerUrl)\(action)"
            if let url = URL(string: strUrl) {
                let urlRequest = try URLRequest(url: url, method: HTTPMethod.get, headers: HttpHelper.requestHeaders)
                var encodedURLRequest = try URLEncoding.default.encode(urlRequest, with: params)
                encodedURLRequest.timeoutInterval = HttpHelper.timeout
                
                let request = Alamofire.request(encodedURLRequest)
                request.responseString(completionHandler: { (response) in
                    HttpHelper.responseLog(response: response)
                    switch response.result {
                    case .success:
                        resultBlock(RespHelper.sharedWithStringResponse(response))
                    case .failure(let error):
                        resultBlock(RespHelper.sharedWithError(error))
                    }
                })
                taskBlock(request.task)
            }
        } catch {
            resultBlock(RespHelper.sharedWithException())
        }
    }
    /**
     *  异步请求SNS通用方法
     *
     *  @param url          路由地址
     *  @param params       请求参数
     *  @param taskBlock    请求对象
     *  @param resultBlock  返回数据对象
     */
    public func getRequestWithUrl(_ strUrl: String,
                                  params: [String: Any]?,
                                  taskBlock: @escaping (_: (_ sessionTask: URLSessionTask?) -> Void),
                                  resultBlock: @escaping (_: (_ result: RespHelper) -> Void)) {
        do {
            if let url = URL(string: strUrl) {
                let urlRequest = try URLRequest(url: url, method: HTTPMethod.get, headers: HttpHelper.requestHeaders)
                var encodedURLRequest = try URLEncoding.default.encode(urlRequest, with: params)
                encodedURLRequest.timeoutInterval = HttpHelper.timeout
                
                let request = Alamofire.request(encodedURLRequest)
                request.responseString(completionHandler: { (response) in
                    HttpHelper.responseLog(response: response)
                    switch response.result {
                    case .success:
                        resultBlock(RespHelper.sharedWithStringResponse(response))
                    case .failure(let error):
                        resultBlock(RespHelper.sharedWithError(error))
                    }
                })
                taskBlock(request.task)
            }
        } catch {
            resultBlock(RespHelper.sharedWithException())
        }
    }
}
