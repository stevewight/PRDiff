//
//  Diff.swift
//  PRDiff
//
//  Created by Steve on 10/21/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

import UIKit

class Diff: NSObject {
    
    var files = [DiffFile]()
    var lines = [DiffLine]()
    
    override init() {
        super.init()
    }
    
    init(rawLines:[String]) {
        super.init()
        parseLines(rawLines)
    }
    
    private func parseLines(_ rawLines:[String]) {
        let parser = DiffParser(rawLines: rawLines)
        files = parser.files
        lines = parser.allLines
    }
}

struct DiffFile {
    var additions = 0
    var deletions = 0
    var name = ""
    var codeBlocks = [DiffBlock]()
}

struct DiffBlock {
    var rawTitle:String
    var lineInfo = [DiffLineInfo]()
    var lines = [DiffLine]()
}

struct DiffLineInfo {
    var operation:DiffOperation
    var startLine:Int
    var numberofLines:Int
}

struct DiffLine {
    var lineNum:Int
    var body:String
    var operation:DiffOperation?
}

enum DiffOperation {
    case addition, deletion, none
}

