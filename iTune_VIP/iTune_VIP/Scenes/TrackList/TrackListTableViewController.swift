//
//  TrackListTableViewController.swift
//  iTune_VIP
//
//  Created by sreehari m nambiar on 01/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import UIKit

final class TrackListTableViewController: UITableViewController {
    
    var tracks: [TrackList.FetchAll.ViewModel] = [] {
        didSet{
            tableView.reloadData()
        }
    }

    var interactor: TrackListBusinessLogic!  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        fetchTracks()
    }
    
    private func setUp() {
        
        let presenter = TrackListPresenter()
        presenter.view = self
        
        //let memStore = MemStore() //mock for testing
        let networkStore = TrackNetworkStore()
        interactor = TrackListInteractor(store: networkStore, presenter: presenter)
    }

    private func fetchTracks() {
        interactor.fetchAllTracks(for: TrackList.FetchAll.Request())
    }

    // MARK: - Table view data source

 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let track = tracks[indexPath.row]
        
        cell.textLabel?.text = track.trackName
        cell.detailTextLabel?.text = track.artistName

        return cell
    }
}


extension TrackListTableViewController: TrackListDisplayLogic {
    
    func didFinishFetching(tracks: [TrackList.FetchAll.ViewModel]) {
        self.tracks = tracks
    }
    
    func displayError(_ error: Error) {
       
        showSimpleAlertWith(title: "Error", message: error.localizedDescription)
    }
}

extension TrackListTableViewController: ActivityIndicatorLoadable {
    
}

extension UIViewController {
    
    func showSimpleAlertWith(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
