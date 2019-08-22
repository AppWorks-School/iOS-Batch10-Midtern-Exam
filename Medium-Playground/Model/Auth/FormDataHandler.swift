//
//  FormDataHandler.swift
//  Medium-Playground
//
//  Created by WU CHIH WEI on 2019/8/22.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

class FormDataHandler {
    
    static func formString(params: [String: String]) -> String {
        
        var data: [String] = []
        
        for (key, value) in params {
            
            data.append(key + "=" + value)
        }
        
        return data.joined(separator: "&")
    }
}
