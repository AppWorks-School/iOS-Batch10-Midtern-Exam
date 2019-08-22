//
//  PlayList.swift
//  Medium-Playground
//
//  Created by WU CHIH WEI on 2019/8/12.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import Foundation

struct PlayList: Codable {
    
    var data: [Track]?
    
    var paging: Paging
}

struct Track: Codable {
    
    let id: String
    
    let name: String
    
    let url: String
    
    let album: Album
    
    var isLiked = false
    
    enum CodingKeys: String, CodingKey {
        
        case id, name, url, album
    }
}

struct Album: Codable {
    
    let releaseDate: String
    
    let images: [KKImage]
    
    let artist: Artist
    
    enum CodingKeys: String, CodingKey {
        
        case releaseDate = "release_date"
        
        case images, artist
    }
}

struct Artist: Codable {
    
    let name: String
    
    let images: [KKImage]
}

struct KKImage: Codable {
    
    let height: Int
    
    let width: Int
    
    let url: String
}

struct Paging: Codable {
    
    var offset: Int?
}
