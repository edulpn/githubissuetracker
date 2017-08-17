//
//  RepositoriesViewController.swift
//  GithubIssueTracker
//
//  Created by Eduardo Pinto on 15/08/17.
//  Copyright © 2017 Eduardo Pinto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol RepositoriesViewControllerType {
    var viewModel: RepositoriesViewModelType? {get}
}

class RepositoriesViewController: UIViewController, RepositoriesViewControllerType, Loadable {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsTableView: UITableView!

    var viewModel: RepositoriesViewModelType?
    
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

        //Table View Cell Registration
        resultsTableView.register(R.nib.repositoryTableViewCell)
        
        setupRx()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func setupRx() {
        viewModel = RepositoriesViewModel(with: searchBarText, and: RepositoriesRouter())
        
        viewModel?.isLoading.map { (isLoading) -> Bool in
            let isHidden = !isLoading
            return isHidden
        }.drive(loadingView.rx.isHidden)
            .addDisposableTo(disposeBag)
        
        viewModel?.isLoading.drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .addDisposableTo(disposeBag)
        
        setupTableView()
    }
    
    func setupTableView() {
        viewModel?.displayedRepositories.drive(resultsTableView.rx.items) { table, row, repository in
            let cell = table.dequeueReusableCell(withIdentifier: R.reuseIdentifier.repositoryTableViewCell)!
            cell.configure(with: repository.name, and: repository.url)
            return cell
            }.addDisposableTo(disposeBag)
        
        
    }
}
