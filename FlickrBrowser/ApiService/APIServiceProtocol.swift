//
//  APIServiceProtocol.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/3/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    func searchForImages(with term: String, itemPerPage: Int, success: @escaping ItemsResponse<FlickrPhoto>, failure: FailureResponse?)
    func searchCommentsFor(photoId: String, success: @escaping ItemsResponse<FlickrPhotoComment>, failure: FailureResponse?)
    func getUserFor(userId: String, success: @escaping SuccessResponse<FlickrUser?>, failure: FailureResponse?)
}

extension APIServiceProtocol {
    func searchForImages(with term: String, itemPerPage: Int = 60, success: @escaping ItemsResponse<FlickrPhoto>, failure: FailureResponse? = nil) {
        searchForImages(with: term, itemPerPage: itemPerPage, success: success, failure: failure)
    }
    
    func searchCommentsFor(photoId: String, success: @escaping ItemsResponse<FlickrPhotoComment>, failure: FailureResponse? = nil) {
        searchCommentsFor(photoId: photoId, success: success, failure: failure)
    }
    
    func getUserFor(userId: String, success: @escaping SuccessResponse<FlickrUser?>, failure: FailureResponse? = nil) {
        getUserFor(userId: userId, success: success, failure: failure)
    }
}
