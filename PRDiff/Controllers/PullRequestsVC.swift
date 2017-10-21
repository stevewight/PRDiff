//
//  PullRequestsVC.swift
//  PRDiff
//
//  Created by Steve on 10/20/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

import UIKit

class PullRequestsVC: UITableViewController {
    
    let githubAPI = GithubAPI()
    let repo = Repo(name: "Alamofire", owner: "Alamofire")
    var pullRequests = [PullRequest]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pull Requests"
        registerCell()
        loadPullRequests()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = "" // Remove title from next VC back button
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        title = "Pull Requests" // Put title back
    }
    
    private func registerCell() {
        tableView.register(
            PullRequestCell.self,
            forCellReuseIdentifier: "PullRequestCell"
        )
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
        // Make sure UI changes are on Main Queue
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func presentErrorMsg(_ errorMsg:String) {
        print("presenting error msg: \(errorMsg)")
    }

}

// MARK: UITableViewDelegate and UITableViewDataSource Methods

extension PullRequestsVC {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pullRequest = pullRequests[indexPath.row]
        let pullRequestVM = PullRequestVM(pullRequest)
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "PullRequestCell", for: indexPath
        ) as! PullRequestCell
        
        pullRequestVM.updateCell(cell)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let diffVC = DiffVC()
        diffVC.pullRequest = pullRequests[indexPath.row]
        navigationController?.pushViewController(
            diffVC,
            animated: true
        )
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequests.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
}

