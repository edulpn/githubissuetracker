//
//  Repository.swift
//  GithubIssueTracker
//
//  Created by Eduardo Pinto on 21/07/17.
//  Copyright © 2017 Eduardo Pinto. All rights reserved.
//

import Foundation
import Mapper

struct Repository: Mappable {
    let id: Int
    let name: String
    let fullName: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try name = map.from("name")
        try fullName = map.from("full_name")
    }
}
