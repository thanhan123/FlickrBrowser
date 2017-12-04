//
//  FlickrPhotoDetailsViewModelTest.swift
//  FlickrBrowserTests
//
//  Created by Dinh Thanh An on 12/3/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import XCTest
@testable import FlickerBrowser

class FlickrPhotoDetailsViewModelTests: XCTestCase {
    var photoDetailsVM: PhotoDetailsViewModel!
    var mockAPI: MockAPIService!
    
    override func setUp() {
        super.setUp()
        let photo = FlickrPhoto(from: ["id": "123"])!
        mockAPI = MockAPIService()
        photoDetailsVM = PhotoDetailsViewModel(photo: photo, apiService: mockAPI)
    }
    
    override func tearDown() {
        photoDetailsVM = nil
        mockAPI = nil
        
        super.tearDown()
    }
    
    func testAPISearchCommentsIsNotCalled() {
        photoDetailsVM.getPhotoComments()
        assert(mockAPI.hasCalledSearchComments == false)
    }
    
    func testAPISearchCommentsIsCalled() {
        photoDetailsVM.showComments = {_ in }
        photoDetailsVM.getPhotoComments()
        assert(mockAPI.hasCalledSearchComments == true)
    }
    
    func testAPIGetUserIsNotCalled() {
        photoDetailsVM.getUserInfo()
        assert(mockAPI.hasCalledGetUser == false)
    }
    
    func testAPISearchPhotosIsCalled() {
        photoDetailsVM.showUserInfo = {_ in }
        photoDetailsVM.getUserInfo()
        assert(mockAPI.hasCalledGetUser == true)
    }
    
}

class MockAPIService: APIServiceProtocol{
    var hasCalledSearchComments = false
    var hasCalledGetUser = false
    
    func searchCommentsFor(photoId: String, success: @escaping ([FlickrPhotoComment]) -> (), failure: FailureResponse?) {
        hasCalledSearchComments = true
    }
    
    func getUserFor(userId: String, success: @escaping (FlickrUser?) -> (), failure: FailureResponse?) {
        hasCalledGetUser = true
    }
}
