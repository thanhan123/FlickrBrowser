//
//  FlickrPhotoComment.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/2/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

struct FlickrPhotoComment {
    let id: String
    let content: String
    
    static func getComments(from dict: [String: Any]) ->[FlickrPhotoComment] {
        if let commentsInfo = dict["comments"] as? [String: Any],
            let commentArray = commentsInfo["comment"] as? [[String: Any]]{
            var comments = [FlickrPhotoComment]()
            commentArray.forEach({
                if let comment = FlickrPhotoComment(from: $0) {
                    comments.append(comment)
                }
            })
            return comments
        } else {
            return []
        }
    }
    
    init?(from dict: [String: Any]) {
        guard let commentId = dict["id"] as? String else {
            return nil
        }
        
        let content = dict["_content"] as? String ?? ""
        
        self.id = commentId
        self.content = content
    }
}
