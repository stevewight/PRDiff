//
//  AvatarImageView.swift
//  PRDiff
//
//  Created by Steve on 10/20/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

import UIKit

class AvatarImageView: UIImageView {
    
    var activityIndicator:UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        if let icon = UIImage(named: "github-icon") {
            self.image = icon
            self.contentMode = .scaleAspectFit
            self.translatesAutoresizingMaskIntoConstraints = false
            self.setUpActivityIndicator()
        }
    }
    
    public func stopActivity() {
        activityIndicator.stopAnimating()
    }
    
    private func setUpActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        bringSubview(toFront:activityIndicator)
        activityIndicator.startAnimating()
    }
    
    // MARK: constraint setup methods
    
    public func setAvatarConstraints() {
        let width = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 84
        )
        let height = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 84
        )
        superview?.addConstraints([height,width])
        setActivityConstraints()
    }
    
    private func setActivityConstraints() {
        let centerX = NSLayoutConstraint(
            item: activityIndicator,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        let centerY = NSLayoutConstraint(
            item: activityIndicator,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1,
            constant: 0
        )
        superview?.addConstraints([centerX, centerY])
    }

}
