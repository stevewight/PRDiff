//
//  DiffStack.swift
//  PRDiff
//
//  Created by Steve on 10/21/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

import UIKit

class DiffStack: UIStackView {
    
    var leftStack:UIStackView!
    var rightStack:UIStackView!
    
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
        distribution = .fillEqually
        alignment = .fill
        spacing = 3.0
        translatesAutoresizingMaskIntoConstraints = false
        setUpLeftStack()
        setUpRightStack()
    }
    
    private func setUpLeftStack() {
        leftStack = UIStackView()
        leftStack.axis = .horizontal
        leftStack.distribution = .fillProportionally
        leftStack.alignment = .fill
        leftStack.spacing = 2.0
        leftStack.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        addArrangedSubview(leftStack)
    }
    
    private func setUpRightStack() {
        rightStack = UIStackView()
        rightStack.axis = .horizontal
        rightStack.distribution = .fillProportionally
        rightStack.alignment = .fill
        rightStack.spacing = 2.0
        rightStack.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        addArrangedSubview(rightStack)
    }
    
    // MARK: constraint setup methods
    
    public func setStackConstraints() {
        let left = NSLayoutConstraint(
            item: self,
            attribute: .leading,
            relatedBy: .equal,
            toItem: superview,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        )
        let right = NSLayoutConstraint(
            item: self,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: superview,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        )
        let top = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: .equal,
            toItem: superview,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )
        let bottom = NSLayoutConstraint(
            item: self,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: superview,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        superview?.addConstraints([top,bottom,left,right])
    }
    
}
