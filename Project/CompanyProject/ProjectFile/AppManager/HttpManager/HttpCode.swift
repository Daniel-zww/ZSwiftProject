//
//  HttpCode.swift
//  CompanyProject
//
//  Created by Daniel on 29/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

class HttpCode: NSObject {
    /**
     *  自定义 错误码
     */
    open static let kSNSReturnSuccess = 1000
    open static let kSNSReturnSuccessText = ZLocalizedString("成功")
    
    open static let kSNSReturnNotBalance = 1009
    open static let kSNSReturnNotBalanceText = ZLocalizedString("余额不足")
    
    open static let kSNSReturnServerDefaultText = ZLocalizedString("网络连接错误[10000]")
    
    open static let kSNSReturnServerDataError = 10001
    open static let kSNSReturnServerDataErrorText  = ZLocalizedString("请求数据错误[10001]")
    
    open static let kSNSReturnServerDecryptDataError = 10002
    open static let kSNSReturnServerDecryptDataErrorText  = ZLocalizedString("请求处理错误[10002]")
    
    open static let kSNSReturnServerTokenExpired = 2000
    open static let kSNSReturnServerTokenExpiredText  = ZLocalizedString("登录已过期[2000]")
    
    
    /**
     *  Wechat 错误码
     */
    open static let kSNSReturnWechat40001 = 40001
    open static let kSNSReturnWechat40001Text = ZLocalizedString("不合法的调用凭证")
    open static let kSNSReturnWechat40002 = 40002
    open static let kSNSReturnWechat40002Text = ZLocalizedString("不合法的granttype")
    open static let kSNSReturnWechat40003 = 40003
    open static let kSNSReturnWechat40003Text = ZLocalizedString("不合法的OpenID")
    open static let kSNSReturnWechat40004 = 40004
    open static let kSNSReturnWechat40004Text = ZLocalizedString("不合法的媒体文件类型")
    open static let kSNSReturnWechat40007 = 40007
    open static let kSNSReturnWechat40007Text = ZLocalizedString("不合法的mediaid")
    open static let kSNSReturnWechat40008 = 40008
    open static let kSNSReturnWechat40008Text = ZLocalizedString("不合法的messagetype")
    open static let kSNSReturnWechat40009 = 40009
    open static let kSNSReturnWechat40009Text = ZLocalizedString("不合法的图片大小")
    open static let kSNSReturnWechat40010 = 40010
    open static let kSNSReturnWechat40010Text = ZLocalizedString("不合法的语音大小")
    open static let kSNSReturnWechat40011 = 40011
    open static let kSNSReturnWechat40011Text = ZLocalizedString("不合法的视频大小")
    open static let kSNSReturnWechat40012 = 40012
    open static let kSNSReturnWechat40012Text = ZLocalizedString("不合法的缩略图大小")
    open static let kSNSReturnWechat40013 = 40013
    open static let kSNSReturnWechat40013Text = ZLocalizedString("不合法的AppID")
    open static let kSNSReturnWechat40014 = 40014
    open static let kSNSReturnWechat40014Text = ZLocalizedString("不合法的accesstoken")
    open static let kSNSReturnWechat40015 = 40015
    open static let kSNSReturnWechat40015Text = ZLocalizedString("不合法的菜单类型")
    open static let kSNSReturnWechat40016 = 40016
    open static let kSNSReturnWechat40016Text = ZLocalizedString("不合法的菜单按钮个数")
    open static let kSNSReturnWechat40017 = 40017
    open static let kSNSReturnWechat40017Text = ZLocalizedString("不合法的按钮类型")
    open static let kSNSReturnWechat40018 = 40018
    open static let kSNSReturnWechat40018Text = ZLocalizedString("不合法的按钮名称长度")
    open static let kSNSReturnWechat40019 = 40019
    open static let kSNSReturnWechat40019Text = ZLocalizedString("不合法的按钮KEY长度")
    open static let kSNSReturnWechat40020 = 40020
    open static let kSNSReturnWechat40020Text = ZLocalizedString("不合法的URL长度")
    open static let kSNSReturnWechat40023 = 40023
    open static let kSNSReturnWechat40023Text = ZLocalizedString("不合法的子菜单按钮个数")
    open static let kSNSReturnWechat40024 = 40024
    open static let kSNSReturnWechat40024Text = ZLocalizedString("不合法的子菜单类型")
    open static let kSNSReturnWechat40025 = 40025
    open static let kSNSReturnWechat40025Text = ZLocalizedString("不合法的子菜单按钮名称长度")
    open static let kSNSReturnWechat40026 = 40026
    open static let kSNSReturnWechat40026Text = ZLocalizedString("不合法的子菜单按钮KEY长度")
    open static let kSNSReturnWechat40027 = 40027
    open static let kSNSReturnWechat40027Text = ZLocalizedString("不合法的子菜单按钮URL长度")
    open static let kSNSReturnWechat40029 = 40029
    open static let kSNSReturnWechat40029Text = ZLocalizedString("不合法或已过期的CODE")
    open static let kSNSReturnWechat40030 = 40030
    open static let kSNSReturnWechat40030Text = ZLocalizedString("不合法的refreshtoken")
    open static let kSNSReturnWechat40036 = 40036
    open static let kSNSReturnWechat40036Text = ZLocalizedString("不合法的templateid长度")
    open static let kSNSReturnWechat40037 = 40037
    open static let kSNSReturnWechat40037Text = ZLocalizedString("不合法的templateid")
    open static let kSNSReturnWechat40039 = 40039
    open static let kSNSReturnWechat40039Text = ZLocalizedString("不合法的URL长度")
    open static let kSNSReturnWechat40048 = 40048
    open static let kSNSReturnWechat40048Text = ZLocalizedString("不合法的URL域名")
    open static let kSNSReturnWechat40054 = 40054
    open static let kSNSReturnWechat40054Text = ZLocalizedString("不合法的子菜单按钮URL域名")
    open static let kSNSReturnWechat40055 = 40055
    open static let kSNSReturnWechat40055Text = ZLocalizedString("不合法的菜单按钮URL域名")
    open static let kSNSReturnWechat40066 = 40066
    open static let kSNSReturnWechat40066Text = ZLocalizedString("不合法的URL")
    open static let kSNSReturnWechat41001 = 41001
    open static let kSNSReturnWechat41001Text = ZLocalizedString("缺失accesstoken参数")
    open static let kSNSReturnWechat41002 = 41002
    open static let kSNSReturnWechat41002Text = ZLocalizedString("缺失appid参数")
    open static let kSNSReturnWechat41003 = 41003
    open static let kSNSReturnWechat41003Text = ZLocalizedString("缺失refreshtoken参数")
    open static let kSNSReturnWechat41004 = 41004
    open static let kSNSReturnWechat41004Text = ZLocalizedString("缺失secret参数")
    open static let kSNSReturnWechat41005 = 41005
    open static let kSNSReturnWechat41005Text = ZLocalizedString("缺失二进制媒体文件")
    open static let kSNSReturnWechat41006 = 41006
    open static let kSNSReturnWechat41006Text = ZLocalizedString("缺失mediaid参数")
    open static let kSNSReturnWechat41007 = 41007
    open static let kSNSReturnWechat41007Text = ZLocalizedString("缺失子菜单数据")
    open static let kSNSReturnWechat41008 = 41008
    open static let kSNSReturnWechat41008Text = ZLocalizedString("缺失code参数")
    open static let kSNSReturnWechat41009 = 41009
    open static let kSNSReturnWechat41009Text = ZLocalizedString("缺失openid参数")
    open static let kSNSReturnWechat41010 = 41010
    open static let kSNSReturnWechat41010Text = ZLocalizedString("缺失url参数")
    open static let kSNSReturnWechat42001 = 42001
    open static let kSNSReturnWechat42001Text = ZLocalizedString("accesstoken超时")
    open static let kSNSReturnWechat42002 = 42002
    open static let kSNSReturnWechat42002Text = ZLocalizedString("refreshtoken超时")
    open static let kSNSReturnWechat42003 = 42003
    open static let kSNSReturnWechat42003Text = ZLocalizedString("code超时")
    open static let kSNSReturnWechat43001 = 43001
    open static let kSNSReturnWechat43001Text = ZLocalizedString("需要使用GET方法请求")
    open static let kSNSReturnWechat43002 = 43002
    open static let kSNSReturnWechat43002Text = ZLocalizedString("需要使用POST方法请求")
    open static let kSNSReturnWechat43003 = 43003
    open static let kSNSReturnWechat43003Text = ZLocalizedString("需要使用HTTPS")
    open static let kSNSReturnWechat43004 = 43004
    open static let kSNSReturnWechat43004Text = ZLocalizedString("需要订阅关系")
    open static let kSNSReturnWechat44001 = 44001
    open static let kSNSReturnWechat44001Text = ZLocalizedString("空白的二进制数据")
    open static let kSNSReturnWechat44002 = 44002
    open static let kSNSReturnWechat44002Text = ZLocalizedString("空白的POST数据")
    open static let kSNSReturnWechat44003 = 44003
    open static let kSNSReturnWechat44003Text = ZLocalizedString("空白的news数据")
    open static let kSNSReturnWechat44004 = 44004
    open static let kSNSReturnWechat44004Text = ZLocalizedString("空白的内容")
    open static let kSNSReturnWechat44005 = 44005
    open static let kSNSReturnWechat44005Text = ZLocalizedString("空白的列表")
    open static let kSNSReturnWechat45001 = 45001
    open static let kSNSReturnWechat45001Text = ZLocalizedString("二进制文件超过限制")
    open static let kSNSReturnWechat45002 = 45002
    open static let kSNSReturnWechat45002Text = ZLocalizedString("content参数超过限制")
    open static let kSNSReturnWechat45003 = 45003
    open static let kSNSReturnWechat45003Text = ZLocalizedString("title参数超过限制")
    open static let kSNSReturnWechat45004 = 45004
    open static let kSNSReturnWechat45004Text = ZLocalizedString("description参数超过限制")
    open static let kSNSReturnWechat45005 = 45005
    open static let kSNSReturnWechat45005Text = ZLocalizedString("URLl参数长度超过限制")
    open static let kSNSReturnWechat45006 = 45006
    open static let kSNSReturnWechat45006Text = ZLocalizedString("picurl参数超过限制")
    open static let kSNSReturnWechat45007 = 45007
    open static let kSNSReturnWechat45007Text = ZLocalizedString("播放时间超过限制(语音为60s最大)")
    open static let kSNSReturnWechat45008 = 45008
    open static let kSNSReturnWechat45008Text = ZLocalizedString("article参数超过限制")
    open static let kSNSReturnWechat45009 = 45009
    open static let kSNSReturnWechat45009Text = ZLocalizedString("接口调动频率超过限制")
    open static let kSNSReturnWechat45010 = 45010
    open static let kSNSReturnWechat45010Text = ZLocalizedString("建立菜单被限制")
    open static let kSNSReturnWechat45011 = 45011
    open static let kSNSReturnWechat45011Text = ZLocalizedString("频率限制")
    open static let kSNSReturnWechat45012 = 45012
    open static let kSNSReturnWechat45012Text = ZLocalizedString("模板大小超过限制")
    open static let kSNSReturnWechat45016 = 45016
    open static let kSNSReturnWechat45016Text = ZLocalizedString("不能修改默认组")
    open static let kSNSReturnWechat45017 = 45017
    open static let kSNSReturnWechat45017Text = ZLocalizedString("修改组名过长")
    open static let kSNSReturnWechat45018 = 45018
    open static let kSNSReturnWechat45018Text = ZLocalizedString("组数量过多")
    open static let kSNSReturnWechat50001 = 50001
    open static let kSNSReturnWechat50001Text = ZLocalizedString("接口未授权")
    
