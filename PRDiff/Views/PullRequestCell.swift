//
//  PullRequestCell.swift
//  PRDiff
//
//  Created by Steve on 10/20/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

import UIKit

class PullRequestCell: UITableViewCell {

    var constraintsSet = false
    var stack:PullRequestStack!
    var avatarImageView:AvatarImageView!
    var userLabel:UILabel!
    var titleLabel:UILabel!
    var numberLabel:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpAvatar()
        setUpTitleLabel()
        setUpUserLabel()
        setUpNumberLabel()
        setUpStack()
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsSet {
            stack.setStackConstraints()
            avatarImageView.setAvatarConstraints()
            setNumberConstraints()
            constraintsSet = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func stopActivity() {
        avatarImageView.stopActivity()
    }
    
    // MARK: view setup methods
    
    private func setUpStack() {
        stack = PullRequestStack()
        stack.userStack.addArrangedSubview(avatarImageView)
        stack.userStack.addArrangedSubview(userLabel)
        stack.pullStack.addArrangedSubview(titleLabel)
        stack.pullStack.addArrangedSubview(numberLabel)
        contentView.addSubview(stack)
    }
    
    private func setUpAvatar() {
        avatarImageView = AvatarImageView(frame: .zero)
    }
    
    private func setUpUserLabel() {
        userLabel = UILabel()
        userLabel.textAlignment = .center
        userLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setUpTitleLabel() {
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
    }
    
    private func setUpNumberLabel() {
        numberLabel = UILabel()
        numberLabel.textAlignment = .right
    }
    
    // MARK: constraint setup methods
    
    private func setNumberConstraints() {
        let height = NSLayoutConstraint(
            item: numberLabel,
            attribute: .height,
            relatedBy: .equal,
            toItem: userLabel,
            attribute: .height,
            multiplier: 1,
            constant: 0
        )
        addConstraints([height])
    }

}
