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
            
        }).resume()
    }
    
    func getPostString(params: [String: String]) -> String {
        
        var data: [String] = []
        
        for (key, value) in params {
            
            data.append(key + "=" + value)
        }
        
        return data.joined(separator: "&")
    }
    
    func fetchNewHitsPlaylist(
        _ id: String,
        completion: @escaping (Result<PlayList, Error>) -> Void
    ) {
        
        guard let user = user else { return }
        
        let url = URL(string: "https://api.kkbox.com/v1.1/new-hits-playlists/\(id)/tracks?territory=TW&limit=10")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = [ "Authorization" : user.tokenType + " " + user.accessToken ]
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            print(httpResponse.statusCode)
            
            let playList = try! JSONDecoder().decode(PlayList.self, from: data!)
            
            completion(Result.success(playList))
            
            let jsonData = try! JSONEncoder().encode(playList)
            
            let json = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            
            print(json)
            
            print(playList)
            
        }).resume()
    }
}