    /**
     *  ASI 错误码
     */
    open static let kSNSReturnServer1 = 1
    open static let kSNSReturnServer1Text = ZLocalizedString("无法连接服务器[1]")
    open static let kSNSReturnServer2 = 2
    open static let kSNSReturnServer2Text = ZLocalizedString("连接服务器超时[2]")
    open static let kSNSReturnServer3 = 3
    open static let kSNSReturnServer3Text = ZLocalizedString("服务器认证失败[3]")
    open static let kSNSReturnServer4 = 4
    open static let kSNSReturnServer4Text = ZLocalizedString("服务器取消请求[4]")
    open static let kSNSReturnServer5 = 5
    open static let kSNSReturnServer5Text = ZLocalizedString("请求服务器地址无效[5]")
    open static let kSNSReturnServer6 = 6
    open static let kSNSReturnServer6Text = ZLocalizedString("服务器内部请求错误[6]")
    open static let kSNSReturnServer7 = 7
    open static let kSNSReturnServer7Text = ZLocalizedString("服务器内部证书错误[7]")
    open static let kSNSReturnServer8 = 8
    open static let kSNSReturnServer8Text = ZLocalizedString("文件上传错误[8]")
    open static let kSNSReturnServer9 = 9
    open static let kSNSReturnServer9Text = ZLocalizedString("重定向次数太多了[9]")
    open static let kSNSReturnServer10 = 10
    open static let kSNSReturnServer10Text = ZLocalizedString("一个未知错误[10]")
    open static let kSNSReturnServer11 = 11
    open static let kSNSReturnServer11Text = ZLocalizedString("文件压缩错误[11]")
    
