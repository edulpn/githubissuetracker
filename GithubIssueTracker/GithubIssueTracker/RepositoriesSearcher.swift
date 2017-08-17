//
//  RepositoriesSearcher.swift
//  GithubIssueTracker
//
//  Created by Eduardo Pinto on 17/08/17.
//  Copyright © 2017 Eduardo Pinto. All rights reserved.
//

import Foundation
import Moya
import Moya_ModelMapper
import RxSwiftUtilities
import RxSwift
import RxOptional

struct RepositoriesSearcher {
    let provider = RxMoyaProvider<Github>()
    let activityIndicator = ActivityIndicator()
    
    func searchRepositories(matching searchQuery: Observable<String>) -> Observable<[Repository]> {
        return searchQuery
            .observeOn(MainScheduler.instance)
            .flatMapLatest { (username: String) -> Observable<[Repository]?> in
                guard username != "" else {
                    return Observable.just(nil)
                }
                
                return self.provider.request(Github.repos(username: username))
                    .trackActivity(self.activityIndicator)
                    .debug()
                    .mapArrayOptional(type: Repository.self)
        }.replaceNilWith([])
    }
}
