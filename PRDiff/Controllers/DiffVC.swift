//
//  DiffVC.swift
//  PRDiff
//
//  Created by Steve on 10/21/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

import UIKit

class DiffVC: UITableViewController {

    var pullRequest:PullRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        registerCell()
        setTitle()
        loadDiff()
    }

    private func setTitle() {
        if let prNumber = pullRequest?.number {
            title = "Diff #\(prNumber)"
        } else {
            title = "Diff"
        }
    }
    
    private func registerCell() {
        tableView.register(
            DiffCell.self,
            forCellReuseIdentifier: "DiffCell"
        )
    }
    
    private func loadDiff() {
        guard let url = pullRequest?.diffURL else { return }
        let githubAPI = GithubAPI()
        githubAPI.diff(url:url) { lines, errorMsg in
            if errorMsg == "" {
                // TODO: parse raw lines into Diff
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
        print("error msg: \(errorMsg)")
    }
    
}

extension DiffVC {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "DiffCell", for: indexPath
        ) as! DiffCell
        
        //TODO: DiffLine to cell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100 //TODO: get count from Diff
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //TODO: get count of DiffFiles
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 24.0
    }
    
}
