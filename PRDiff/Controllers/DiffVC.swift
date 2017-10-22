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
    var diff = Diff()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 24.0
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
                self.diff = Diff(rawLines: lines)
                self.updateUI()
            } else {
                self.presentErrorMsg(errorMsg)
            }
        }
    }
    
    private func updateUI() {
        //update UI on main queue
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func presentErrorMsg(_ errorMsg:String) {
        print("error msg: \(errorMsg)")
    }
    
}

extension DiffVC {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let line = diff.lines[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "DiffCell", for: indexPath
        ) as! DiffCell
        
        cell.leftBodyLabel.text = line.body
        cell.leftNumLabel.text = " "
        cell.stack.rightStack.isHidden = true
        cell.backgroundColor = cellColor(line: line)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diff.lines.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    private func cellColor(line:DiffLine)->UIColor {
        if line.operation == .addition {
            return UIColor(
                red: 0.0,
                green: 1.0,
                blue: 0.0,
                alpha: 0.25
            )
        } else if line.operation == .deletion {
            return UIColor(
                red: 1.0,
                green: 0.0,
                blue: 0.0,
                alpha: 0.25
            )
        } else {
            return .white
        }
    }
    
}
