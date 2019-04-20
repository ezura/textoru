//
//  CommandRunner.swift
//  Basic
//
//  Created by yuka ezura on 2019/04/20.
//

import Foundation
import Files
import SPMUtility

class CommandRunner {
    
    func run(arguments: [String]) {
        let parser = ArgumentParser(usage: "extract texts from swift code, xib, storyboard", 
                                    overview: "extract texts from swift code, xib, storyboard. Plaese give me target file or directory")
        let argumentForPath = parser.add(positional: "path", 
                                         kind: String.self, 
                                         usage: "input file/directory path")
        
        do {
            let result = try parser.parse(Array(arguments.dropFirst()))
            if let path = result.get(argumentForPath) {
                FileVisitor().visit(directoryOrFilePath: path, fileExtension: "swift") { (file) in
                    TextFounder().run(file: file).forEach { $0.printSeparate(by: "\t") }
                }
                FileVisitor().visit(directoryOrFilePath: path, fileExtensions: "xib", "storyboard") { (file) in
                    TextVisitorForXIB(targetFile: file).visit().forEach { $0.printSeparate(by: "\t") }
                }
            }
        } catch let error as ArgumentParserError {
            print(error.description)
        } catch {
            print(error.localizedDescription)
        }
    }
}
