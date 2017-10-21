//
//  GithubAPI.swift
//  PRDiff
//
//  Created by Steve on 10/20/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

import UIKit

class GithubAPI: NSObject {
    
    let baseURL = "https://api.github.com/"
    let session = URLSession.shared
    var dataTask: URLSessionDataTask?
    var errorMsg = ""
    
    public func pullRequests(repo:Repo,complete:@escaping (_ pullRequests:[PullRequest],_ errorMsg:String)->Void) {
        let urlString = "\(baseURL)\(repo.pullsPath())"
        guard let url = URL(string:urlString) else {
            errorMsg = "Error: issue with the URL"
            return
        }
        
        dataTask = session.dataTask(with: url) { data, response, error in
            var pullRequests = [PullRequest]()
            let response = response as? HTTPURLResponse
            
            if response?.statusCode == 200 {
                pullRequests = self.decodePullRequestData(data!)
            } else {
                self.errorMsg = "Error: status code other than 200"
            }
            complete(pullRequests, self.errorMsg)
        }
        dataTask?.resume()
    }
    
    public func diff(url:URL,complete:@escaping (_ lines:[String],_ errorMsg:String)->Void) {
        dataTask = session.dataTask(with: url) { data, response, error in
            guard let diffData = data else {
                self.errorMsg = "Error: could not load diff data"
                return
            }
            complete(self.buildLines(data:diffData),self.errorMsg)
        }
        dataTask?.resume()
    }
    
    private func decodePullRequestData(_ data:Data)->[PullRequest] {
        var pullRequests = [PullRequest]()
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            pullRequests = try decoder.decode(
                [PullRequest].self,
                from: data
            )
        } catch {
            errorMsg = "Error: could not decode JSON"
        }
        return pullRequests
    }
    
    private func buildLines(data:Data)->[String] {
        let diffString = String(data:data,encoding:.utf8)
        let lines = diffString?.components(separatedBy: "\n")
        return lines!
    }
    
}
