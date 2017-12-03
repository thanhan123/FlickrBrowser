//
//  CommentCell.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/3/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    func setupUI(for comment: FlickrPhotoComment) {
        self.textLabel?.text = comment.content
    }
}