    /**
     *  AF 错误码
     */
    open static let kSNSReturnServer3840 = 3840
    open static let kSNSReturnServer3840Text = ZLocalizedString("服务器数据错误[3840]")
    
    open static let kSNSReturnServerNSFileLockingError = 255
    open static let kSNSReturnServerNSFileLockingErrorText = ZLocalizedString("文件锁定错误[255]")
    open static let kSNSReturnServerNSFileReadUnknownError = 256
    open static let kSNSReturnServerNSFileReadUnknownErrorText = ZLocalizedString("文件读取未知错误[256]")
    open static let kSNSReturnServerNSFileReadNoPermissionError = 257
    open static let kSNSReturnServerNSFileReadNoPermissionErrorText = ZLocalizedString("文件不允许读取[257]")
    open static let kSNSReturnServerNSFileReadInvalidFileNameError = 258
    open static let kSNSReturnServerNSFileReadInvalidFileNameErrorText = ZLocalizedString("读取无效的文件名错误[258]")
    open static let kSNSReturnServerNSFileReadCorruptFileError = 259
    open static let kSNSReturnServerNSFileReadCorruptFileErrorText = ZLocalizedString("读取损坏的文件错误[259]")
    open static let kSNSReturnServerNSFileReadNoSuchFileError = 260
    open static let kSNSReturnServerNSFileReadNoSuchFileErrorText = ZLocalizedString("读没有这样的文件错误[260]")
    open static let kSNSReturnServerNSFileReadInapplicableStringEncodingError = 261
    open static let kSNSReturnServerNSFileReadInapplicableStringEncodingErrorText = ZLocalizedString("不读字符串编码错误[261]")
    open static let kSNSReturnServerNSFileReadUnsupportedSchemeError = 262
    open static let kSNSReturnServerNSFileReadUnsupportedSchemeErrorText = ZLocalizedString("读取不支持的计划错误[262]")
    open static let kSNSReturnServerNSFileReadTooLargeError = 263
    open static let kSNSReturnServerNSFileReadTooLargeErrorText = ZLocalizedString("读取太大错误[263]")
    open static let kSNSReturnServerNSFileReadUnknownStringEncodingError = 264
    open static let kSNSReturnServerNSFileReadUnknownStringEncodingErrorText = ZLocalizedString("读取未知字符串编码错误[264]")
    
