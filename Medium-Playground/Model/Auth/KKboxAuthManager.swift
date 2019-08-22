//
//  KKboxAuthManager.swift
//  Medium-Playground
//
//  Created by WU CHIH WEI on 2019/8/22.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

class KKboxAuthManager {
    
    static func signIn(completion: @escaping (Result<Void, Error>) -> Void) {
        
        HTTPClient.shared.request(
            AuthAPI.signIn,
            completion: { result in
                
                switch result{
                    
                case .success(let data):
                    
                    do {
                        
                        let user = try JSONDecoder().decode(User.self, from: data)
                        
                        KeyChainManager.shared.token = user.tokenType + " " + user.accessToken
                        
                        completion(Result.success(()))
                        
                    } catch {
                        
                        completion(Result.failure(error))
                    }
                    
                case .failure(let error):
                    
                    completion(Result.failure(error))
                }
            }
        )
        
    }
}
