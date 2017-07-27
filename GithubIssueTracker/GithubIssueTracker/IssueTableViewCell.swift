//
//  IssueTableViewCell.swift
//  GithubIssueTracker
//
//  Created by Eduardo Pinto on 21/07/17.
//  Copyright © 2017 Eduardo Pinto. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {

    @IBOutlet weak var issueLabel: UILabel!
    
    func configure(with title: String) {
        issueLabel.text = title
    }
}
