//
//  AuthAPI.swift
//  Medium-Playground
//
//  Created by WU CHIH WEI on 2019/8/22.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

enum AuthAPI: LKRequest {
    
    case signIn
    
    var baseURL: String {
        
        switch self {
            
        case .signIn:
            
            guard let authURL = Bundle.main.infoDictionary?[Constant.Auth.authURL] as? String else {
                
                fatalError()
            }
            
            return authURL
        }
    }
    
    var headers: [String : String] {
        
        switch self {
            
        case .signIn:
            
            return [LKHTTPHeaderField.contentType.rawValue: LKHTTPHeaderValue.formData.rawValue]
        }
    }
    
    var body: Data? {
        
        switch self {
            
        case .signIn:
            
            guard
                let path = Bundle.main.path(forResource: Constant.Auth.kkBox, ofType: Constant.Auth.plist),
                let dict = NSDictionary(contentsOfFile: path),
                let body = dict as? [String: String]
            else {
                    return nil
            }
            
            return FormDataHandler.formString(params: body).data(using: .utf8)
        }
    }
    
    var method: String {
        
        switch self {
            
        case .signIn:
            
            return LKHTTPMethod.post.rawValue
        }
    }
    
    var endPoint: String {
        
        switch self {
            
        case .signIn:
            
            return String.empty
        }
    }
    
}
