//
//  FlickrBrowserTests.swift
//  FlickrBrowserTests
//
//  Created by Dinh Thanh An on 12/3/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import XCTest
@testable import FlickerBrowser

class FlickrListPhotoViewModelTests: XCTestCase {
    var listPhotoVM: ListPhotoViewModel!
    var mockAPI: MockAPIService!
    var mockSceneCoordinator: MockSceneCoordinator!
    
    override func setUp() {
        super.setUp()
        mockAPI = MockAPIService()
        mockSceneCoordinator = MockSceneCoordinator()
        listPhotoVM = ListPhotoViewModel(apiService: mockAPI, sceneCoordinator: mockSceneCoordinator)
    }
    
    override func tearDown() {
        listPhotoVM = nil
        mockAPI = nil
        mockSceneCoordinator = nil
        
        super.tearDown()
    }
    
    func testAPISearchPhotosIsNotCalled() {
        listPhotoVM.searchPhotosAction(term: "superman")
        assert(mockAPI.hasCalledSearchPhoto == false)
    }
    
    func testAPISearchPhotosIsCalled() {
        listPhotoVM.showPhotos = {_ in }
        listPhotoVM.searchPhotosAction(term: "superman")
        assert(mockAPI.hasCalledSearchPhoto == true)
    }
    
    func testWillTransistionToOtherScene() {
        let photo = FlickrPhoto(from: ["id": "123"])!
        listPhotoVM.showPhotoDetails(photo: photo)
        assert(mockSceneCoordinator.hasCalledTransition == true)
    }
    
    class MockSceneCoordinator: SceneCoordinatorType {
        var hasCalledTransition = false
        
        func transition(scene: Scene, typeTransition: TransitionType) {
            hasCalledTransition = true
        }
    }
    
    class MockAPIService: APIServiceProtocol{
        var hasCalledSearchPhoto = false
        
        func searchForImages(with term: String, itemPerPage: Int, success: @escaping ([FlickrPhoto]) -> (), failure: FailureResponse?) {
            hasCalledSearchPhoto = true
        }
    }
}
