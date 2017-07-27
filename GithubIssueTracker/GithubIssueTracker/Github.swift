//
//  Github.swift
//  GithubIssueTracker
//
//  Created by Eduardo Pinto on 20/07/17.
//  Copyright © 2017 Eduardo Pinto. All rights reserved.
//

import Foundation
import Moya

enum Github {
    case repo(fullName: String)
    case issues(repositoryFullName: String)
}

extension Github: TargetType {
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    
    var path: String {
        switch self {
        case .repo(let name):
            return "/repos/\(name)"
        case .issues(let repositoryName):
            return "/repos/\(repositoryName)/issues"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var sampleData: Data {
        switch self {
        case .repo(_):
            return "{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/edulpn/githubissuetracker\", \"name\": \"Router\"}".data(using: .utf8)!
        case .issues(_):
            return "{\"id\": 1, \"number\": 123, \"title\": \"Update all the documentation\", \"body\": \"Documentation is non-existant. Please stop being lazy.\"}".data(using: .utf8)!
        }
    }
    
    var task: Task {
        return .request
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
