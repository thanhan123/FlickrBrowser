//
//  APIManager.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/2/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation
import Alamofire

typealias ItemsResponse<T> = ([T]) -> ()
typealias SuccessResponse<T> = (T) -> ()
typealias FailureResponse = (String) -> ()

let secret = "8d16b5b9f409d8d0"
let apiKey = "a67fdc0b71c5f2e6821f7629326f87a7"

class APIManager: APIServiceProtocol {
    
//    private init() {}
//    static let shared = APIManager()
    
    private let baseURL = "https://api.flickr.com/services/rest/?format=json&nojsoncallback=1&api_key=\(apiKey)"
    private let apiSearchPhotos = "flickr.photos.search"
    private let apiGetPhotoComments = "flickr.photos.comments.getList"
    private let apiGetUserInfo = "flickr.people.getInfo"
    
    func searchForImages(with term: String, itemPerPage: Int = 60, success: @escaping ItemsResponse<FlickrPhoto>, failure: FailureResponse? = nil) {
        let params = ["text": term,
                      "per_page": itemPerPage,
                      "method": apiSearchPhotos] as [String : Any]
        
        alamofireRequest(url: searchFlickrPhotosUrl(with: params), success: { response in
            if let dict = response as? [String: Any] {
                success(FlickrPhoto.getPhotos(from: dict))
            } else {
                failure?("no_data")
            }
        }, failure: failure)
    }
    
    func searchCommentsFor(photoId: String, success: @escaping ItemsResponse<FlickrPhotoComment>, failure: FailureResponse? = nil) {
        let params = ["photo_id": photoId,
                      "method": apiGetPhotoComments] as [String : Any]
        
        alamofireRequest(url: searchFlickrPhotosUrl(with: params), success: { response in
            if let dict = response as? [String: Any] {
                success(FlickrPhotoComment.getComments(from: dict))
            } else {
                failure?("no_data")
            }
        }, failure: failure)
    }
    
    func getUserFor(userId: String, success: @escaping SuccessResponse<FlickrUser?>, failure: FailureResponse? = nil) {
        let params = ["user_id": userId,
                      "method": apiGetUserInfo] as [String : Any]
        
        alamofireRequest(url: searchFlickrPhotosUrl(with: params), success: { response in
            if let dict = response as? [String: Any] {
                success(FlickrUser(from: dict))
            } else {
                failure?("no_data")
            }
        }, failure: failure)
    }
    
    private func alamofireRequest(url: String, success: SuccessResponse<Any>?, failure: FailureResponse?) {
        Alamofire.request(url,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
            
            .responseJSON { response in
                self.handleResponse(response, success: success, failure: failure)
        }
    }
    
    private func searchFlickrPhotosUrl(with params: [String: Any]) -> String {
        
        let paramsString = params.map { (arg) -> String in
            let (key, value) = arg
            if let valueString = value as? String,
                let urlString = valueString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                return "&\(key)=\(urlString)"
            } else {
                return ""
            }
        }.joined(separator: "")
        
        return baseURL + paramsString
    }
    
    private func handleResponse(_ response: DataResponse<Any>, success: SuccessResponse<Any>?, failure: FailureResponse?) {
        guard response.result.error == nil && response.result.isSuccess else {
            failure?(response.result.error!.localizedDescription)
            return
        }
        
        success?(response.result.value!)
    }
}
