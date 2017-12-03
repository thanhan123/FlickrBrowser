//
//  PhotoDetailsViewController.swift
//  FlickerBrowser
//
//  Created by Dinh Thanh An on 12/2/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController, BindableType {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    
    let cellIdentifier = "CommentCell"
    
    var viewModel: PhotoDetailsViewModel!
    
    var comments = [FlickrPhotoComment]() {
        didSet {
            commentTableView.reloadData()
        }
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photo details"
        
        registerUIAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.getPhotoComments()
        viewModel.getUserInfo()
    }
    
    // MARK: Bind view model
    func bindViewModel() {
        viewModel.showUserInfo = {[unowned self] userInfo in
            if let user = userInfo {
                self.usernameLabel.text = user.username
            } else {
                self.usernameLabel.text = "No username"
            }
        }
        
        viewModel.showComments = {[unowned self] comments in
            self.comments = comments
        }
    }
    
    // MARK: UI action
    func registerUIAction() {
        commentTableView.dataSource = self
    }
}

extension PhotoDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CommentCell
        let comment = comments[indexPath.row]
        cell.setupUI(for: comment)
        return cell
    }    
}
