//
//  FlickrUser.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/2/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

struct FlickrUser {
    let username: String
    let id: String
    
    init?(from dict: [String: Any]) {
        guard let person = dict["person"] as? [String: Any],
            let userId = person["id"] as? String else {
            return nil
        }
        
        var username = ""
        if let usernameDict = person["username"] as? [String: Any],
            let content = usernameDict["_content"] as? String{
            username = content
        }
        
        self.username = username
        self.id = userId
    }
}
