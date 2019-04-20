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
    
    func visit(file: File) {
        guard let xmlParser = XMLParser(contentsOf: URL(fileURLWithPath: file.path)) else {
            preconditionFailure("error: \(file.path) is not found.")
        }
        xmlParser.delegate = self
        xmlParser.parse()
    }
}

extension TextVisitorForXIB: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if let title = attributeDict["title"] {
            print(title)
        } else if let text = attributeDict["text"] {
            print(text)
        }
    }
}
