//
//  FileVisitor.swift
//  textoru
//
//  Created by yuka ezura on 2019/04/20.
//

import Foundation
import Files

class FileVisitor {
    typealias OnFoundBlock = (File) -> Void
    
    func visit(directoryOrFilePath rootPath: String, fileExtensions: String..., onFound: OnFoundBlock) {
        for fileExtension in fileExtensions {
            visit(directoryOrFilePath: rootPath, fileExtension: fileExtension, onFound: onFound)
        }
    }
    
    func visit(directoryOrFilePath rootPath: String, fileExtension: String, onFound: OnFoundBlock) {
        let currentFolder = FileSystem().currentFolder
        
        if let folder = try? currentFolder.subfolder(atPath: rootPath) {
            for file in folder.makeFileSequence(recursive: true, includeHidden: false) where file.extension == fileExtension {
                onFound(file)
            }
        } else if let file = try? currentFolder.file(atPath: rootPath) {
            onFound(file)
        } else {
            print("error: \(rootPath) is not found.")
        }
    }
}
