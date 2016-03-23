//
//  NSObject_Extension.swift
//
//  Created by binaryboy on 3/16/16.
//  Copyright © 2016 AhmedHamdy. All rights reserved.
//

import Foundation

extension NSObject {
    class func pluginDidLoad(bundle: NSBundle) {
        let appName = NSBundle.mainBundle().infoDictionary?["CFBundleName"] as? NSString
        if appName == "Xcode" {
        	if sharedPlugin == nil {
        		sharedPlugin = RainyCode(bundle: bundle)
        	}
        }
    }
}

