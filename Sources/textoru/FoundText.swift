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
        print(filename, position, text, separator: separator)
    }
}
