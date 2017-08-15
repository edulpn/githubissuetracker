//
//  IssueTracker.swift
//  GithubIssueTracker
//
//  Created by Eduardo Pinto on 21/07/17.
//  Copyright © 2017 Eduardo Pinto. All rights reserved.
//

import Foundation
import Moya
import Moya_ModelMapper
import RxSwift
import RxOptional

struct IssueTracker {
    let provider = RxMoyaProvider<Github>()
    let isLoading: Variable<Bool> = Variable<Bool>(false)
    
    func trackIssues(for repositoryName: Observable<String>) -> Observable<[Issue]> {
        return repositoryName
            .observeOn(MainScheduler.instance)
            .flatMapLatest { (name: String) -> Observable<Repository?> in
                if name == "" { return Observable.just(nil) }
                self.isLoading.value = true
                
                return self.findRepository(named: name)
            }
            .flatMapLatest { repository -> Observable<[Issue]?> in
                guard let repository = repository else { return Observable.just(nil) }
                
                return self.findIssues(for: repository)
            }
            .do(onNext: { _ in
                self.isLoading.value = false
            })
            .replaceNilWith([])
    }
    
    fileprivate func findIssues(for repository: Repository) -> Observable<[Issue]?> {
        return provider.request(Github.issues(repositoryFullName: repository.fullName))
            .debug()
            .mapArrayOptional(type: Issue.self)
    }
    
    fileprivate func findRepository(named name: String) -> Observable<Repository?> {
        return provider.request(Github.repo(fullName: name))
            .debug()
            .mapObjectOptional(type: Repository.self)
    }
}
