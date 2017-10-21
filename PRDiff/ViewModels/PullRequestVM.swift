//
//  PullRequestVM.swift
//  PRDiff
//
//  Created by Steve on 10/20/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

import UIKit

class PullRequestVM: NSObject {

    var pullRequest:PullRequest!
    
    init(_ pullRequest:PullRequest) {
        super.init()
        self.pullRequest = pullRequest
    }
    
    public func updateCell(_ cell:PullRequestCell) {
        cell.titleLabel.text = pullRequest.title
        cell.numberLabel.text = "#\(pullRequest.number)"
        cell.userLabel.text = pullRequest.user.login
        cell.avatarImageView.loadURL(pullRequest.user.avatarURL) {
            cell.stopActivity()
            cell.avatarImageView.makeCircle()
        }
    }
    
}
