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
    public let kApiServerUrl = "http://192.168.3.6:9191/"
    public let kWebServerUrl = "http://192.168.3.6/"
    
#else
    
    //外网正式服务器
    public let kApiServerUrl = "https://www.daniel.com/"
    public let kWebServerUrl = "https://www.daniel.com/"
    
#endif








