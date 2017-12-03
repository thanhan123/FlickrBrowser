//
//  PhotoDetailsViewModel.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/3/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import UIKit

class PhotoDetailsViewModel {
    let photo: FlickrPhoto
    let apiService: APIServiceProtocol
    
    var showUserInfo: SuccessResponse<FlickrUser?>? = nil
    var showComments: ItemsResponse<FlickrPhotoComment>? = nil
    
    init(photo: FlickrPhoto, apiService: APIServiceProtocol = APIManager()) {
        self.photo = photo
        self.apiService = apiService
    }
    
    func getUserInfo() {
        guard let showUserInfo = showUserInfo else {
            return
        }
        apiService.getUserFor(userId: photo.owner, success: showUserInfo)
    }
    
    func getPhotoComments() {
        guard let showComments = showComments else {
            return
        }
        apiService.searchCommentsFor(photoId: photo.id, success: showComments)
    }
}
