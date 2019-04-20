//
//  FoundText.swift
//  Basic
//
//  Created by yuka ezura on 2019/04/20.
//

import Foundation

struct FoundText {
    let filename: String
    let position: String
    let text: String
    
    func printSeparate(by separator: String) {
        let formedText = text.replacingOccurrences(of: #" +"#, 
                                                   with: " ",
                                                   options: .regularExpression)
                             .replacingOccurrences(of: "\n", 
                                                   with: "\\n")

        print(filename, position, formedText, separator: separator)
    }
}
