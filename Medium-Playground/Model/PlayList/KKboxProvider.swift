//
//  KKboxProvider.swift
//  Medium-Playground
//
//  Created by WU CHIH WEI on 2019/8/12.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

class KKboxProvider {
    
    static func fetchNewHitsPlaylist(
        _ id: String,
        offset: String,
        completion: @escaping (Result<PlayList, Error>) -> Void
    ) {
        
        HTTPClient
            .shared
            .request(PlayListAPI.playListTracks(playListID: id, offset: offset),
            completion: { result in
            
                switch result{
                    
                case .success(let data):
                
                    do {
                    
                        let playList = try JSONDecoder().decode(PlayList.self, from: data)

                        DispatchQueue.main.async {
                            
                            completion(Result.success(playList))
                        }

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
