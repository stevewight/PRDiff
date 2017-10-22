//
//  DiffCell.swift
//  PRDiff
//
//  Created by Steve on 10/21/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

import UIKit

class DiffCell: UITableViewCell {
    
    var constraintsSet = false
    var stack:DiffStack!
    var leftNumLabel:UILabel!
    var leftBodyLabel:UILabel!
    var rightNumLabel:UILabel!
    var rightBodyLabel:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLeftLabels()
        setUpRightLabels()
        setUpStack()
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsSet {
            stack.setStackConstraints()
            setNumLabelConstraints()
            constraintsSet = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: view setup methods
    
    private func setUpStack() {
        stack = DiffStack()
        stack.leftStack.addArrangedSubview(leftNumLabel)
        stack.leftStack.addArrangedSubview(leftBodyLabel)
        stack.rightStack.addArrangedSubview(rightNumLabel)
        stack.rightStack.addArrangedSubview(rightBodyLabel)
        contentView.addSubview(stack)
    }
    
    private func setUpLeftLabels() {
        leftNumLabel = UILabel()
        leftNumLabel.textAlignment = .center
        leftNumLabel.adjustsFontSizeToFitWidth = true
        leftNumLabel.backgroundColor = .lightGray
        leftBodyLabel = UILabel()
        leftBodyLabel.numberOfLines = 0
    }
    
    private func setUpRightLabels() {
        rightNumLabel = UILabel()
        rightNumLabel.textAlignment = .center
        rightNumLabel.adjustsFontSizeToFitWidth = true
        rightNumLabel.backgroundColor = .lightGray
        rightBodyLabel = UILabel()
        rightBodyLabel.numberOfLines = 0
    }
    
    // MARK: constraint setup methods
    
    private func setNumLabelConstraints() {
        leftNumLabel.widthAnchor.constraint(
            equalToConstant: 24
            ).isActive = true
        rightNumLabel.widthAnchor.constraint(
            equalToConstant: 24
            ).isActive = true
    }
    
}
