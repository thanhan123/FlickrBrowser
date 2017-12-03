//
//  ViewController.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/2/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD

class ListPhotoViewController: UIViewController, BindableType {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var viewModel: ListPhotoViewModel!
    
    var listPhoto = [FlickrPhoto]() {
        didSet {
            photoCollectionView.reloadData()
        }
    }
    
    let cellIdentifier = "PhotoCell"
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "List Photo"
        
        registerUIAction()
    }
    
    // MARK: Bind view model
    func bindViewModel() {
        viewModel.showPhotos = {[unowned self] photos in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.listPhoto = photos
        }
    }
    
    // MARK: UI action
    func registerUIAction() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        searchBar.delegate = self
    }
}

extension ListPhotoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        viewModel.searchPhotosAction(term: searchBar.text)
        searchBar.resignFirstResponder()
    }
}

extension ListPhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = listPhoto[indexPath.row]
        viewModel.showPhotoDetails(photo: photo)
    }
}

extension ListPhotoViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = UIScreen.main.bounds.width / 4
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension ListPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoCell
        let photo = listPhoto[indexPath.row]
        cell.setupUI(with: photo)
        return cell
    }
}

