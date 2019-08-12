//
//  KKboxProvider.swift
//  Medium-Playground
//
//  Created by WU CHIH WEI on 2019/8/12.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

class KKboxProvider {
    
    var user: User?
    
    func signIn(completion: @escaping (Result<User, Error>) -> Void) {
        
        guard
            let path = Bundle.main.path(forResource: "KKbox", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let body = dict as? [String: String]
        else {
                return
        }
        
        let url = URL(string: "https://account.kkbox.com/oauth2/token")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
        
        let jsonData = getPostString(params: body).data(using: .utf8)
        
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            let user = try! JSONDecoder().decode(User.self, from: data!)
            
            self?.user = user
            
            completion(Result.success(user))
            
            self?.fetchNewHitsPlaylist("DZrC8m29ciOFY2JAm3")
            
        }).resume()
    }
    
    func getPostString(params: [String: String]) -> String {
        
        var data: [String] = []
        
        for (key, value) in params {
            
            data.append(key + "=" + value)
        }
        
        return data.joined(separator: "&")
    }
}
