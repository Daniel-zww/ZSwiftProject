//
//  HostManager.swift
//  CompanyProject
//
//  Created by Daniel on 17/03/2017.
//  Copyright © 2017 Z. All rights reserved.
//

import UIKit

#if DEBUG
    
    //局域网服务器
    public let kApiServerUrl = "http://192.168.3.6:9090/"
    public let kWebServerUrl = "http://192.168.3.6/"
    
    //外网测试服务器
    //public let kApiServerUrl = "http://appdev.wutongsx.com/"
    //public let kWebServerUrl = "http://dev.wutongsx.com/"
    
    //外网正式服务器
    //public let kApiServerUrl = "https://appapi.wutongsx.com/"
    //public let kWebServerUrl = "https://www.wutongsx.com/"
    
#else
    
    //外网正式服务器
    public let kApiServerUrl = "https://appapi.wutongsx.com/"
    public let kWebServerUrl = "https://www.wutongsx.com/"
    
#endif