    open static let kSNSReturnServerNSFileWriteUnknownError = 512
    open static let kSNSReturnServerNSFileWriteUnknownErrorText = ZLocalizedString("写入未知错误[512]")
    open static let kSNSReturnServerNSFileWriteNoPermissionError = 513
    open static let kSNSReturnServerNSFileWriteNoPermissionErrorText = ZLocalizedString("写入不允许错误[513]")
    open static let kSNSReturnServerNSFileWriteInvalidFileNameError = 514
    open static let kSNSReturnServerNSFileWriteInvalidFileNameErrorText = ZLocalizedString("写入无效的文件名错误[514]")
    open static let kSNSReturnServerNSFileWriteInapplicableStringEncodingError = 517
    open static let kSNSReturnServerNSFileWriteInapplicableStringEncodingErrorText = ZLocalizedString("不写字符串编码错误[517]")
    open static let kSNSReturnServerNSFileWriteUnsupportedSchemeError = 518
    open static let kSNSReturnServerNSFileWriteUnsupportedSchemeErrorText = ZLocalizedString("写入不支持的计划错误[518]")
    
    open static let kSNSReturnServerNSFileWriteOutOfSpaceError = 640
    open static let kSNSReturnServerNSFileWriteOutOfSpaceErrorText = ZLocalizedString("写出空间误差[640]")
    open static let kSNSReturnServerNSFileWriteVolumeReadOnlyError = 642
    open static let kSNSReturnServerNSFileWriteVolumeReadOnlyErrorText = ZLocalizedString("写卷只读错误[642]")
    open static let kSNSReturnServerNSKeyValueValidationError = 1024
    open static let kSNSReturnServerNSKeyValueValidationErrorText = ZLocalizedString("值验证错误[1024]")
    open static let kSNSReturnServerNSFormattingError = 2048
    open static let kSNSReturnServerNSFormattingErrorText = ZLocalizedString("格式错误[2048]")
    open static let kSNSReturnServerNSUserCancelledError = 3072
    open static let kSNSReturnServerNSUserCancelledErrorText = ZLocalizedString("用户取消错误[3072]")
    
