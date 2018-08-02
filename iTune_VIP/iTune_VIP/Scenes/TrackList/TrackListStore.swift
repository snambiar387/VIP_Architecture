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
    
    
    func loadTracks(for request: TrackList.Fetch.Request, completion: @escaping (Result<[Track]>) -> Void) {
       
        let resourceReq = TrackListRequest(artistName: request.artistName)
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
    
    
    func loadTracks(for request: TrackList.Fetch.Request, completion: @escaping (Result<[Track]>) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let track1 = Track(artistName: request.artistName, trackName: "Better Together")
            
            let track2 = Track(artistName: request.artistName, trackName: "Upside Down")
            
            let track3 = Track(artistName: request.artistName, trackName: "Banana Pancakes")
            
            let track4 = Track(artistName: request.artistName, trackName: "Lonely")
            
          
            let tracks = [track1,track2,track3,track4]
            completion(.success(tracks))
            //completion(.error(TrackListError.parse))
        }
    }
}
