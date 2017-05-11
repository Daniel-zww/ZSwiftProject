//
//  AppDelegate.swift
//  CompanyProject
//
//  Created by Daniel on 17/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireNetworkActivityIndicator
import UserNotifications
import SwiftRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    private var isCheckVersion: Bool = false
    open var isAppAudit: Bool = false
    open var storyBoard: UIStoryboard?
    open var devTokenStr: String?
    open var appEnterBackground: Bool = false
    
    ///APP启动页面加载完成
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //获取Storyboard对象
        self.storyBoard = UIStoryboard(name: "Main", bundle: nil)
        NetworkActivityIndicatorManager.shared.isEnabled = true
        //初始化本地数据库
        self.setConfigDataBase()
        //注册通知
        self.registerPush(launchOptions)
        //添加3D Touch
        self.createTouchItemsWithIcons()
        //更新App服务器配置信息
        //AppDelegate.setRefreshAppConfig()
        //检测AppStore信息
        //self.checkAppStoreVersion()
        //更新本地用户信息
        self.setConfigUserInfo()
        
        //系统参数设置
        self.window?.backgroundColor = kColorWhite
        self.window?.makeKeyAndVisible()
        application.isStatusBarHidden = false
        application.statusBarStyle = UIStatusBarStyle.default
        self.becomeFirstResponder()
        return true
    }
    ///已经进入前台
    func applicationDidBecomeActive(_ application: UIApplication) {
        self.appEnterBackground = false
        UIApplication.shared.isStatusBarHidden = false
    }
    ///已经进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.appEnterBackground = true
    }
    ///关闭时执行的事件
    func applicationWillTerminate(_ application: UIApplication) {
        let _ = DBHelper.sharedRecord.saveContext()
    }
    ///远程控制播放器
    override func remoteControlReceived(with event: UIEvent?) {
        
    }
    ///屏幕支持方向设置
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    }
    
    // MARK: - Application OpenURL
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return self.getHandleOpenURL(url: url, sourceApplication: nil, annotation: nil, isHttps: false)
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return self.getHandleOpenURL(url: url, sourceApplication: sourceApplication, annotation: annotation, isHttps: true)
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return self.getHandleOpenURL(url: url, sourceApplication: nil, annotation: nil, isHttps: false)
    }
    fileprivate func getHandleOpenURL(url: URL, sourceApplication: String?, annotation: Any?, isHttps: Bool) -> Bool {
        if url.absoluteString.isEqualToString(verifyValue: kekMyAppSchemeHost) {
            PushHelper.setPushViewControllerWithUrl(url: url)
        }
        return true
    }
    
    // MARK: - Push Notification Block
    /// iOS10-处理收到通知的代理方法
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        UMessage.setAutoAlert(false)
        UMessage.didReceiveRemoteNotification(userInfo)
        if application.applicationState == .active {
            self.addLocationNotification(userInfo)
        } else {
            PushHelper.setPushContentWithUserInfo(userInfo: userInfo)
        }
    }
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        if application.applicationState != .active {
            PushHelper.setPushContentWithUserInfo(userInfo: notification.userInfo)
        }
    }
    /// iOS10+处理前台收到通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            UMessage.setAutoAlert(false)
            UMessage.didReceiveRemoteNotification(userInfo)
        }
        completionHandler([.badge,.alert,.sound])
    }
    /// iOS10+处理后台点击通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            UMessage.sendClickReport(forRemoteNotification: userInfo)
            PushHelper.setPushContentWithUserInfo(userInfo: userInfo)
        }
        completionHandler()
    }
    
    // MARK: - Push Notification Service
    /// 获取到用户设备TOKEN
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        UMessage.registerDeviceToken(deviceToken)
        self.devTokenStr = deviceToken.description.replacingOccurrences(of: "<", with: kEmpty).replacingOccurrences(of: ">", with: kEmpty).replacingOccurrences(of: " ", with: kEmpty)
        if let devTokenStr = self.devTokenStr {
            let params = ModelParams.create(keySQLiteDeviceToken, value: devTokenStr) as ModelParams
            let _ = params.save()
        }
        self.setPushAccount()
    }
    /// 注册用户通知设置失败
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    // MARK: - Application 3D Touch Event
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        switch shortcutItem.type {
            case "None": break
            default: break
        }
    }
    
    // MARK: - PrivateMethod
    
    ///注册统计
    private func registerStatistics() {
        
    }
    ///注册分享
    private func registerShare() {
        
    }
    ///注册推送
    private func registerPush(_ launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        #if DEBUG
            UMessage.start(withAppkey: keyUMengAppKey, launchOptions: launchOptions, httpsEnable: false)
            UMessage.setLogEnabled(true)
        #else
            UMessage.start(withAppkey: keyUMengAppKey, launchOptions: launchOptions, httpsEnable: true)
        #endif
        UMessage.registerForRemoteNotifications()
        
        self.registerRemoteNotification()
    }
    ///注册通知
    private func registerRemoteNotification() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { (granted, error) in
                if granted == true {
                    ZLog("UNUserNotificationCenter completionHandler 授权")
                } else {
                    ZLog("UNUserNotificationCenter completionHandler 拒绝")
                }
            })
            UIApplication.shared.registerForRemoteNotifications()
            UNUserNotificationCenter.current().delegate = self
        } else {
            //let settings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            //UIApplication.shared.registerUserNotificationSettings(settings)
        }
    }
    ///添加3D Touch
    private func createTouchItemsWithIcons() {
        
    }
    ///检测AppStore版本
    private func checkAppStoreVersion() {
        let url = URL(string: kAppVersionUrl)
        if url != nil {
            do {
                let request = try URLRequest(url: url!, method: HTTPMethod.post)
                let session = URLSession(configuration: URLSessionConfiguration.default)
                let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data {
                        do {
                            let dicAppInfo = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                            guard let appinfo = dicAppInfo as? [String: Any] else {
                                return
                            }
                            let arrayResult = appinfo["results"]
                            guard let result = arrayResult as? Array<[String: Any]> else {
                                return
                            }
                            if let dicInfo = result.first {
                                let updateVersion = dicInfo["version"]
                                guard let newVersion = updateVersion as? NSNumber else {
                                    return
                                }
                                let strNewVersion = newVersion.toFloatString
                                let modelVersion = ModelAppVersion.find("appVersion == %@", args: strNewVersion)
                                guard let appVersion = modelVersion as? ModelAppVersion else {
                                    return
                                }
                                let paramVersionKey = "appVersion\(strNewVersion)"
                                let modelParams = ModelParams.find("name == %@", args: paramVersionKey) as? ModelParams
                                if kAppVersion != strNewVersion && modelParams == nil  {
                                    let trackViewUrl = dicInfo["trackViewUrl"] as! String
                                    ZAlertView.showAlert(appVersion.title!, appVersion.content!, [kLocalLaterUpdating, kLocalNoLongerUpdating], kLocalRightNowUpdating, { (btnIndex) in
                                        switch btnIndex {
                                        case 0: //马上更新
                                            let url = URL(string: trackViewUrl)!
                                            UIApplication.shared.openURL(url)
                                            break
                                        case 1: //不再提示
                                            let modelP = ModelParams.create(paramVersionKey, value: newVersion.toFloatString)
                                            let _ = modelP.save()
                                            break
                                        case 2: //稍后更新
                                            break
                                        default:
                                            break
                                        }
                                    })
                                }
                            }
                        } catch let error {
                            ZLog(error)
                        }
                    }
                })
                task.resume()
            } catch let error {
                ZLog(error)
            }
        }
    }
    ///配置本地数据库
    private func setConfigDataBase() {
        DBHelper.sharedRecord.modelName = "CompanyProject"
        DBHelper.sharedRecord.databaseName = "CompanyProject.SQLite"
        let _ = DBHelper.sharedRecord.persistentStoreCoordinator
        DBHelper.generateRelationships = true
    }
    ///更新本地用户信息
    private func setConfigUserInfo () {
        UserSetting.reload()
        PathManager.createFileDir()
    }
    ///添加本地通知
    private func addLocationNotification(_ userInfo: [AnyHashable : Any]) {
        if UIApplication.shared.applicationState == .active {
            UIApplication.shared.cancelAllLocalNotifications()
            // 初始化一个通知
            let localNotification = UILocalNotification()
            // 通知上显示的主题内容
            localNotification.alertBody = (userInfo["aps"] as! [AnyHashable : Any])["alert"] as? String
            // 收到通知时播放的声音，默认消息声音
            localNotification.soundName = UILocalNotificationDefaultSoundName
            // 通知上绑定的其他信息，为键值对
            localNotification.userInfo = userInfo
            // 设置重复的次数
            localNotification.repeatInterval = NSCalendar.Unit(rawValue: 0)
            // 每隔2秒发送一个通知
            localNotification.fireDate = Date(timeIntervalSinceNow: 2)
            // 添加通知到系统队列中，系统会在指定的时间触发
            UIApplication.shared.scheduleLocalNotification(localNotification)
        }
    }
    ///设置UMeng别名
    private func setUMengAlias() {
        let userId = kLoginUserId
        let md5UserId = userId.MD5
        ZLog("setPushAccount userId: \(userId), md5UserId: \(String(describing: md5UserId))")
        UMessage.setAlias(md5UserId, type: keyUMengTypeKey) { (responseObject, error) in
            ZLog(responseObject)
        }
    }
    ///删除UMeng别名
    private func removeUMengAlias() {
        let userId = kLoginUserId
        let md5UserId = userId.MD5
        ZLog("setPushAccount userId: \(userId), md5UserId: \(String(describing: md5UserId))")
        UMessage.removeAlias(md5UserId, type: keyUMengTypeKey) { (responseObject, error) in
            ZLog(responseObject)
        }
    }
    ///设置推送账号
    private func setPushAccount() {
        if self.devTokenStr != nil && self.devTokenStr!.length > 0 {
            if UserSetting.getAutoLogin() {
                self.setUMengAlias()
            } else {
                self.removeUMengAlias()
            }
        }
    }
    
    // MARK: - PublicMethod
    
    public class func app() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    public class func getVCWithIdentifier(_ identifier: String) -> UIViewController? {
        return AppDelegate.app().storyBoard?.instantiateViewController(withIdentifier: identifier)
    }
    public class func getRootVC() -> ZRootViewController {
        return AppDelegate.app().storyBoard?.instantiateViewController(withIdentifier: "VCRootMainSID") as! ZRootViewController
    }
    public class func getMainVC() -> ZMainViewController {
        return AppDelegate.app().storyBoard?.instantiateViewController(withIdentifier: "VCMainSID") as! ZMainViewController
    }
    ///删除App数量
    public func clearApplicationIcon() {
        UIApplication.shared.applicationIconBadgeNumber = 1
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    ///更新App服务器配置信息
    public static func setRefreshAppConfig() {
        DataApi.shared.getAppVersion(kAppVersion, { (currentVersion, newVersion) in
            if let currentVersion = currentVersion {
                AppDelegate.app().isCheckVersion = true
                AppDelegate.app().isAppAudit = currentVersion.appStatus == 0
                NotificationCenter.default.post(name: keyNotificationAppAuditStatusChange, object: currentVersion)
            }
            if let newVersion = newVersion {
                ModelAppVersion.all().forEach({ (model) in
                    model.delete()
                })
                let _ = newVersion.save()
            }
        }) { (message) in
            
        }
    }
    /// 登录
    public class func loginin(_ user: ModelUser) {
        UserSetting.login(user)
        AppDelegate.app().setUMengAlias()
        NotificationCenter.default.post(name: keyNotificationNameLoginChange, object: nil)
        NotificationCenter.default.post(name: keyNotificationAppNumberChange, object: nil)
    }
    /// 注销
    public class func loginout() {
        AppDelegate.app().removeUMengAlias()
        UserSetting.del()
        NotificationCenter.default.post(name: keyNotificationNameLoginChange, object: nil)
        NotificationCenter.default.post(name: keyNotificationAppNumberChange, object: nil)
    }
}