    open static let kSNSReturnServerNSPropertyListReadUnknownVersionError = 3841
    open static let kSNSReturnServerNSPropertyListReadUnknownVersionErrorText = ZLocalizedString("属性列表读取未知版本错误[3841]")
    open static let kSNSReturnServerNSPropertyListReadStreamError = 3842
    open static let kSNSReturnServerNSPropertyListReadStreamErrorText = ZLocalizedString("属性列表读取流错误[3842]")
    open static let kSNSReturnServerNSPropertyListWriteStreamError = 3851
    open static let kSNSReturnServerNSPropertyListWriteStreamErrorText = ZLocalizedString("属性列表写入流错误[3851]")
    open static let kSNSReturnServerNSPropertyListErrorMaximum = 4095
    open static let kSNSReturnServerNSPropertyListErrorMaximumText = ZLocalizedString("属性列表错误最大值[4095]")
    
    open static let kSNSReturnServerNSExecutableNotLoadableError = 3584
    open static let kSNSReturnServerNSExecutableNotLoadableErrorText = ZLocalizedString("可执行文件没有加载错误[3584]")
    open static let kSNSReturnServerNSExecutableArchitectureMismatchError = 3585
    open static let kSNSReturnServerNSExecutableArchitectureMismatchErrorText = ZLocalizedString("可执行架构不匹配错误[3585]")
    open static let kSNSReturnServerNSExecutableRuntimeMismatchError = 3586
    open static let kSNSReturnServerNSExecutableRuntimeMismatchErrorText = ZLocalizedString("可执行的运行时不匹配错误[3586]")
    open static let kSNSReturnServerNSExecutableLoadError = 3587
    open static let kSNSReturnServerNSExecutableLoadErrorText = ZLocalizedString("可执行文件加载错误[3587]")
    open static let kSNSReturnServerNSExecutableLinkError = 3588
    open static let kSNSReturnServerNSExecutableLinkErrorText = ZLocalizedString("可执行链接错误[3588]")
    open static let kSNSReturnServerNSExecutableErrorMaximum = 3839
    open static let kSNSReturnServerNSExecutableErrorMaximumText = ZLocalizedString("执行误差最大[3839]")
    
