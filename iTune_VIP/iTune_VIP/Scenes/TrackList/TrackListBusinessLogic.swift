//
//  TrackListBusinessLogic.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import Foundation

protocol TrackListBusinessLogic {
    
    func fetchAllTracks(for request: TrackList.FetchAll.Request)
}


protocol TrackListPresentationLogic {
    
    func presentFetchedTracks(response: TrackList.FetchAll.Response)
    
    func presentError(_ error: Error)
    
}

protocol TrackListDisplayLogic: class {
    
    func didFinishFetching(tracks: [TrackList.FetchAll.ViewModel])
    
    func displayError(_ error: Error)
}


/// enum Provides the namespace

enum TrackList {
    enum FetchAll {
       
        struct Request {
            
        }
        
        struct Response {
            let tracks: [Track]
        }
        
        struct ViewModel {
            let artistName: String
            let trackName: String
        }
    }
}
