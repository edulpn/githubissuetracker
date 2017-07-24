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
    
    func trackIssues(for repositoryName: Observable<String>) -> Observable<[Issue]> {
        return repositoryName
            .observeOn(MainScheduler.instance)
            .flatMapLatest { name -> Observable<Repository?> in
                print("Repo Name: \(name)")
                return self.findRepository(named: name)
            }
            .flatMapLatest { repository -> Observable<[Issue]?> in
                guard let repository = repository else { return Observable.just(nil) }
                
                print("Repository: \(repository.fullName)")
                return self.findIssues(for: repository)
            }
            .replaceNilWith([])
    }
    
    func findIssues(for repository: Repository) -> Observable<[Issue]?> {
        return provider.request(Github.issues(repositoryFullName: repository.fullName)).debug().mapArrayOptional(type: Issue.self)
    }
    
    func findRepository(named name: String) -> Observable<Repository?> {
        return provider.request(Github.repo(fullName: name)).debug().mapObjectOptional(type: Repository.self)
    }
}
