//
//  PlayListAPI.swift
//  Medium-Playground
//
//  Created by WU CHIH WEI on 2019/8/22.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

enum PlayListAPI: LKRequest {
    
    case playListTracks(playListID: String, offset: String)
    
    var baseURL: String {
        
        switch self {
            
        case .playListTracks(let playListID, _):
            
            guard let tracksURL = Bundle.main.infoDictionary?[Constant.Auth.playListURL] as? String else {
                
                fatalError()
            }
            
            return tracksURL + playListID
        }
    }
    
    var headers: [String : String] {
        
        switch self {
            
        case .playListTracks:
            
            guard let token = KeyChainManager.shared.token else { return [:] }
            
            return [LKHTTPHeaderField.auth.rawValue: token]
        }
    }
    
    var body: Data? {
        
        switch self {
            
        case .playListTracks: return nil
            
        }
    }
    
    var method: String {
        
        switch self {
            
        case .playListTracks:
            
            return LKHTTPMethod.get.rawValue
        }
    }
    
    var endPoint: String {
        
        switch self {
            
        case .playListTracks:
            
            return "/tracks"
        }
    }
    
    var queryString: [String : String] {
        
        switch self {
            
        case .playListTracks(_, let offset):
            
            return [
                "territory": "TW",
                "limit": "20",
                "offset": offset
            ]
        }
    }
    
}
