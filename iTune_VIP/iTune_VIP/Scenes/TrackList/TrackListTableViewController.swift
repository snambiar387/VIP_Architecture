//
//  TrackListTableViewController.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import UIKit

final class TrackListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    var tracks: [TrackList.Fetch.ViewModel] = [] {
        didSet{
            tableView.reloadData()
        }
    }

    var interactor: TrackListBusinessLogic!  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        fetchTracksOf("Akon")
    }
    
    private func setUp() {
        
        let presenter = TrackListPresenter()
        presenter.view = self
        
        //let memStore = MemStore() //stub for testing
        let networkStore = TrackNetworkStore()
        interactor = TrackListInteractor(store: networkStore, presenter: presenter)
    }

    private func fetchTracksOf(_ artistName: String) {
        interactor.fetchAllTracks(for: TrackList.Fetch.Request(artistName: artistName))
    }

    // MARK: - Table view data source
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let track = tracks[indexPath.row]
        
        cell.textLabel?.text = track.trackName
        cell.detailTextLabel?.text = track.artistName

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}


extension TrackListTableViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("ended")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
        fetchTracksOf(searchText)
    }
}

extension TrackListTableViewController: TrackListDisplayLogic {
    
    func didFinishFetching(tracks: [TrackList.Fetch.ViewModel]) {
        self.tracks = tracks
    }
    
    func displayError(_ error: Error) {
       
        showSimpleAlertWith(title: "Error", message: error.localizedDescription)
    }
}

extension TrackListTableViewController: ActivityIndicatorLoadable {
}
