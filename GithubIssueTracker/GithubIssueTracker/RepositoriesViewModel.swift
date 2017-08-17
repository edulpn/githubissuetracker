//
//  RepositoriesViewModel.swift
//  GithubIssueTracker
//
//  Created by Eduardo Pinto on 17/08/17.
//  Copyright © 2017 Eduardo Pinto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RepositoriesViewModelType {
    weak var router: RepositoriesRouterType! {get}
    var repositoriesSearcher: RepositoriesSearcher {get}
    var displayedRepositories: Driver<[DisplayedRepository]> {get}
    var isLoading: Driver<Bool> {get}
}

class RepositoriesViewModel: RepositoriesViewModelType {
    weak var router: RepositoriesRouterType!
    var repositoriesSearcher: RepositoriesSearcher
    var displayedRepositories: Driver<[DisplayedRepository]>
    var isLoading: Driver<Bool>
    
    init(with searchQuery: Observable<String>, and router: RepositoriesRouterType) {
        self.router = router
        
        repositoriesSearcher = RepositoriesSearcher()
        isLoading = repositoriesSearcher.activityIndicator.asDriver()
        
        displayedRepositories = repositoriesSearcher.searchRepositories(matching: searchQuery).flatMap { (repositories: [Repository]) -> Observable<[DisplayedRepository]> in
            return Observable.just(repositories.map { DisplayedRepository(name: $0.name, url: $0.url) })
        }.asDriver(onErrorJustReturn: [])
    }
}
