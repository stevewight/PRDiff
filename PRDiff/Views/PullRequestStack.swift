//
//  PullRequestStack.swift
//  PRDiff
//
//  Created by Steve on 10/20/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

import UIKit

class PullRequestStack: UIStackView {

    var userStack:UIStackView!
    var pullStack:UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        axis = .horizontal
        distribution = .fillProportionally
        alignment = .fill
        spacing = 13.0
        translatesAutoresizingMaskIntoConstraints = false
        setUpUserStack()
        setUpPullStack()
    }
    
    private func setUpUserStack() {
        userStack = UIStackView()
        userStack.axis = .vertical
        userStack.distribution = .fillProportionally
        userStack.alignment = .fill
        userStack.spacing = 3.0
        userStack.autoresizingMask = [.flexibleHeight]
        addArrangedSubview(userStack)
    }
    
    private func setUpPullStack() {
        pullStack = UIStackView()
        pullStack.axis = .vertical
        pullStack.distribution = .fillProportionally
        pullStack.alignment = .fill
        pullStack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addArrangedSubview(pullStack)
    }
    
    // MARK: constraint setup methods
    
    public func setStackConstraints() {
        let left = NSLayoutConstraint(
            item: self,
            attribute: .leading,
            relatedBy: .equal,
            toItem: superview,
            attribute: .leadingMargin,
            multiplier: 1,
            constant: 0
        )
        let right = NSLayoutConstraint(
            item: self,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: superview,
            attribute: .trailingMargin,
            multiplier: 1,
            constant: 0
        )
        let top = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: .equal,
            toItem: superview,
            attribute: .topMargin,
            multiplier: 1,
            constant: 0
        )
        let bottom = NSLayoutConstraint(
            item: self,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: superview,
            attribute: .bottomMargin,
            multiplier: 1,
            constant: 0
        )
        superview?.addConstraints([top,bottom,left,right])
    }

}
