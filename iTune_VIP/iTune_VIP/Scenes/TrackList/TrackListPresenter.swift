//
//  TrackListPresenter.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import Foundation

class TrackListPresenter: TrackListPresentationLogic {
    
    typealias TrackListView = TrackListDisplayLogic & ActivityIndicatorLoadable
    
    weak var view: TrackListView?
    
    func presentFetchedTracks(response: TrackList.Fetch.Response) {
        
        let tracks = response.tracks.map { TrackList.Fetch.ViewModel(artistName: $0.artistName, trackName: $0.trackName) }
        
        view?.didFinishFetching(tracks: tracks)
    }
    
    func presentError(_ error: Error) {
        
        view?.displayError(error)
    }
}

extension TrackListPresenter: ActivityIndicatorLoadable {
    
    func showActivityIndicator() {
        view?.showActivityIndicator()
    }
    
    func hideActivityIndicator() {
        view?.hideActivityIndicator()
    }
}
