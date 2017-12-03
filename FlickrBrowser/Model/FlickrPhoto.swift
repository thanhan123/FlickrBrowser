//
//  FlickrPhoto.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/2/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

struct FlickrPhoto: Codable {
    let id : String
    let title: String
    let farm : Int
    let server : String
    let secret : String
    let owner : String
    
    static func getPhotos(from data: Data) ->[FlickrPhoto] {
        let jsonDecoder = JSONDecoder()
        do {
            let decodedStore = try jsonDecoder.decode([String: [String: [FlickrPhoto]]].self, from: data)
            if let photosInfo = decodedStore["photos"],
                let photos = photosInfo["photo"]{
                return photos
            } else {
                return []
            }
        } catch {
            print("getPhotos parse error: \(error)")
            return []
        }
    }
    
    static func getPhotos(from dict: [String: Any]) ->[FlickrPhoto] {
        if let photosInfo = dict["photos"] as? [String: Any],
            let photoDicts = photosInfo["photo"] as? [[String: Any]]{
            var photos = [FlickrPhoto]()
            photoDicts.forEach({
                if let photo = FlickrPhoto(from: $0) {
                    photos.append(photo)
                }
            })
            return photos
        } else {
            return []
        }
    }
    
    init?(from dict: [String: Any]) {
        guard let photoId = dict["id"] as? String else {
            return nil
        }
        
        let title = dict["title"] as? String ?? ""
        let farm = dict["farm"] as? Int ?? 0
        let server = dict["server"] as? String ?? ""
        let secret = dict["secret"] as? String ?? ""
        let owner = dict["owner"] as? String ?? ""
        
        self.id = photoId
        self.title = title
        self.farm = farm
        self.server = server
        self.secret =  secret
        self.owner = owner
    }
    
    func getPhotoURL(size: String = "m") -> URL {
        return URL(string: "https://farm\(self.farm).staticflickr.com/\(self.server)/\(self.id)_\(self.secret)_\(size).jpg")!
    }
}
