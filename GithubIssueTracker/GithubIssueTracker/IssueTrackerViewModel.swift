//
//  IssueTrackerViewModel.swift
//  GithubIssueTracker
//
//  Created by Eduardo Pinto on 20/07/17.
//  Copyright © 2017 Eduardo Pinto. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

protocol IssueTrackerViewModel {
    func fetchIssues(for repositoryName: Observable<String>) -> Driver<[String]>
}

class IssueTrackerViewModelImpl: IssueTrackerViewModel {
    private var issues: [Issue] = []
    
    func fetchIssues(for repositoryName: Observable<String>) -> Driver<[String]> {
        return IssueTracker().trackIssues(for: repositoryName).flatMap { (issues: [Issue]) -> Observable<[String]> in
            self.issues = issues
            return Observable.just(issues.map { $0.title })
        }.asDriver(onErrorJustReturn: [])
    }
}
