//
//  PhotoCell.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/2/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func setupUI(with photo: FlickrPhoto) {
        imageView.kf.setImage(with: photo.getPhotoURL(), placeholder: #imageLiteral(resourceName: "loading_place_holder"))
    }
}
