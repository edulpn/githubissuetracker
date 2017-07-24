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
    func fetchIssues(for repositoryName: Observable<String>) -> Driver<[Issue]>
}

class IssueTrackerViewModelImpl: IssueTrackerViewModel {
    
    func fetchIssues(for repositoryName: Observable<String>) -> Driver<[Issue]> {
        return IssueTracker().trackIssues(for: repositoryName).asDriver(onErrorJustReturn: [])
    }
}
