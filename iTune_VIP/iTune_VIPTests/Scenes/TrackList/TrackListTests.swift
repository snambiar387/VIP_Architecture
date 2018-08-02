//
//  TrackListTests.swift
//  iTune_VIPTests
//
//  Created by sreehari m nambiar on 02/08/18.
//  Copyright © 2018 sreehari m nambiar. All rights reserved.
//

import UIKit
import XCTest
@testable import iTune_VIP


class TrackListTests: XCTestCase {
    
    //Subject Under Test
    var sut: TrackListInteractor!
    
    override func setUp() {
        super.setUp()
        
        let spy = TrackListPresenterSpy()
        sut = TrackListInteractor(store: MemStore(), presenter: spy)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInteractorDelegatesLoadTrackToWorker() {
       
        //Given
        let dummyWorker = DummyWorker()
        sut.store = dummyWorker
        
        //when
        sut.fetchAllTracks(for: TrackList.Fetch.Request(artistName: "Akon"))
        
        //then
        XCTAssert(dummyWorker.loadTrackIsCalled, "Should invoke method to load all tracks")
        
    }
    
    func testInteractorCallsPresentFetchedTracks() {
        
        //Given
        let dummyWorker = DummyWorker()
        sut.store = dummyWorker
        
        let spy = TrackListPresenterSpy()
        sut.presenter = spy
        
        //when
        sut.fetchAllTracks(for: TrackList.Fetch.Request(artistName: "Akon"))
        
        //then
        XCTAssert(spy.didPresentFetchedTracks, "Should invoke didPresentFetchedTracks")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class DummyWorker: TrackStore {
    
    var loadTrackIsCalled = false
    
    func loadTracks(for request: TrackList.Fetch.Request, completion: @escaping (Result<[Track]>) -> Void) {
        loadTrackIsCalled = true
        completion(Result.success([]))
    }
}

class TrackListPresenterSpy: TrackListPresentationLogic, ActivityIndicatorLoadable {
    
    var didPresentFetchedTracks = false
    var didPresentError = false
    var didShowActivityIndicator = false
    var didHideActivityIndicator = false
    
    func presentFetchedTracks(response: TrackList.Fetch.Response) {
        didPresentFetchedTracks = true
    }
    
    func presentError(_ error: Error) {
        didPresentError = true
    }
    
    func showActivityIndicator() {
        didShowActivityIndicator = true
    }
    
    func hideActivityIndicator() {
        didHideActivityIndicator = true
    }
}
