//
//  DiffParser.swift
//  PRDiff
//
//  Created by Steve on 10/21/17.
//  Copyright © 2017 Steve Wight. All rights reserved.
//

import UIKit

class DiffParser: NSObject {
    // Parsing Strategy
    // * Look for '+++' and get DiffFile name
    // * Look for '@@' and get DiffBlock(s) for DiffFile
    // * Use DiffBlock metaData to iterate into DiffLines
    
    var rawLines = [String]()
    var files = [DiffFile]()
    
    init(rawLines:[String]) {
        super.init()
        self.rawLines = rawLines
        beginParse()
    }
    
    private func beginParse() {
        for (index,line) in rawLines.enumerated() {
            checkForFileOrBlock(line:line, index:index)
        }
    }
    
    private func checkForFileOrBlock(line:String,index:Int) {
        if line.hasPrefix("+++") {
            let newFile = buildFile(line: line, index: index)
            files.append(newFile)
        } else if line.hasPrefix("@@") {
            let newBlock = buildBlock(line:line, index: index)
            guard var currentFile = files.popLast() else { return }
            currentFile.codeBlocks.append(newBlock)
            files.append(currentFile)
        }
    }
    
    private func buildFile(line:String,index:Int)->DiffFile {
        let name = line.replacingOccurrences(
            of: "+++ b",
            with: ""
        )
        return DiffFile(
            additions: 0,
            deletions: 0,
            name: name,
            codeBlocks: [DiffBlock]()
        )
    }
    
    private func buildBlock(line:String,index:Int)->DiffBlock {
        let lineInfo = getLineInfo(line: line)
        let startIndex = index + 1
        var endIndex = startIndex
        if let addLine = lineInfo.first {
            endIndex += addLine.numberofLines
        }
        let lines = buildLines(start:startIndex,end:endIndex)
        
        return DiffBlock(
            rawTitle: line,
            lineInfo: lineInfo,
            lines: lines
        )
    }
    
    private func getLineInfo(line:String)->[DiffLineInfo] {
        let infoSlice = line.slice(from: "@@", to: "@@")
        let deletionStr = infoSlice?.slice(from: "-", to:" ")
        let additionStr = infoSlice?.slice(from: "+", to: " ")
        
        guard
            let addArr = additionStr?.components(separatedBy: ","),
            let deleteArr = deletionStr?.components(separatedBy: ",")
            else { return [DiffLineInfo]() }
        
        let additionLine = lineInfo(
            addArr,
            operation: .addition
        )
        let deletionLine = lineInfo(
            deleteArr,
            operation: .deletion
        )
        return [additionLine,deletionLine]
    }
    
    private func lineInfo(_ arr:[String],operation:DiffOperation)->DiffLineInfo {
        guard
            let start = arr.first,
            let number = arr.last
            else {
                return DiffLineInfo(
                    operation: .addition,
                    startLine: 0,
                    numberofLines: 0
                )
        }
        return DiffLineInfo(
            operation: operation,
            startLine: Int(start)!,
            numberofLines: Int(number)!
        )
    }
    
    private func buildLines(start:Int,end:Int)->[DiffLine] {
        var lines = [DiffLine]()
        for index in start...end {
            let line = rawLines[index]
            let diffLine = DiffLine(
                lineNum: index,
                body: line,
                operation: operationForLine(line)
            )
            lines.append(diffLine)
        }
        return lines
    }
    
    private func operationForLine(_ line:String)->DiffOperation {
        if line.hasPrefix("+") {
            return .addition
        } else if line.hasPrefix("-") {
            return .deletion
        }
        return .none
    }
    
}
