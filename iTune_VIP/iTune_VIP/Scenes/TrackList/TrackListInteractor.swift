//
//  TrackListInteractor.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import Foundation


protocol TrackStore {
    
    func loadTracks(for request: TrackList.Fetch.Request, completion: @escaping (Result<[Track]>) -> Void)
}


class TrackListInteractor: TrackListBusinessLogic {
    
    typealias Presenter = TrackListPresentationLogic & ActivityIndicatorLoadable

    
/*
     Store is a worker here to off-load track loading work.
     Now we can have in-memory store(for testing purposes ), a network or core-data store so that interactor doesn't have to concentrate much on how to load data.
     In fact we can have worker for other complex/lengthy independent opearations so that the worker can be reused.
*/
    var store: TrackStore
    var presenter: Presenter
    
    init(store: TrackStore, presenter: Presenter) {
        
        self.store = store
        self.presenter = presenter
    }
    
    private func shouldRequest(_ request: TrackList.Fetch.Request)-> Bool {
        
        return request.artistName.count >= 4
    }
    
    func fetchAllTracks(for request: TrackList.Fetch.Request) {
        
        guard shouldRequest(request) else { return }
        
        presenter.showActivityIndicator()

        store.loadTracks(for: request) {[weak self] (result) in

            guard let strongSelf = self else { return }

            strongSelf.presenter.hideActivityIndicator()

            switch result {
            case .error(let error):
                strongSelf.presenter.presentError(error)

            case .success(let tracks):
                strongSelf.presenter.presentFetchedTracks(response: TrackList.Fetch.Response(tracks: tracks))
            }
        }
    }
}
