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

protocol IssueTrackerViewModelType {
    var issues: Driver<[DisplayedIssue]> {get}
    var isLoading: Driver<Bool> {get}
    var issueTracker: IssueTracker {get}
}

class IssueTrackerViewModel: IssueTrackerViewModelType {
    var issues: Driver<[DisplayedIssue]>
    var isLoading: Driver<Bool>
    var issueTracker: IssueTracker
    
    init(with repositoryName: Observable<String>) {
        issueTracker = IssueTracker()
        
        issues = issueTracker.trackIssues(for: repositoryName).flatMap({ (issues) -> Observable<[DisplayedIssue]> in
            Observable<[DisplayedIssue]>.just(issues.map { DisplayedIssue(cellText:$0.title) })
        }).asDriver(onErrorJustReturn: [])
        
        isLoading = issueTracker.isLoading.asDriver()
    }
}
