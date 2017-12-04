//
//  ListImageViewModel.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/2/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import UIKit

class ListPhotoViewModel {
    let apiService: APIServiceProtocol
    let sceneCoordinator: SceneCoordinatorType
    
    var showPhotos: ItemsResponse<FlickrPhoto>? = nil
    
    init(apiService: APIServiceProtocol = APIManager(),
         sceneCoordinator: SceneCoordinatorType) {
        self.apiService = apiService
        self.sceneCoordinator = sceneCoordinator
    }
    
    func searchPhotosAction(term: String?) {
        guard let safeTerm = term, let showPhotos = showPhotos else {
            return
        }
        apiService.searchForImages(with: safeTerm, success: showPhotos)
    }
    
    func showPhotoDetails(photo: FlickrPhoto) {
        let photoDetailsVM = PhotoDetailsViewModel(photo: photo, apiService: apiService)
        let photoDetailsScene = Scene.photoDetails(photoDetailsVM)
        sceneCoordinator.transition(scene: photoDetailsScene, typeTransition: .push)
    }
}
