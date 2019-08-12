//
//  User.swift
//  Medium-Playground
//
//  Created by WU CHIH WEI on 2019/8/12.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let accessToken: String
    
    let tokenType: String
    
    let expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        
        case accessToken = "access_token"
        
        case tokenType = "token_type"
        
        case expiresIn = "expires_in"
    }
}
