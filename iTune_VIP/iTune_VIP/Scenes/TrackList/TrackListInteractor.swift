//
//  TrackListInteractor.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import Foundation

enum Result<T> {
    case error(Error)
    case success(T)
}

protocol TrackStore {
    
    func loadAllTracks(completion: @escaping (Result<[Track]>) -> Void)
}


class TrackListInteractor: TrackListBusinessLogic {
    
/*
     Store is a worker here to off-load track loading work.
     Now we can have in-memory store(for testing purposes ), a network or core-data store so that interactor doesn't have to concentrate much on how to load data.
     In fact we can have worker for other complex/lengthy independent opearations so that the worker can be reused.
*/
    let store: TrackStore
    let presenter: TrackListPresentationLogic
    
    init(store: TrackStore, presenter: TrackListPresentationLogic) {
        
        self.store = store
        self.presenter = presenter
    }
    
    func fetchAllTracks(for request: TrackList.FetchAll.Request) {
        
        store.loadAllTracks {[weak self] (result) in
            
            guard let strongSelf = self else { return }
            
            switch result {
            case .error(let error):
                break
                
            case .success(let tracks):
                strongSelf.presenter.presentFetchedTracks(response: TrackList.FetchAll.Response(tracks: tracks))
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
            completion(.success(tracks))
        }
    }
}