    /**
     *  2xx  成功
     */
    open static let kSNSReturn200 = 200
    open static let kSNSReturn200Text = ZLocalizedString("请求已完成[200]")
    open static let kSNSReturn201 = 201
    open static let kSNSReturn201Text = ZLocalizedString("紧接 POST 命令[201]")
    open static let kSNSReturn202 = 202
    open static let kSNSReturn202Text = ZLocalizedString("已接受用于处理,但处理尚未完成[202]")
    open static let kSNSReturn203 = 203
    open static let kSNSReturn203Text = ZLocalizedString("部分信息-返回的信息只是一部分[203]")
    open static let kSNSReturn204 = 204
    open static let kSNSReturn204Text = ZLocalizedString("无响应-已接收请求,但不存在要回送的信息[204]")
    /**
     *  3xx  重定向
     */
    open static let kSNSReturn301 = 301
    open static let kSNSReturn301Text = ZLocalizedString("已移动-请求的数据具有新的位置且更改是永久的[301]")
    open static let kSNSReturn302 = 302
    open static let kSNSReturn302Text = ZLocalizedString("已找到-请求的数据临时具有不同 URI[302]")
    open static let kSNSReturn303 = 303
    open static let kSNSReturn303Text = ZLocalizedString("请参阅其它-可在另一 URI 下找到对请求的响应,且应使用 GET 方法检索此响应[303]")
    open static let kSNSReturn304 = 304
    open static let kSNSReturn304Text = ZLocalizedString("未修改-未按预期修改文档[304]")
    open static let kSNSReturn305 = 305
    open static let kSNSReturn305Text = ZLocalizedString("使用代理-必须通过位置字段中提供的代理来访问请求的资源[305]")
    open static let kSNSReturn306 = 306
    open static let kSNSReturn306Text = ZLocalizedString("未使用-不再使用,保留此代码以便将来使用[406]")
    /**
     *  4xx  客户机中出现的错误
     */
    open static let kSNSReturn400 = 400
    open static let kSNSReturn400Text = ZLocalizedString("错误请求-请求中有语法问题,或不能满足请求[400]")
    open static let kSNSReturn401 = 401
    open static let kSNSReturn401Text = ZLocalizedString("未授权-未授权客户机访问数据[401]")
    open static let kSNSReturn402 = 402
    open static let kSNSReturn402Text = ZLocalizedString("需要付款-表示计费系统已有效[402]")
    open static let kSNSReturn403 = 403
    open static let kSNSReturn403Text = ZLocalizedString("禁止访问-即使有授权也不需要访问[403]")
    open static let kSNSReturn404 = 404
    open static let kSNSReturn404Text = ZLocalizedString("找不到服务器给定的资源,文档不存在[404]")
    open static let kSNSReturn407 = 407
    open static let kSNSReturn407Text = ZLocalizedString("代理认证请求-客户机首先必须使用代理认证自身[407]")
    open static let kSNSReturn415 = 415
    open static let kSNSReturn415Text = ZLocalizedString("介质类型不受支持-服务器拒绝服务请求,因为不支持请求实体的格式[415]")
    /**
     *  5xx  服务器中出现的错误
     */
    open static let kSNSReturn500 = 500
    open static let kSNSReturn500Text = ZLocalizedString("内部服务器错误[500]")
    open static let kSNSReturn501 = 501
    open static let kSNSReturn501Text = ZLocalizedString("未执行-服务器不支持请求的工具[501]")
    open static let kSNSReturn502 = 502
    open static let kSNSReturn502Text = ZLocalizedString("网关错误-服务器接收到来自上游服务器的无效响应[502]")
    open static let kSNSReturn503 = 503
    open static let kSNSReturn503Text = ZLocalizedString("无法获得服务-由于临时过载或维护,服务器无法处理请求[503]")
   
}
