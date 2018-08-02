//
//  TrackListStore.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import Foundation

enum TrackListError: String, Error {
    case parse = "Parsing error occured. Please try again later"
    
}

class TrackNetworkStore: TrackStore {
    
    private let webService = WebServiceManager()
    
    func loadAllTracks(completion: @escaping (Result<[Track]>) -> Void) {
        
        let resourceReq = TrackListRequest()
        webService.request(resourceReq) { (result) in
            switch result {
            case .error(let error):
                completion(.error(error))
            case .success(let value):
                do {
                    let response = try JSONDecoder().decode(TrackListResponse.self, from: value)
                    completion(.success(response.results))
                } catch {
                    completion(.error(TrackListError.parse))
                }
            }
        }
    }
}

class MemStore: TrackStore {
    
    func loadAllTracks(completion: @escaping (Result<[Track]>) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let wrapperType = "track"
            let kind = "song"
            let jackJohnson = "Jack Jhonson"
            
            let track1 = Track(wrapperType: wrapperType, kind: kind, artistName: jackJohnson, trackId: 1, collectionName: "", trackName: "Better Together", trackViewUrl: "", previewUrl: "")
            
            let track2 = Track(wrapperType: wrapperType, kind: kind, artistName: jackJohnson, trackId: 2, collectionName: "", trackName: "Upside Down", trackViewUrl: "", previewUrl: "")
            
            let track3 = Track(wrapperType: wrapperType, kind: kind, artistName: jackJohnson, trackId: 3, collectionName: "", trackName: "Banana Pancakes", trackViewUrl: "", previewUrl: "")
            
            let track4 = Track(wrapperType: wrapperType, kind: kind, artistName: "Akon", trackId: 4, collectionName: "", trackName: "Lonely", trackViewUrl: "", previewUrl: "")
            
            let tracks = [track1,track2,track3,track4]
            //completion(.success(tracks))
            completion(.error(TrackListError.parse))
        }
    }
}
