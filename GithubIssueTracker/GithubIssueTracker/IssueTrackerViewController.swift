//
//  IssueTrackerViewController.swift
//  GithubIssueTracker
//
//  Created by Eduardo Pinto on 20/07/17.
//  Copyright © 2017 Eduardo Pinto. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class IssueTrackerViewController: UIViewController {

    //ViewModel Reference
    var viewModel: IssueTrackerViewModel = IssueTrackerViewModelImpl()
    
    //Outlets
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //Rx
    var searchBarText: Observable<String> {
        return searchBar.rx.text.orEmpty.throttle(3.0, scheduler: MainScheduler.instance)
    }
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(R.nib.issueTableViewCell)
        
        setupRx()
    }
    
    func setupRx() {
        let issues = viewModel.fetchIssues(for: searchBarText)
        
        issues.drive(tableView.rx.items) { table, row, issueTitle in
            let cell = table.dequeueReusableCell(withIdentifier: R.reuseIdentifier.issueTableViewCellIdentifier)!
            cell.configure(with: issueTitle)
            return cell
        }.addDisposableTo(disposeBag)
    }
}
