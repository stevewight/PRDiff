//
//  Repo.swift
//  PRDiff
//
//  Created by Steve on 10/20/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

struct Repo {
    let name:String
    let owner:String
    
    public func pullsPath()->String {
        return "repos/\(name)/\(owner)/pulls"
    }
}
