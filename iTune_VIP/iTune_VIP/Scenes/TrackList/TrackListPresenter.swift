//
//  TrackListPresenter.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import Foundation

class TrackListPresenter: TrackListPresentationLogic {
    
    weak var view: TrackListDisplayLogic?
    
    func presentFetchedTracks(response: TrackList.FetchAll.Response) {
        
        let tracks = response.tracks.map { TrackList.FetchAll.ViewModel(artistName: $0.artistName, trackName: $0.trackName) }
        
        view?.didFinishFetching(tracks: tracks)
    }
}
