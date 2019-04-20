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
        let parser = ArgumentParser(usage: "[option] path", 
                                    overview: "extract texts from swift code, xib, storyboard. Plaese give me target file or directory")
        let argumentForPath = parser.add(positional: "path", 
                                         kind: String.self, 
                                         usage: "input file/directory path")
        
        let highlightOption = parser.add(option: "--highlight",
                                         shortName: "-h",
                                         kind: Bool.self,
                                         usage: "show warning highlight on Xcode when run this command at run script.")
        do {
            let result = try parser.parse(Array(arguments.dropFirst()))
            if let path = result.get(argumentForPath) {
                let shouldHighlight = result.get(highlightOption) ?? false
                FileVisitor().visit(directoryOrFilePath: path, fileExtension: "swift") { (file) in
                    TextFounder().run(file: file).forEach { 
                        $0.printSeparate(by: "\t")
                        if shouldHighlight {
                            print("\(file.path):\($0.position): warning: `\($0.text)` is here!")
                        }
                    }
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
