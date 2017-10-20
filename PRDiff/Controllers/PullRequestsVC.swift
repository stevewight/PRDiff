//
//  PullRequestsVC.swift
//  PRDiff
//
//  Created by Steve on 10/20/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

import UIKit

class PullRequestsVC: UIViewController {
    
    let githubAPI = GithubAPI()
    let repo = Repo(name: "Alamofire", owner: "Alamofire")
    var pullRequests = [PullRequest]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pull Requests"
        loadPullRequests()
    }
    
    private func loadPullRequests() {
        githubAPI.pullRequests(repo:repo) { pullRequests, errorMsg in
            if errorMsg == "" {
                self.pullRequests = pullRequests
                self.updateUI()
            } else {
                self.presentErrorMsg(errorMsg)
            }
        }
    }
    
    private func updateUI() {
        print("updating UI")
    }
    
    private func presentErrorMsg(_ errorMsg:String) {
        print("presenting error msg: \(errorMsg)")
    }

}

