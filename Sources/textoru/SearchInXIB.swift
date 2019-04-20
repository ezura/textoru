//
//  SearchInXIB.swift
//  textoru
//
//  Created by yuka ezura on 2019/04/20.
//

import Foundation
import Files

class TextVisitorForXIB: NSObject {
    
    // attributes containing text of UILabel, UIButton, ...
    private let textHolderKeys = ["title", "text"]
    
    private let targetFile: File
    private var foundTexts: [FoundText] = []
    
    init(targetFile: File) {
        self.targetFile = targetFile
    }
    
    func visit() -> [FoundText] {
        foundTexts = []
        
        guard let xmlParser = XMLParser(contentsOf: URL(fileURLWithPath: targetFile.path)) else {
            preconditionFailure("error: \(targetFile.path) is not found.")
        }
        xmlParser.delegate = self
        xmlParser.parse()
        
        return foundTexts
    }
}

extension TextVisitorForXIB: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        for textHolderKey in textHolderKeys {
            if let text = attributeDict[textHolderKey] {
                let foundText = FoundText(filename: targetFile.name,
                                          position: "\(parser.lineNumber):\(parser.columnNumber)",
                                          text: text)
                foundTexts.append(foundText)
            } 
        }
    }
}
