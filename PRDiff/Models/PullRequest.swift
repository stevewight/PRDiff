//
//  PullRequest.swift
//  PRDiff
//
//  Created by Steve on 10/20/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

import UIKit

struct PullRequest:Decodable {
    let title:String
    let body:String
    let number:Int
    let createdAt:Date
    let user:User
    
    enum CodingKeys: String, CodingKey {
        case title, body, number, user
        case createdAt = "created_at"
    }
}
