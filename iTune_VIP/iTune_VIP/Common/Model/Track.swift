//
//  Track.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import Foundation

struct Track: Codable {
    
    let wrapperType: String
    let kind: String
    let artistName: String
    let trackId: Int
    let collectionName: String
    let trackName: String
    let trackViewUrl: String
    let previewUrl: String
}

struct TrackListResponse: Codable {
    
    let resultCount: Int
    let results: [Track]
}

struct TrackListRequest: ResourceRequest {
    
    //https://itunes.apple.com/search?term=jack+johnson&limit=25
    //https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo
    
    var baseURL: String { return "https://itunes.apple.com/search" }
    
    var path: String { return "" }
    
    var paramter: Parameter? { return ["term" : "jack+johnson"] }
}
