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

protocol IssueTrackerView {
    var searchBar: UISearchBar! {get set}
}

class IssueTrackerViewController: UIViewController, IssueTrackerView {

    //ViewModel Reference
    var viewModel: IssueTrackerViewModel = IssueTrackerViewModelImpl()
    
    //Outlets
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //Rx
    var searchBarTextObservable: Observable<String> {
        return searchBar.rx.text.orEmpty.debounce(0.5, scheduler: MainScheduler.instance).distinctUntilChanged()
    }
    var disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
        
        setupRx()
    }
    
    func setupRx() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
