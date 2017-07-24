//
//  Issue.swift
//  GithubIssueTracker
//
//  Created by Eduardo Pinto on 21/07/17.
//  Copyright © 2017 Eduardo Pinto. All rights reserved.
//

import Foundation
import Mapper

struct Issue: Mappable {
    let id: Int
    let number: Int
    let title: String
    let body: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try number = map.from("number")
        try title = map.from("title")
        try body = map.from("body")
    }
}
