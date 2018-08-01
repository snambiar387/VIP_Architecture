//
//  TrackListInteractor.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import Foundation

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
