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

protocol IssueTrackerViewControllerType {
    var viewModel: IssueTrackerViewModelType? {get}
}

class IssueTrackerViewController: UIViewController, IssueTrackerViewControllerType, Loadable {

    //ViewModel Reference
    var viewModel: IssueTrackerViewModelType?
    
    //Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //Rx observable for search bar text reacting
    var searchBarText: Observable<String> {
        return searchBar
            .rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    //Rx dispose bag, for cleaning up
    var disposeBag = DisposeBag()
    
    var loadingView: UIView!
    convenience init() {
        self.init()
        loadingView = LoadingView(at: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Table view cell registration
        tableView.register(R.nib.issueTableViewCell)
        
        setupRx()
    }
    
    func setupRx() {
        //ViewModel Instantiation + Dependency Injection
        viewModel = IssueTrackerViewModel(with: searchBarText)
        
        viewModel?.isLoading.map({ isLoading -> Bool in
            let isHidden = !isLoading
            return isHidden
        })
            .drive(loadingView.rx.isHidden)
            .addDisposableTo(disposeBag)
        
        viewModel?.isLoading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .addDisposableTo(disposeBag)
        
        setupTableView()
    }
    
    func setupTableView() {
        viewModel?.issues.drive(tableView.rx.items) { table, row, issue in
            let cell = table.dequeueReusableCell(withIdentifier: R.reuseIdentifier.issueTableViewCellIdentifier)!
            cell.configure(with: issue.cellText)
            return cell
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            self.tableView.deselectRow(at: indexPath, animated: true)
        })
        .addDisposableTo(disposeBag)
    }
}
