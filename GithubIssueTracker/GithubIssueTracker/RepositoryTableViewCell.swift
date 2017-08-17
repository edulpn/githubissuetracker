//
//  RepositoryTableViewCell.swift
//  GithubIssueTracker
//
//  Created by Eduardo Pinto on 17/08/17.
//  Copyright © 2017 Eduardo Pinto. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var repositoryUrlLabel: UILabel!
    @IBOutlet weak var repositoryTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with title: String, and url: String) {
        repositoryUrlLabel.text = url
        repositoryTitleLabel.text = title
    }
}
